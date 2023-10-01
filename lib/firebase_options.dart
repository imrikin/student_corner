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
    apiKey: 'AIzaSyDfjXtchDhPc_FDSZ1p9LOxcW9Zx3iBNEM',
    appId: '1:753531438374:web:70388d77a928aa47316de7',
    messagingSenderId: '753531438374',
    projectId: 'student-corner-bc4ef',
    authDomain: 'student-corner-bc4ef.firebaseapp.com',
    storageBucket: 'student-corner-bc4ef.appspot.com',
    measurementId: 'G-L8FWYY2BSY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCW3n2wtL2zrgFW9Nijq_EQ9mgd-jzDjDk',
    appId: '1:753531438374:android:3ff98f4763c32416316de7',
    messagingSenderId: '753531438374',
    projectId: 'student-corner-bc4ef',
    storageBucket: 'student-corner-bc4ef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmEJ-wgKBQiojV1GaHlzghIwd4iMwwJn4',
    appId: '1:753531438374:ios:7c502cd388b63782316de7',
    messagingSenderId: '753531438374',
    projectId: 'student-corner-bc4ef',
    storageBucket: 'student-corner-bc4ef.appspot.com',
    iosClientId: '753531438374-v0ab1bhbs0natf9430v5kanhsiq3acem.apps.googleusercontent.com',
    iosBundleId: 'com.studentcorner.studentCorner',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmEJ-wgKBQiojV1GaHlzghIwd4iMwwJn4',
    appId: '1:753531438374:ios:7c502cd388b63782316de7',
    messagingSenderId: '753531438374',
    projectId: 'student-corner-bc4ef',
    storageBucket: 'student-corner-bc4ef.appspot.com',
    iosClientId: '753531438374-v0ab1bhbs0natf9430v5kanhsiq3acem.apps.googleusercontent.com',
    iosBundleId: 'com.studentcorner.studentCorner',
  );
}
