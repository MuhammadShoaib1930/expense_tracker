// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expanses_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpansesModelAdapter extends TypeAdapter<ExpansesModel> {
  @override
  final int typeId = 0;

  @override
  ExpansesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpansesModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      prices: fields[2] as double,
      dateTime: fields[3] as DateTime,
      updated: fields[4] as int,
      isDone: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ExpansesModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.prices)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.updated)
      ..writeByte(5)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpansesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
