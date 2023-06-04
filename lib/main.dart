import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/firebase_options.dart';
import 'package:firebase_crud/screens/to_do_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider()..listenToTasks(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TodoListScreen(),
      ),
    );
  }
}

class Auth extends ChangeNotifier {
  bool isLoggedIn = false;
  String? userEmail;

  void login(String email, String password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      isLoggedIn = true;
      userEmail = user.user!.email;
      notifyListeners();
    }).catchError((error) {
      print(error);
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    isLoggedIn = false;
    userEmail = null;
    notifyListeners();
  }
}
