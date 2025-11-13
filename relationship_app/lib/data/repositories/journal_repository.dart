import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../core/models/journal_entry.dart';

class JournalRepository {
  static const String _boxName = 'journal_entries';
  late Box<JournalEntry> _box;
  final _uuid = const Uuid();

  Future<void> initialize() async {
    _box = await Hive.openBox<JournalEntry>(_boxName);
  }

  Future<String> createEntry(JournalEntry entry) async {
    final entryWithId = entry.copyWith(id: entry.id.isEmpty ? _uuid.v4() : entry.id);
    await _box.put(entryWithId.id, entryWithId);
    return entryWithId.id;
  }

  Future<void> updateEntry(JournalEntry entry) async {
    await _box.put(entry.id, entry);
  }

  Future<void> deleteEntry(String id) async {
    await _box.delete(id);
  }

  JournalEntry? getEntry(String id) {
    return _box.get(id);
  }

  List<JournalEntry> getAllEntries() {
    return _box.values.toList();
  }

  List<JournalEntry> getEntriesBySpace(JournalSpace space) {
    return _box.values.where((entry) => entry.space == space).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<JournalEntry> getSharedEntries() {
    return _box.values.where((entry) => entry.shareWithPartner).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<JournalEntry> getRecentEntries({int limit = 10}) {
    final entries = _box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries.take(limit).toList();
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
