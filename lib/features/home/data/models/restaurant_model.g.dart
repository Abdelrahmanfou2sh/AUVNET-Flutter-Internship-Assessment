// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestaurantModelAdapter extends TypeAdapter<RestaurantModel> {
  @override
  final int typeId = 1;

  @override
  RestaurantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestaurantModel(
      hiveName: fields[0] as String,
      hiveImageUrl: fields[1] as String,
      hiveTime: fields[2] as String,
      order: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RestaurantModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.hiveName)
      ..writeByte(1)
      ..write(obj.hiveImageUrl)
      ..writeByte(2)
      ..write(obj.hiveTime)
      ..writeByte(3)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
