import 'package:firebase_crud/screens/signup_screen.dart';
import 'package:firebase_crud/screens/to_do_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                email = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              onChanged: (value) {
                password = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _auth
                      .signInWithEmailAndPassword(
                          email: email!, password: password!)
                      .then((user) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ToDoScreen(),
                      ),
                    );
                  }).catchError((error) {
                    print(error);
                  });
                }
              },
              child: Text('Login'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                },
                child: Text('Signup'))
          ],
        ),
      ),
    );
  }
}
