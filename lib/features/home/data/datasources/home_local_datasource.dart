import 'package:hive_flutter/hive_flutter.dart';
import 'package:auvnet/features/home/data/models/restaurant_model.dart';
import 'package:auvnet/features/home/data/models/service_model.dart';
import 'package:auvnet/features/home/data/models/shortcut_model.dart';

/// Abstract class defining the contract for local data operations in the home feature.
/// This interface handles caching and retrieving of restaurants, services, and shortcuts data using Hive.
abstract class HomeLocalDataSource {
  Future<List<RestaurantModel>> getCachedRestaurants();
  Future<List<ServiceModel>> getCachedServices();
  Future<List<ShortcutModel>> getCachedShortcuts();

  Future<void> cacheRestaurants(List<RestaurantModel> restaurants);
  Future<void> cacheServices(List<ServiceModel> services);
  Future<void> cacheShortcuts(List<ShortcutModel> shortcuts);
}

/// Implementation of HomeLocalDataSource that uses Hive boxes for local storage.
/// This class provides methods to cache and retrieve data for restaurants, services, and shortcuts.
class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  /// Hive box for storing restaurant data
  final Box<RestaurantModel> restaurantsBox;
  
  /// Hive box for storing service data
  final Box<ServiceModel> servicesBox;
  
  /// Hive box for storing shortcut data
  final Box<ShortcutModel> shortcutsBox;

  HomeLocalDataSourceImpl({
    required this.restaurantsBox,
    required this.servicesBox,
    required this.shortcutsBox,
  });

  /// Retrieves all cached restaurants from the Hive box
  /// Returns a list of RestaurantModel objects
  @override
  Future<List<RestaurantModel>> getCachedRestaurants() async {
    return restaurantsBox.values.toList();
  }

  /// Retrieves all cached services from the Hive box
  /// Returns a list of ServiceModel objects
  @override
  Future<List<ServiceModel>> getCachedServices() async {
    return servicesBox.values.toList();
  }

  /// Retrieves all cached shortcuts from the Hive box
  /// Returns a list of ShortcutModel objects
  @override
  Future<List<ShortcutModel>> getCachedShortcuts() async {
    return shortcutsBox.values.toList();
  }

  /// Caches a list of restaurants in the Hive box
  /// Clears existing data before adding new restaurants
  @override
  Future<void> cacheRestaurants(List<RestaurantModel> restaurants) async {
    await restaurantsBox.clear();
    await restaurantsBox.addAll(restaurants);
  }

  /// Caches a list of services in the Hive box
  /// Clears existing data before adding new services
  @override
  Future<void> cacheServices(List<ServiceModel> services) async {
    await servicesBox.clear();
    await servicesBox.addAll(services);
  }

  /// Caches a list of shortcuts in the Hive box
  /// Clears existing data before adding new shortcuts
  @override
  Future<void> cacheShortcuts(List<ShortcutModel> shortcuts) async {
    await shortcutsBox.clear();
    await shortcutsBox.addAll(shortcuts);
  }
}
