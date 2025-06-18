import 'package:auvnet/features/home/domain/entities/service.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'service_model.g.dart';

/// ServiceModel is a data model class that extends the Service entity and implements Hive persistence.
/// It is used to store service information in local storage using Hive.
/// The class includes fields for label, image path, badge, and optional order.
@HiveType(typeId: 2)
class ServiceModel extends Service {
  /// The label of the service stored in Hive
  @HiveField(0)
  final String hiveLabel;

  /// The image path of the service stored in Hive
  @HiveField(1)
  final String hiveImagePath;

  /// The badge text of the service stored in Hive
  @HiveField(2)
  final String hiveBadge;

  /// Optional order field to determine the display sequence
  @HiveField(3)
  final int? order;

  const ServiceModel({
    required this.hiveLabel,
    required this.hiveImagePath,
    required this.hiveBadge,
    this.order,
  }) : super(label: hiveLabel, imagePath: hiveImagePath, badge: hiveBadge);

  /// Creates a ServiceModel instance from a Service entity
  /// Used when converting domain entity to data model for storage
  factory ServiceModel.fromEntity(Service entity) => ServiceModel(
    hiveLabel: entity.label,
    hiveImagePath: entity.imagePath,
    hiveBadge: entity.badge,
  );

  /// Converts this ServiceModel back to a Service entity
  /// Used when retrieving data from storage and converting to domain entity
  Service toEntity() =>
      Service(label: hiveLabel, imagePath: hiveImagePath, badge: hiveBadge);

  /// Creates a ServiceModel instance from Firestore document data
  /// Used when fetching service data from Firebase Firestore
  factory ServiceModel.fromFireStore(Map<String, dynamic> json) {
    return ServiceModel(
      hiveLabel: json['label'] ?? '',
      hiveImagePath: json['imagePath'] ?? '',
      hiveBadge: json['badge'] ?? '',
      order: json['order'],
    );
  }
}
