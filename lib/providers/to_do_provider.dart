import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  bool isLoading = true;

  Future<void> addTask(
      String title, String description, BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .add({
        'title': title,
        'description': description,
        'isCompleted': false,
      });
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => AlertDialogWidget(
                text: error.toString(),
                context: context,
              ));
    }
  }

  Future<void> updateTask(String taskId, String title, String description,
      BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId)
          .update({
        'title': title,
        'description': description,
      });
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => AlertDialogWidget(
                text: error.toString(),
                context: context,
              ));
    }
  }

  Future<void> updateTaskCompletion(String uids, String taskId,
      bool isCompleted, BuildContext context) async {
    final String uid = uids;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId)
          .update({
        'isCompleted': isCompleted,
      });
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => AlertDialogWidget(
                text: error.toString(),
                context: context,
              ));
    }
  }

  Future<void> deleteTask(
      String uids, String taskId, BuildContext context) async {
    final String uid = uids;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => AlertDialogWidget(
                text: error.toString(),
                context: context,
              ));
    }
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void listenToTasks() {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    setLoading(true);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .snapshots()
        .listen((snapshot) {
      setLoading(false);
    });
  }
}
