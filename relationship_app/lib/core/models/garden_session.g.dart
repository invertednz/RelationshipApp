// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'garden_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GardenSessionAdapter extends TypeAdapter<GardenSession> {
  @override
  final int typeId = 4;

  @override
  GardenSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GardenSession(
      id: fields[0] as String,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime?,
      durationMinutes: fields[3] as int,
      confirmed: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GardenSession obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.durationMinutes)
      ..writeByte(4)
      ..write(obj.confirmed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GardenSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GardenProgressAdapter extends TypeAdapter<GardenProgress> {
  @override
  final int typeId = 5;

  @override
  GardenProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GardenProgress(
      totalMinutes: fields[0] as int,
      currentStreak: fields[1] as int,
      longestStreak: fields[2] as int,
      achievements: (fields[3] as List).cast<String>(),
      level: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GardenProgress obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.totalMinutes)
      ..writeByte(1)
      ..write(obj.currentStreak)
      ..writeByte(2)
      ..write(obj.longestStreak)
      ..writeByte(3)
      ..write(obj.achievements)
      ..writeByte(4)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GardenProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
