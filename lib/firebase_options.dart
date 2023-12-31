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
    apiKey: 'AIzaSyDB8lBp7ofrsXpcNpBZyrIYsLowIhVryJo',
    appId: '1:2348967712:web:4537286373f83504aa1945',
    messagingSenderId: '2348967712',
    projectId: 'agrimart-online-crops-auction',
    authDomain: 'agrimart-online-crops-auction.firebaseapp.com',
    databaseURL: 'https://agrimart-online-crops-auction-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'agrimart-online-crops-auction.appspot.com',
    measurementId: 'G-R4VS9L30JC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAE5qhWaJ17MGuTUZ_K2u1qZgbRc1KDA-0',
    appId: '1:2348967712:android:3e80ea5bdca06839aa1945',
    messagingSenderId: '2348967712',
    projectId: 'agrimart-online-crops-auction',
    databaseURL: 'https://agrimart-online-crops-auction-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'agrimart-online-crops-auction.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCE21ZPa3FervfcDLPuLYZ6DfW5jlVypkc',
    appId: '1:2348967712:ios:e69dcf17ee4a9e52aa1945',
    messagingSenderId: '2348967712',
    projectId: 'agrimart-online-crops-auction',
    databaseURL: 'https://agrimart-online-crops-auction-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'agrimart-online-crops-auction.appspot.com',
    iosBundleId: 'com.example.agrimart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCE21ZPa3FervfcDLPuLYZ6DfW5jlVypkc',
    appId: '1:2348967712:ios:588eede482d39a02aa1945',
    messagingSenderId: '2348967712',
    projectId: 'agrimart-online-crops-auction',
    databaseURL: 'https://agrimart-online-crops-auction-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'agrimart-online-crops-auction.appspot.com',
    iosBundleId: 'com.example.agrimart.RunnerTests',
  );
}
