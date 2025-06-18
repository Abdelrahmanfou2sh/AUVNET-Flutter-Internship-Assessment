import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auvnet/features/home/data/models/restaurant_model.dart';
import 'package:auvnet/features/home/data/models/service_model.dart';
import 'package:auvnet/features/home/data/models/shortcut_model.dart';
import 'package:flutter/foundation.dart';

abstract class HomeRemoteDataSource {
  Future<List<RestaurantModel>> getRestaurants();
  Future<List<ServiceModel>> getServices();
  Future<List<ShortcutModel>> getShortcuts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<RestaurantModel>> getRestaurants() async {
    try {
      final snapshot = await firestore
          .collection('restaurants')
          .orderBy('order')
          .get();

      debugPrint('📦 [Restaurants] Docs count: ${snapshot.docs.length}');
      for (var doc in snapshot.docs) {
        debugPrint('📄 Restaurant doc: ${doc.data()}');
      }

      return snapshot.docs
          .map((doc) => RestaurantModel.fromFirestore(doc.data()))
          .toList();
    } catch (e, stack) {
      debugPrint('❌ Error fetching restaurants: $e');
      debugPrint('🪵 Stack trace:\n$stack');
      return [];
    }
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final snapshot = await firestore
          .collection('services')
          .orderBy('order')
          .get();

      debugPrint('📦 [Services] Docs count: ${snapshot.docs.length}');
      for (var doc in snapshot.docs) {
        debugPrint('📄 Service doc: ${doc.data()}');
      }

      return snapshot.docs
          .map((doc) => ServiceModel.fromFireStore(doc.data()))
          .toList();
    } catch (e, stack) {
      debugPrint('❌ Error fetching services: $e');
      debugPrint('🪵 Stack trace:\n$stack');
      return [];
    }
  }

  @override
  Future<List<ShortcutModel>> getShortcuts() async {
    try {
      final snapshot = await firestore
          .collection('shortcuts')
          .orderBy('order')
          .get();

      debugPrint('📦 [Shortcuts] Docs count: ${snapshot.docs.length}');
      for (var doc in snapshot.docs) {
        debugPrint('📄 Shortcut doc: ${doc.data()}');
      }

      return snapshot.docs
          .map((doc) => ShortcutModel.fromFireStore(doc.data()))
          .toList();
    } catch (e, stack) {
      debugPrint('❌ Error fetching shortcuts: $e');
      debugPrint('🪵 Stack trace:\n$stack');
      return [];
    }
  }
}
