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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAQzoWRtghdCwfoLaU24pLgQu6xoBra5n8',
    appId: '1:91080669995:web:a8a7342edc1427b720236e',
    messagingSenderId: '91080669995',
    projectId: 'ratatouille23-e8ee7',
    authDomain: 'ratatouille23-e8ee7.firebaseapp.com',
    storageBucket: 'ratatouille23-e8ee7.appspot.com',
    measurementId: 'G-SVJR9WJ4CB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCc-adZFDV9jnKc1khqPirwtfowQSaX4aQ',
    appId: '1:91080669995:android:5c590ca054f3ce0520236e',
    messagingSenderId: '91080669995',
    projectId: 'ratatouille23-e8ee7',
    storageBucket: 'ratatouille23-e8ee7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAm77sn5Ns272uAnXYlivtrmmfUUpNHMng',
    appId: '1:91080669995:ios:8b130926ea18776720236e',
    messagingSenderId: '91080669995',
    projectId: 'ratatouille23-e8ee7',
    storageBucket: 'ratatouille23-e8ee7.appspot.com',
    iosClientId: '91080669995-6o7ief51t75dfofpgcq24agfvp5kcko3.apps.googleusercontent.com',
    iosBundleId: 'com.example.ratatouille23',
  );
}
