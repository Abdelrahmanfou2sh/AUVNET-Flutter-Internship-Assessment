import 'package:auvnet/features/home/domain/entities/restaurant.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'restaurant_model.g.dart';

@HiveType(typeId: 1)
class RestaurantModel extends Restaurant {
  @HiveField(0)
  final String hiveName;

  @HiveField(1)
  final String hiveImageUrl;

  @HiveField(2)
  final String hiveTime;

  @HiveField(3)
  final int? order;

  const RestaurantModel({
    required this.hiveName,
    required this.hiveImageUrl,
    required this.hiveTime,
    this.order,
  }) : super(name: hiveName, imageUrl: hiveImageUrl, time: hiveTime);

  factory RestaurantModel.fromEntity(Restaurant entity) => RestaurantModel(
    hiveName: entity.name,
    hiveImageUrl: entity.imageUrl,
    hiveTime: entity.time,
  );

  Restaurant toEntity() =>
      Restaurant(name: hiveName, imageUrl: hiveImageUrl, time: hiveTime);

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
