import 'package:auvnet/features/home/domain/entities/restaurant.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'restaurant_model.g.dart';

/// RestaurantModel is a data model class that extends the Restaurant entity and implements Hive persistence.
/// It is used to store restaurant information in local storage using Hive.
/// The class includes fields for name, image URL, time, and optional order.
@HiveType(typeId: 1)
class RestaurantModel extends Restaurant {
  /// The name of the restaurant stored in Hive
  @HiveField(0)
  final String hiveName;

  /// The image URL of the restaurant stored in Hive
  @HiveField(1)
  final String hiveImageUrl;

  /// The opening/closing time of the restaurant stored in Hive
  @HiveField(2)
  final String hiveTime;

  /// Optional order field to determine the display sequence
  @HiveField(3)
  final int? order;

  const RestaurantModel({
    required this.hiveName,
    required this.hiveImageUrl,
    required this.hiveTime,
    this.order,
  }) : super(name: hiveName, imageUrl: hiveImageUrl, time: hiveTime);

  /// Creates a RestaurantModel instance from a Restaurant entity
  /// Used when converting domain entity to data model for storage
  factory RestaurantModel.fromEntity(Restaurant entity) => RestaurantModel(
    hiveName: entity.name,
    hiveImageUrl: entity.imageUrl,
    hiveTime: entity.time,
  );

  /// Converts this RestaurantModel back to a Restaurant entity
  /// Used when retrieving data from storage and converting to domain entity
  Restaurant toEntity() =>
      Restaurant(name: hiveName, imageUrl: hiveImageUrl, time: hiveTime);

  /// Creates a RestaurantModel instance from Firestore document data
  /// Used when fetching restaurant data from Firebase Firestore
  factory RestaurantModel.fromFirestore(Map<String, dynamic> json) {
    debugPrint('🔥 Converting Firestore doc: $json');
    return RestaurantModel(
      hiveName: json['name'] ?? '',
      hiveImageUrl: json['imageUrl'] ?? '',
      hiveTime: json['time'] ?? '',
      order: json['order'],
    );
  }
}
