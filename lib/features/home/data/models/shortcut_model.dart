import 'package:auvnet/features/home/domain/entities/shortcut.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'shortcut_model.g.dart';

@HiveType(typeId: 3)
class ShortcutModel extends Shortcut {
  @HiveField(0)
  final String hiveLabel;

  @HiveField(1)
  final String hiveImagePath;

  @HiveField(2)
  final int? order;

  const ShortcutModel({
    required this.hiveLabel,
    required this.hiveImagePath,
    this.order,
  }) : super(label: hiveLabel, imagePath: hiveImagePath);

  factory ShortcutModel.fromEntity(Shortcut entity) =>
      ShortcutModel(hiveLabel: entity.label, hiveImagePath: entity.imagePath);

  Shortcut toEntity() => Shortcut(label: hiveLabel, imagePath: hiveImagePath);

  factory ShortcutModel.fromFireStore(Map<String, dynamic> json) {
    return ShortcutModel(
      hiveLabel: json['label'] ?? '',
      hiveImagePath: json['imagePath'] ?? '',
      order: json['order'],
    );
  }
}
