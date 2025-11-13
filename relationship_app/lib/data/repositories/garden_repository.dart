import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../core/models/garden_session.dart';

class GardenRepository {
  static const String _sessionsBoxName = 'garden_sessions';
  static const String _progressBoxName = 'garden_progress';
  late Box<GardenSession> _sessionsBox;
  late Box<GardenProgress> _progressBox;
  final _uuid = const Uuid();

  Future<void> initialize() async {
    _sessionsBox = await Hive.openBox<GardenSession>(_sessionsBoxName);
    _progressBox = await Hive.openBox<GardenProgress>(_progressBoxName);
  }

  // Sessions
  Future<String> createSession(GardenSession session) async {
    final sessionWithId = session.copyWith(
      id: session.id.isEmpty ? _uuid.v4() : session.id,
    );
    await _sessionsBox.put(sessionWithId.id, sessionWithId);
    return sessionWithId.id;
  }

  Future<void> updateSession(GardenSession session) async {
    await _sessionsBox.put(session.id, session);
  }

  GardenSession? getSession(String id) {
    return _sessionsBox.get(id);
  }

  List<GardenSession> getAllSessions() {
    return _sessionsBox.values.toList()
      ..sort((a, b) => b.startTime.compareTo(a.startTime));
  }

  List<GardenSession> getRecentSessions({int limit = 10}) {
    final sessions = getAllSessions();
    return sessions.take(limit).toList();
  }

  // Progress
  GardenProgress getProgress() {
    return _progressBox.get('current_progress') ?? const GardenProgress();
  }

  Future<void> saveProgress(GardenProgress progress) async {
    await _progressBox.put('current_progress', progress);
  }

  Future<void> addSessionToProgress(GardenSession session) async {
    final currentProgress = getProgress();
    final newTotalMinutes = currentProgress.totalMinutes + session.durationMinutes;
    
    // Calculate new level (every 60 minutes = 1 level)
    final newLevel = newTotalMinutes ~/ 60;
    
    // Check for streak
    final sessions = getAllSessions();
    final confirmedSessions = sessions.where((s) => s.confirmed).toList();
    
    int newStreak = 1;
    if (confirmedSessions.length > 1) {
      final lastSession = confirmedSessions[0];
      final daysDiff = session.startTime.difference(lastSession.startTime).inDays;
      if (daysDiff == 1) {
        newStreak = currentProgress.currentStreak + 1;
      } else if (daysDiff > 1) {
        newStreak = 1;
      } else {
        newStreak = currentProgress.currentStreak;
      }
    }

    final newLongestStreak = newStreak > currentProgress.longestStreak
        ? newStreak
        : currentProgress.longestStreak;

    // Check for achievements
    final achievements = List<String>.from(currentProgress.achievements);
    if (newTotalMinutes >= 60 && !achievements.contains('first_hour')) {
      achievements.add('first_hour');
    }
    if (newStreak >= 7 && !achievements.contains('week_streak')) {
      achievements.add('week_streak');
    }
    if (newTotalMinutes >= 600 && !achievements.contains('10_hours')) {
      achievements.add('10_hours');
    }

    final updatedProgress = GardenProgress(
      totalMinutes: newTotalMinutes,
      currentStreak: newStreak,
      longestStreak: newLongestStreak,
      achievements: achievements,
      level: newLevel,
    );

    await saveProgress(updatedProgress);
  }

  Future<void> clearAll() async {
    await _sessionsBox.clear();
    await _progressBox.clear();
  }
}
