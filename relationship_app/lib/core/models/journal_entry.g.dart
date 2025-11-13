// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalEntryAdapter extends TypeAdapter<JournalEntry> {
  @override
  final int typeId = 0;

  @override
  JournalEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalEntry(
      id: fields[0] as String,
      space: fields[1] as JournalSpace,
      createdAt: fields[2] as DateTime,
      mood: fields[3] as Mood,
      text: fields[4] as String,
      tags: (fields[5] as List).cast<String>(),
      shareWithPartner: fields[6] as bool,
      sentiment: fields[7] as double,
      entities: (fields[8] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, JournalEntry obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.space)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.mood)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.shareWithPartner)
      ..writeByte(7)
      ..write(obj.sentiment)
      ..writeByte(8)
      ..write(obj.entities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class JournalSpaceAdapter extends TypeAdapter<JournalSpace> {
  @override
  final int typeId = 1;

  @override
  JournalSpace read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return JournalSpace.me;
      case 1:
        return JournalSpace.aboutPartner;
      default:
        return JournalSpace.me;
    }
  }

  @override
  void write(BinaryWriter writer, JournalSpace obj) {
    switch (obj) {
      case JournalSpace.me:
        writer.writeByte(0);
        break;
      case JournalSpace.aboutPartner:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalSpaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MoodAdapter extends TypeAdapter<Mood> {
  @override
  final int typeId = 2;

  @override
  Mood read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Mood.amazing;
      case 1:
        return Mood.good;
      case 2:
        return Mood.okay;
      case 3:
        return Mood.down;
      case 4:
        return Mood.upset;
      default:
        return Mood.amazing;
    }
  }

  @override
  void write(BinaryWriter writer, Mood obj) {
    switch (obj) {
      case Mood.amazing:
        writer.writeByte(0);
        break;
      case Mood.good:
        writer.writeByte(1);
        break;
      case Mood.okay:
        writer.writeByte(2);
        break;
      case Mood.down:
        writer.writeByte(3);
        break;
      case Mood.upset:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
