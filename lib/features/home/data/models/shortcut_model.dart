import 'package:auvnet/features/home/domain/entities/shortcut.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'shortcut_model.g.dart';

/// ShortcutModel is a data model class that extends the Shortcut entity and implements Hive persistence.
/// It is used to store shortcut information in local storage using Hive.
/// The class includes fields for label, image path, and optional order.
@HiveType(typeId: 3)
class ShortcutModel extends Shortcut {
  /// The label of the shortcut stored in Hive
  @HiveField(0)
  final String hiveLabel;

  /// The image path of the shortcut stored in Hive
  @HiveField(1)
  final String hiveImagePath;

  /// Optional order field to determine the display sequence
  @HiveField(2)
  final int? order;

  const ShortcutModel({
    required this.hiveLabel,
    required this.hiveImagePath,
    this.order,
  }) : super(label: hiveLabel, imagePath: hiveImagePath);

  /// Creates a ShortcutModel instance from a Shortcut entity
  /// Used when converting domain entity to data model for storage
  factory ShortcutModel.fromEntity(Shortcut entity) =>
      ShortcutModel(hiveLabel: entity.label, hiveImagePath: entity.imagePath);

  /// Converts this ShortcutModel back to a Shortcut entity
  /// Used when retrieving data from storage and converting to domain entity
  Shortcut toEntity() => Shortcut(label: hiveLabel, imagePath: hiveImagePath);

  /// Creates a ShortcutModel instance from Firestore document data
  /// Used when fetching shortcut data from Firebase Firestore
  factory ShortcutModel.fromFireStore(Map<String, dynamic> json) {
    return ShortcutModel(
      hiveLabel: json['label'] ?? '',
      hiveImagePath: json['imagePath'] ?? '',
      order: json['order'],
    );
  }
}
