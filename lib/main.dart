import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/firebase_options.dart';
import 'package:firebase_crud/providers/auth_provider.dart';
import 'package:firebase_crud/providers/to_do_provider.dart';
import 'package:firebase_crud/screens/to_do_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider<TodoProvider>(
            create: (_) => TodoProvider()..listenToTasks(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Consumer<AuthProvider>(builder: (_, authProvider, __) {
            if (authProvider.isLoggedIn) {
              return const TodoListScreen();
            } else {
              return const LoginScreen();
            }
          }),
        ));
  }
}
