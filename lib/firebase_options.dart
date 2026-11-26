import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return linux;
      default:
        throw UnsupportedError('Firebase no está configurado para esta plataforma.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBWMixAJvstg-94wGF_c3MIYBAEn7UC98Y',
    appId: '1:221940144492:web:273b68ad3ac9758ab2bb49',
    messagingSenderId: '221940144492',
    projectId: 'tp1dap-e1056',
    authDomain: 'tp1dap-e1056.firebaseapp.com',
    storageBucket: 'tp1dap-e1056.firebasestorage.app',
    measurementId: 'G-EG14KLL94P',
  );
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyPLACEHOLDERPLACEHOLDERPLACEHOLDER',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'tp3-placeholder',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyPLACEHOLDERPLACEHOLDERPLACEHOLDER',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'tp3-placeholder',
    iosBundleId: 'com.example.tp3',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyPLACEHOLDERPLACEHOLDERPLACEHOLDER',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'tp3-placeholder',
    iosBundleId: 'com.example.tp3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyPLACEHOLDERPLACEHOLDERPLACEHOLDER',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'tp3-placeholder',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyPLACEHOLDERPLACEHOLDERPLACEHOLDER',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'tp3-placeholder',
  );
}
