import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
      required String name}) async {
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
    } catch (e) {
      // Handle signup error
      print('Signup error: $e');
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } catch (e) {
      // Handle login error
      print('Login error: $e');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _user = null;
    notifyListeners();
  }
}
