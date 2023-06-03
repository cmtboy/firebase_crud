// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDH7WXIYhZtgplfbdWdEPfj5N57bincTcw',
    appId: '1:339208613585:web:fc553e9ed3575cf8d41ff0',
    messagingSenderId: '339208613585',
    projectId: 'fir-crud-6f5a0',
    authDomain: 'fir-crud-6f5a0.firebaseapp.com',
    storageBucket: 'fir-crud-6f5a0.appspot.com',
    measurementId: 'G-7BSD9SYSBK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuC1bRmQDH2pjRjFqnN82-fjgpVXZwUeQ',
    appId: '1:339208613585:android:79c49aeed865ee45d41ff0',
    messagingSenderId: '339208613585',
    projectId: 'fir-crud-6f5a0',
    storageBucket: 'fir-crud-6f5a0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2X0asPbKMGea2KB2y0GgqY4wXmsVgDQg',
    appId: '1:339208613585:ios:207818b450a46dcfd41ff0',
    messagingSenderId: '339208613585',
    projectId: 'fir-crud-6f5a0',
    storageBucket: 'fir-crud-6f5a0.appspot.com',
    iosClientId: '339208613585-pl1ip6o3tf52irnuj1qktvo1ee3ifidm.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseCrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC2X0asPbKMGea2KB2y0GgqY4wXmsVgDQg',
    appId: '1:339208613585:ios:207818b450a46dcfd41ff0',
    messagingSenderId: '339208613585',
    projectId: 'fir-crud-6f5a0',
    storageBucket: 'fir-crud-6f5a0.appspot.com',
    iosClientId: '339208613585-pl1ip6o3tf52irnuj1qktvo1ee3ifidm.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseCrud',
  );
}