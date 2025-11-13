import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/models/user_profile.dart';
import '../core/models/journal_entry.dart';
import '../core/models/garden_session.dart';
import '../data/repositories/user_repository.dart';
import '../data/repositories/journal_repository.dart';
import '../data/repositories/garden_repository.dart';
import '../data/repositories/recommendation_service.dart';

// Repository Providers
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return JournalRepository();
});

final gardenRepositoryProvider = Provider<GardenRepository>((ref) {
  return GardenRepository();
});

final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  return RecommendationService();
});

// User Profile Provider
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
  return UserProfileNotifier(ref.read(userRepositoryProvider));
});

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  final UserRepository _repository;

  UserProfileNotifier(this._repository) : super(null) {
    _loadProfile();
  }

  void _loadProfile() {
    state = _repository.getCurrentProfile();
  }

  Future<void> updateProfile(UserProfile profile) async {
    await _repository.saveProfile(profile);
    state = profile;
  }

  Future<void> completeOnboarding() async {
    if (state != null) {
      final updated = state!.copyWith(onboardingComplete: true);
      await updateProfile(updated);
    }
  }
}

// Journal Entries Provider
final journalEntriesProvider = StateNotifierProvider<JournalEntriesNotifier, List<JournalEntry>>((ref) {
  return JournalEntriesNotifier(ref.read(journalRepositoryProvider));
});

class JournalEntriesNotifier extends StateNotifier<List<JournalEntry>> {
  final JournalRepository _repository;

  JournalEntriesNotifier(this._repository) : super([]) {
    _loadEntries();
  }

  void _loadEntries() {
    state = _repository.getAllEntries();
  }

  Future<void> addEntry(JournalEntry entry) async {
    await _repository.createEntry(entry);
    _loadEntries();
  }

  Future<void> updateEntry(JournalEntry entry) async {
    await _repository.updateEntry(entry);
    _loadEntries();
  }

  Future<void> deleteEntry(String id) async {
    await _repository.deleteEntry(id);
    _loadEntries();
  }

  List<JournalEntry> getBySpace(JournalSpace space) {
    return state.where((entry) => entry.space == space).toList();
  }
}

// Garden Progress Provider
final gardenProgressProvider = StateNotifierProvider<GardenProgressNotifier, GardenProgress>((ref) {
  return GardenProgressNotifier(ref.read(gardenRepositoryProvider));
});

class GardenProgressNotifier extends StateNotifier<GardenProgress> {
  final GardenRepository _repository;

  GardenProgressNotifier(this._repository) : super(const GardenProgress()) {
    _loadProgress();
  }

  void _loadProgress() {
    state = _repository.getProgress();
  }

  Future<void> completeSession(GardenSession session) async {
    await _repository.addSessionToProgress(session);
    _loadProgress();
  }
}

// Active Garden Session Provider
final activeGardenSessionProvider = StateNotifierProvider<ActiveGardenSessionNotifier, GardenSession?>((ref) {
  return ActiveGardenSessionNotifier();
});

class ActiveGardenSessionNotifier extends StateNotifier<GardenSession?> {
  ActiveGardenSessionNotifier() : super(null);

  void startSession(String id) {
    state = GardenSession(
      id: id,
      startTime: DateTime.now(),
      durationMinutes: 0,
    );
  }

  void endSession(int durationMinutes) {
    if (state != null) {
      state = state!.copyWith(
        endTime: DateTime.now(),
        durationMinutes: durationMinutes,
        confirmed: true,
      );
    }
  }

  void clearSession() {
    state = null;
  }
}
