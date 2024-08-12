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
    apiKey: 'AIzaSyDi0yUaoOXwelcN6yJO_pHLncJGFJtcb6c',
    appId: '1:625068150632:web:242cc2447c10f6269ed0dd',
    messagingSenderId: '625068150632',
    projectId: 'hyella-telehealth',
    authDomain: 'hyella-telehealth.firebaseapp.com',
    storageBucket: 'hyella-telehealth.appspot.com',
    measurementId: 'G-0YK4VDTL90',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBULmZFatt6cMj_mmasfvs9YGJEEBImPu0',
    appId: '1:625068150632:android:538f58506eade54d9ed0dd',
    messagingSenderId: '625068150632',
    projectId: 'hyella-telehealth',
    storageBucket: 'hyella-telehealth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuI-67ETv-wu_EicqRJBjNXg94rybJGQ0',
    appId: '1:625068150632:ios:baad07225189c9409ed0dd',
    messagingSenderId: '625068150632',
    projectId: 'hyella-telehealth',
    storageBucket: 'hyella-telehealth.appspot.com',
    iosBundleId: 'com.example.hyellaTelehealth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuI-67ETv-wu_EicqRJBjNXg94rybJGQ0',
    appId: '1:625068150632:ios:baad07225189c9409ed0dd',
    messagingSenderId: '625068150632',
    projectId: 'hyella-telehealth',
    storageBucket: 'hyella-telehealth.appspot.com',
    iosBundleId: 'com.example.hyellaTelehealth',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDi0yUaoOXwelcN6yJO_pHLncJGFJtcb6c',
    appId: '1:625068150632:web:e1c7563fdde224b09ed0dd',
    messagingSenderId: '625068150632',
    projectId: 'hyella-telehealth',
    authDomain: 'hyella-telehealth.firebaseapp.com',
    storageBucket: 'hyella-telehealth.appspot.com',
    measurementId: 'G-X0KT2BWNWY',
  );

}