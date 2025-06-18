// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceModelAdapter extends TypeAdapter<ServiceModel> {
  @override
  final int typeId = 2;

  @override
  ServiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceModel(
      hiveLabel: fields[0] as String,
      hiveImagePath: fields[1] as String,
      hiveBadge: fields[2] as String,
      order: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.hiveLabel)
      ..writeByte(1)
      ..write(obj.hiveImagePath)
      ..writeByte(2)
      ..write(obj.hiveBadge)
      ..writeByte(3)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
