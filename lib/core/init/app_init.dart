import 'package:auvnet/features/home/data/models/restaurant_model.dart';
import 'package:auvnet/features/home/data/models/service_model.dart';
import 'package:auvnet/features/home/data/models/shortcut_model.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/data/models/user_model.dart';
import '../di/service_locator.dart';
import '../../../firebase_options.dart';

class AppInit {
  /// Initializes all necessary tools before the app runs.
  static Future<void> init() async {
    // Ensure Flutter engine is initialized before any async calls
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Hive
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(RestaurantModelAdapter());
    Hive.registerAdapter(ServiceModelAdapter());
    Hive.registerAdapter(ShortcutModelAdapter());

    // Initialize Dependency Injection
    await initServiceLocator();
  }
}
