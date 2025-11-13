import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_profile.g.dart';

@HiveType(typeId: 3)
class UserProfile extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? pronouns;

  @HiveField(3)
  final DateTime? dateOfBirth;

  @HiveField(4)
  final String? partnerName;

  @HiveField(5)
  final DateTime? relationshipStartDate;

  @HiveField(6)
  final List<String> interests;

  @HiveField(7)
  final List<String> cuisines;

  @HiveField(8)
  final int budgetPreference; // 1-3

  @HiveField(9)
  final String? partnerId;

  @HiveField(10)
  final bool onboardingComplete;

  @HiveField(11)
  final List<String> loveLanguages;

  @HiveField(12)
  final List<String> giftPreferences;

  @HiveField(13)
  final List<String> activities;

  @HiveField(14)
  final List<String> customInterests;

  @HiveField(15)
  final List<String> customActivities;

  const UserProfile({
    required this.id,
    required this.name,
    this.pronouns,
    this.dateOfBirth,
    this.partnerName,
    this.relationshipStartDate,
    this.interests = const [],
    this.cuisines = const [],
    this.budgetPreference = 2,
    this.partnerId,
    this.onboardingComplete = false,
    this.loveLanguages = const [],
    this.giftPreferences = const [],
    this.activities = const [],
    this.customInterests = const [],
    this.customActivities = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        pronouns,
        dateOfBirth,
        partnerName,
        relationshipStartDate,
        interests,
        cuisines,
        budgetPreference,
        partnerId,
        onboardingComplete,
        loveLanguages,
        giftPreferences,
        activities,
        customInterests,
        customActivities,
      ];

  UserProfile copyWith({
    String? id,
    String? name,
    String? pronouns,
    DateTime? dateOfBirth,
    String? partnerName,
    DateTime? relationshipStartDate,
    List<String>? interests,
    List<String>? cuisines,
    int? budgetPreference,
    String? partnerId,
    bool? onboardingComplete,
    List<String>? loveLanguages,
    List<String>? giftPreferences,
    List<String>? activities,
    List<String>? customInterests,
    List<String>? customActivities,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      pronouns: pronouns ?? this.pronouns,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      partnerName: partnerName ?? this.partnerName,
      relationshipStartDate: relationshipStartDate ?? this.relationshipStartDate,
      interests: interests ?? this.interests,
      cuisines: cuisines ?? this.cuisines,
      budgetPreference: budgetPreference ?? this.budgetPreference,
      partnerId: partnerId ?? this.partnerId,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      loveLanguages: loveLanguages ?? this.loveLanguages,
      giftPreferences: giftPreferences ?? this.giftPreferences,
      activities: activities ?? this.activities,
      customInterests: customInterests ?? this.customInterests,
      customActivities: customActivities ?? this.customActivities,
    );
  }
}
