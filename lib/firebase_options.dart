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
    apiKey: 'AIzaSyDxVxUVbt0kbTCCEzStEMBrn1G-TOikH6s',
    appId: '1:14385955351:web:84db92266c229668b35252',
    messagingSenderId: '14385955351',
    projectId: 'fir-crud-85c80',
    authDomain: 'fir-crud-85c80.firebaseapp.com',
    storageBucket: 'fir-crud-85c80.appspot.com',
    measurementId: 'G-J9SN7BFPMK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5f3_X-KGcgmPHUCwHlHDXUSdTPzO0GLc',
    appId: '1:14385955351:android:82db849b8568434db35252',
    messagingSenderId: '14385955351',
    projectId: 'fir-crud-85c80',
    storageBucket: 'fir-crud-85c80.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALVELx3-6lnVWe0sf_BP5yCNnt6qZRDl0',
    appId: '1:14385955351:ios:6eb7581fca47025db35252',
    messagingSenderId: '14385955351',
    projectId: 'fir-crud-85c80',
    storageBucket: 'fir-crud-85c80.appspot.com',
    iosClientId: '14385955351-3mo5g9icm6983blvq0ut5j57dnh4926o.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyALVELx3-6lnVWe0sf_BP5yCNnt6qZRDl0',
    appId: '1:14385955351:ios:6eb7581fca47025db35252',
    messagingSenderId: '14385955351',
    projectId: 'fir-crud-85c80',
    storageBucket: 'fir-crud-85c80.appspot.com',
    iosClientId: '14385955351-3mo5g9icm6983blvq0ut5j57dnh4926o.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterApplication1',
  );
}