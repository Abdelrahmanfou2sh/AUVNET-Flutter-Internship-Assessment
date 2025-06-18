import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Firebase is not configured for web. Run FlutterFire CLI to generate web config.',
      );
    }

    final apiKey = dotenv.env['GOOGLE_API_KEY'];
    final projectId = dotenv.env['FIREBASE_PROJECT_ID'];
    final appId = dotenv.env['FIREBASE_APP_ID'];
    final messagingSenderId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'];
    final storageBucket = dotenv.env['FIREBASE_STORAGE_BUCKET']; // Optional

    if ([apiKey, projectId, appId, messagingSenderId].contains(null)) {
      throw Exception(
        '❌ Missing one or more Firebase config values in .env file.',
      );
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return FirebaseOptions(
          apiKey: apiKey!,
          appId: appId!,
          messagingSenderId: messagingSenderId!,
          projectId: projectId!,
          storageBucket: storageBucket ?? '',
        );
      default:
        throw UnsupportedError(
          'This platform is not yet supported in firebase_options.dart',
        );
    }
  }
}
