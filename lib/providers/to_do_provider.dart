import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  bool isLoading = true;

  Future<void> addTask(String title, String description) async {
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
      print('Error adding task: $error');
    }
  }

  Future<void> updateTask(
      String taskId, String title, String description) async {
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
      print('Error updating task: $error');
    }
  }

  Future<void> updateTaskCompletion(
      String uids, String taskId, bool isCompleted) async {
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
      print('Error updating task completion: $error');
    }
  }

  Future<void> deleteTask(String uids, String taskId) async {
    final String uid = uids;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(taskId)
          .delete();
    } catch (error) {
      print('Error deleting task: $error');
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
