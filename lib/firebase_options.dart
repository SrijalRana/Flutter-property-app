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
    apiKey: 'AIzaSyDQ1mVMjocwyOIE2Obv_IxKyG7F4c_bZPY',
    appId: '1:671918980573:web:a7608fd677391014f44a34',
    messagingSenderId: '671918980573',
    projectId: 'home-7ded2',
    authDomain: 'home-7ded2.firebaseapp.com',
    storageBucket: 'home-7ded2.appspot.com',
    measurementId: 'G-291QV7D3XR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCK6ENqwfb1LkANd-tBmGze-Dkp_7daWeQ',
    appId: '1:671918980573:android:03032676b14d3145f44a34',
    messagingSenderId: '671918980573',
    projectId: 'home-7ded2',
    storageBucket: 'home-7ded2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7AvrVMWudqM2439n4H6tEJZrAyN1maMM',
    appId: '1:671918980573:ios:5043ce43ab1898caf44a34',
    messagingSenderId: '671918980573',
    projectId: 'home-7ded2',
    storageBucket: 'home-7ded2.appspot.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7AvrVMWudqM2439n4H6tEJZrAyN1maMM',
    appId: '1:671918980573:ios:6e877afeb9838667f44a34',
    messagingSenderId: '671918980573',
    projectId: 'home-7ded2',
    storageBucket: 'home-7ded2.appspot.com',
    iosBundleId: 'com.example.app.RunnerTests',
  );
}
