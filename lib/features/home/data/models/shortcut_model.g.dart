// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortcut_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShortcutModelAdapter extends TypeAdapter<ShortcutModel> {
  @override
  final int typeId = 3;

  @override
  ShortcutModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShortcutModel(
      hiveLabel: fields[0] as String,
      hiveImagePath: fields[1] as String,
      order: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ShortcutModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.hiveLabel)
      ..writeByte(1)
      ..write(obj.hiveImagePath)
      ..writeByte(2)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortcutModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
