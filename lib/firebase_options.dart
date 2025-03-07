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
    apiKey: 'AIzaSyD7cfw3W_Sty-krvnybGqPV9ChxbaKyBOs',
    appId: '1:715657854719:web:fce879ddb3c349903e56ca',
    messagingSenderId: '715657854719',
    projectId: 'tpc-app-dc3ca',
    authDomain: 'tpc-app-dc3ca.firebaseapp.com',
    storageBucket: 'tpc-app-dc3ca.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuPw0c_qfU8ZpLdjG79LCyDIR8MJIXxVc',
    appId: '1:715657854719:android:b1864876b53b53963e56ca',
    messagingSenderId: '715657854719',
    projectId: 'tpc-app-dc3ca',
    storageBucket: 'tpc-app-dc3ca.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDkxaZ4BnPoOGlSWVSfgoub4ppNNnQ1pEs',
    appId: '1:715657854719:ios:a07b411650a80b973e56ca',
    messagingSenderId: '715657854719',
    projectId: 'tpc-app-dc3ca',
    storageBucket: 'tpc-app-dc3ca.firebasestorage.app',
    iosBundleId: 'com.example.finalTpcApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDkxaZ4BnPoOGlSWVSfgoub4ppNNnQ1pEs',
    appId: '1:715657854719:ios:a07b411650a80b973e56ca',
    messagingSenderId: '715657854719',
    projectId: 'tpc-app-dc3ca',
    storageBucket: 'tpc-app-dc3ca.firebasestorage.app',
    iosBundleId: 'com.example.finalTpcApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD7cfw3W_Sty-krvnybGqPV9ChxbaKyBOs',
    appId: '1:715657854719:web:9404059163d8a1313e56ca',
    messagingSenderId: '715657854719',
    projectId: 'tpc-app-dc3ca',
    authDomain: 'tpc-app-dc3ca.firebaseapp.com',
    storageBucket: 'tpc-app-dc3ca.firebasestorage.app',
  );
}
