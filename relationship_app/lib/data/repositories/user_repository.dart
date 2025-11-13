import 'package:hive_flutter/hive_flutter.dart';
import '../../core/models/user_profile.dart';

class UserRepository {
  static const String _boxName = 'user_profile';
  late Box<UserProfile> _box;

  Future<void> initialize() async {
    _box = await Hive.openBox<UserProfile>(_boxName);
  }

  Future<void> saveProfile(UserProfile profile) async {
    await _box.put('current_user', profile);
  }

  UserProfile? getCurrentProfile() {
    return _box.get('current_user');
  }

  Future<void> updateProfile(UserProfile profile) async {
    await saveProfile(profile);
  }

  Future<void> deleteProfile() async {
    await _box.delete('current_user');
  }

  bool get hasProfile => _box.containsKey('current_user');
}
