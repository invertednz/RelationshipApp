import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'garden_session.g.dart';

@HiveType(typeId: 4)
class GardenSession extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime startTime;

  @HiveField(2)
  final DateTime? endTime;

  @HiveField(3)
  final int durationMinutes;

  @HiveField(4)
  final bool confirmed;

  const GardenSession({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.durationMinutes,
    this.confirmed = false,
  });

  @override
  List<Object?> get props => [
        id,
        startTime,
        endTime,
        durationMinutes,
        confirmed,
      ];

  GardenSession copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    int? durationMinutes,
    bool? confirmed,
  }) {
    return GardenSession(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      confirmed: confirmed ?? this.confirmed,
    );
  }
}

@HiveType(typeId: 5)
class GardenProgress extends Equatable {
  @HiveField(0)
  final int totalMinutes;

  @HiveField(1)
  final int currentStreak;

  @HiveField(2)
  final int longestStreak;

  @HiveField(3)
  final List<String> achievements;

  @HiveField(4)
  final int level; // Plant growth level

  const GardenProgress({
    this.totalMinutes = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.achievements = const [],
    this.level = 0,
  });

  @override
  List<Object?> get props => [
        totalMinutes,
        currentStreak,
        longestStreak,
        achievements,
        level,
      ];

  GardenProgress copyWith({
    int? totalMinutes,
    int? currentStreak,
    int? longestStreak,
    List<String>? achievements,
    int? level,
  }) {
    return GardenProgress(
      totalMinutes: totalMinutes ?? this.totalMinutes,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      achievements: achievements ?? this.achievements,
      level: level ?? this.level,
    );
  }
}
