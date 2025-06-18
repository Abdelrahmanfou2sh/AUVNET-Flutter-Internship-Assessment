import 'package:hive_flutter/hive_flutter.dart';
import 'package:auvnet/features/home/data/models/restaurant_model.dart';
import 'package:auvnet/features/home/data/models/service_model.dart';
import 'package:auvnet/features/home/data/models/shortcut_model.dart';

abstract class HomeLocalDataSource {
  Future<List<RestaurantModel>> getCachedRestaurants();
  Future<List<ServiceModel>> getCachedServices();
  Future<List<ShortcutModel>> getCachedShortcuts();

  Future<void> cacheRestaurants(List<RestaurantModel> restaurants);
  Future<void> cacheServices(List<ServiceModel> services);
  Future<void> cacheShortcuts(List<ShortcutModel> shortcuts);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final Box<RestaurantModel> restaurantsBox;
  final Box<ServiceModel> servicesBox;
  final Box<ShortcutModel> shortcutsBox;

  HomeLocalDataSourceImpl({
    required this.restaurantsBox,
    required this.servicesBox,
    required this.shortcutsBox,
  });

  @override
  Future<List<RestaurantModel>> getCachedRestaurants() async {
    return restaurantsBox.values.toList();
  }

  @override
  Future<List<ServiceModel>> getCachedServices() async {
    return servicesBox.values.toList();
  }

  @override
  Future<List<ShortcutModel>> getCachedShortcuts() async {
    return shortcutsBox.values.toList();
  }

  @override
  Future<void> cacheRestaurants(List<RestaurantModel> restaurants) async {
    await restaurantsBox.clear();
    await restaurantsBox.addAll(restaurants);
  }

  @override
  Future<void> cacheServices(List<ServiceModel> services) async {
    await servicesBox.clear();
    await servicesBox.addAll(services);
  }

  @override
  Future<void> cacheShortcuts(List<ShortcutModel> shortcuts) async {
    await shortcutsBox.clear();
    await shortcutsBox.addAll(shortcuts);
  }
}
