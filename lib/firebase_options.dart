// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDuWUDZv19XhTnfRHOhj7lvNiDTJ5JF5JQ',
    appId: '1:572145211961:web:8c5edcd7d44cca228e4be8',
    messagingSenderId: '572145211961',
    projectId: 'travel-social-network-ad4b0',
    authDomain: 'travel-social-network-ad4b0.firebaseapp.com',
    storageBucket: 'travel-social-network-ad4b0.appspot.com',
    measurementId: 'G-F0ZM3L769T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuhg_2G1Kzjx7jI5eic3EV63hV0hQEX5w',
    appId: '1:572145211961:android:af6308da0baa947b8e4be8',
    messagingSenderId: '572145211961',
    projectId: 'travel-social-network-ad4b0',
    storageBucket: 'travel-social-network-ad4b0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBk5ibL1h-hEhmqltqgxHJSCL7oTb6FA2E',
    appId: '1:572145211961:ios:4266b3b51b59addb8e4be8',
    messagingSenderId: '572145211961',
    projectId: 'travel-social-network-ad4b0',
    storageBucket: 'travel-social-network-ad4b0.appspot.com',
    androidClientId: '572145211961-92nsacbegmvnae8f03kshnv4mls77brj.apps.googleusercontent.com',
    iosClientId: '572145211961-26hto7t5e8ieq187idgistujsr59tdb8.apps.googleusercontent.com',
    iosBundleId: 'com.example.travelSocialNetwork',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBk5ibL1h-hEhmqltqgxHJSCL7oTb6FA2E',
    appId: '1:572145211961:ios:4266b3b51b59addb8e4be8',
    messagingSenderId: '572145211961',
    projectId: 'travel-social-network-ad4b0',
    storageBucket: 'travel-social-network-ad4b0.appspot.com',
    androidClientId: '572145211961-92nsacbegmvnae8f03kshnv4mls77brj.apps.googleusercontent.com',
    iosClientId: '572145211961-26hto7t5e8ieq187idgistujsr59tdb8.apps.googleusercontent.com',
    iosBundleId: 'com.example.travelSocialNetwork',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDuWUDZv19XhTnfRHOhj7lvNiDTJ5JF5JQ',
    appId: '1:572145211961:web:c551d08c6de886838e4be8',
    messagingSenderId: '572145211961',
    projectId: 'travel-social-network-ad4b0',
    authDomain: 'travel-social-network-ad4b0.firebaseapp.com',
    storageBucket: 'travel-social-network-ad4b0.appspot.com',
    measurementId: 'G-381MCXYQ19',
  );

}