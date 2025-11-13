// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 3;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      id: fields[0] as String,
      name: fields[1] as String,
      pronouns: fields[2] as String?,
      dateOfBirth: fields[3] as DateTime?,
      partnerName: fields[4] as String?,
      relationshipStartDate: fields[5] as DateTime?,
      interests: (fields[6] as List).cast<String>(),
      cuisines: (fields[7] as List).cast<String>(),
      budgetPreference: fields[8] as int,
      partnerId: fields[9] as String?,
      onboardingComplete: fields[10] as bool,
      loveLanguages: (fields[11] as List).cast<String>(),
      giftPreferences: (fields[12] as List).cast<String>(),
      activities: (fields[13] as List).cast<String>(),
      customInterests: (fields[14] as List).cast<String>(),
      customActivities: (fields[15] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.pronouns)
      ..writeByte(3)
      ..write(obj.dateOfBirth)
      ..writeByte(4)
      ..write(obj.partnerName)
      ..writeByte(5)
      ..write(obj.relationshipStartDate)
      ..writeByte(6)
      ..write(obj.interests)
      ..writeByte(7)
      ..write(obj.cuisines)
      ..writeByte(8)
      ..write(obj.budgetPreference)
      ..writeByte(9)
      ..write(obj.partnerId)
      ..writeByte(10)
      ..write(obj.onboardingComplete)
      ..writeByte(11)
      ..write(obj.loveLanguages)
      ..writeByte(12)
      ..write(obj.giftPreferences)
      ..writeByte(13)
      ..write(obj.activities)
      ..writeByte(14)
      ..write(obj.customInterests)
      ..writeByte(15)
      ..write(obj.customActivities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
