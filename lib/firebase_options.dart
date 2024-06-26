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
    apiKey: 'AIzaSyDGmSt5f7s2ZYvYsTr94aZz29EYbXKOJB4',
    appId: '1:671558879227:web:7668ff826ca238fe90ad5e',
    messagingSenderId: '671558879227',
    projectId: 'mwf07b',
    authDomain: 'mwf07b.firebaseapp.com',
    storageBucket: 'mwf07b.appspot.com',
    measurementId: 'G-JH1JN6QCXS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFHuf4xUzc9F6YkaCtSazWqeMELoZ-UM8',
    appId: '1:671558879227:android:8a6c139c5bffd05e90ad5e',
    messagingSenderId: '671558879227',
    projectId: 'mwf07b',
    storageBucket: 'mwf07b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOyMPc609qYpzFddAV_0rLMIXyrP5V-Eg',
    appId: '1:671558879227:ios:a3710ba4d99e6cfe90ad5e',
    messagingSenderId: '671558879227',
    projectId: 'mwf07b',
    storageBucket: 'mwf07b.appspot.com',
    iosBundleId: 'com.example.mwf07b',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOyMPc609qYpzFddAV_0rLMIXyrP5V-Eg',
    appId: '1:671558879227:ios:f9d3a56d085fa6c990ad5e',
    messagingSenderId: '671558879227',
    projectId: 'mwf07b',
    storageBucket: 'mwf07b.appspot.com',
    iosBundleId: 'com.example.mwf07b.RunnerTests',
  );
}
