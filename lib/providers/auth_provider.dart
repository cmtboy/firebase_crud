// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/services/alert_dialog.dart';
import 'package:firebase_crud/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;

  AuthProvider() {
    _init();
  }

  Future<void> _init() async {
    _user = _firebaseAuth.currentUser;
    notifyListeners();
  }

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<void> signUp(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;

      FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .set({'name': name});

      notifyListeners();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const MyBottomNavBar()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialogWidget(
                text: e.toString(),
                context: context,
              ));
    }
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialogWidget(
                text: e.toString(),
                context: context,
              ));
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _user = null;
    notifyListeners();
  }
}
