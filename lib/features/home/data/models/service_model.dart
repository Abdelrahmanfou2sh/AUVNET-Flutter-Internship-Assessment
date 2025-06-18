import 'package:auvnet/features/home/domain/entities/service.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'service_model.g.dart';

@HiveType(typeId: 2)
class ServiceModel extends Service {
  @HiveField(0)
  final String hiveLabel;

  @HiveField(1)
  final String hiveImagePath;

  @HiveField(2)
  final String hiveBadge;

  @HiveField(3)
  final int? order;

  const ServiceModel({
    required this.hiveLabel,
    required this.hiveImagePath,
    required this.hiveBadge,
    this.order,
  }) : super(label: hiveLabel, imagePath: hiveImagePath, badge: hiveBadge);

  factory ServiceModel.fromEntity(Service entity) => ServiceModel(
    hiveLabel: entity.label,
    hiveImagePath: entity.imagePath,
    hiveBadge: entity.badge,
  );

  Service toEntity() =>
      Service(label: hiveLabel, imagePath: hiveImagePath, badge: hiveBadge);

  factory ServiceModel.fromFireStore(Map<String, dynamic> json) {
    return ServiceModel(
      hiveLabel: json['label'] ?? '',
      hiveImagePath: json['imagePath'] ?? '',
      hiveBadge: json['badge'] ?? '',
      order: json['order'],
    );
  }
}
