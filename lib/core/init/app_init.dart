import 'package:auvnet/features/home/data/models/restaurant_model.dart';
import 'package:auvnet/features/home/data/models/service_model.dart';
import 'package:auvnet/features/home/data/models/shortcut_model.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/data/models/user_model.dart';
import '../di/service_locator.dart';
import '../../../firebase_options.dart';

/// Handles the initialization of core application components.
/// This includes Firebase, Hive local storage, and dependency injection setup.
class AppInit {
  /// Initializes all necessary components before the app runs.
  /// 
  /// The initialization process includes:
  /// 1. Flutter engine initialization
  /// 2. Firebase setup for backend services
  /// 3. Hive local storage configuration
  /// 4. Registration of data model adapters
  /// 5. Dependency injection setup
  static Future<void> init() async {
    // Ensure Flutter engine is initialized before any async calls
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase with platform-specific configurations
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Hive for local data persistence
    await Hive.initFlutter();
    
    // Register type adapters for Hive boxes
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(RestaurantModelAdapter());
    Hive.registerAdapter(ServiceModelAdapter());
    Hive.registerAdapter(ShortcutModelAdapter());

    // Setup dependency injection using GetIt
    await initServiceLocator();
  }
}
