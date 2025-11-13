import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 0)
class JournalEntry extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final JournalSpace space;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final Mood mood;

  @HiveField(4)
  final String text;

  @HiveField(5)
  final List<String> tags;

  @HiveField(6)
  final bool shareWithPartner;

  @HiveField(7)
  final double sentiment;

  @HiveField(8)
  final List<String> entities;

  const JournalEntry({
    required this.id,
    required this.space,
    required this.createdAt,
    required this.mood,
    required this.text,
    this.tags = const [],
    this.shareWithPartner = false,
    this.sentiment = 0.0,
    this.entities = const [],
  });

  @override
  List<Object?> get props => [
        id,
        space,
        createdAt,
        mood,
        text,
        tags,
        shareWithPartner,
        sentiment,
        entities,
      ];

  JournalEntry copyWith({
    String? id,
    JournalSpace? space,
    DateTime? createdAt,
    Mood? mood,
    String? text,
    List<String>? tags,
    bool? shareWithPartner,
    double? sentiment,
    List<String>? entities,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      space: space ?? this.space,
      createdAt: createdAt ?? this.createdAt,
      mood: mood ?? this.mood,
      text: text ?? this.text,
      tags: tags ?? this.tags,
      shareWithPartner: shareWithPartner ?? this.shareWithPartner,
      sentiment: sentiment ?? this.sentiment,
      entities: entities ?? this.entities,
    );
  }
}

@HiveType(typeId: 1)
enum JournalSpace {
  @HiveField(0)
  me,
  @HiveField(1)
  aboutPartner,
}

@HiveType(typeId: 2)
enum Mood {
  @HiveField(0)
  amazing,
  @HiveField(1)
  good,
  @HiveField(2)
  okay,
  @HiveField(3)
  down,
  @HiveField(4)
  upset,
}

extension MoodExtension on Mood {
  String get emoji {
    switch (this) {
      case Mood.amazing:
        return '😍';
      case Mood.good:
        return '😊';
      case Mood.okay:
        return '😐';
      case Mood.down:
        return '😔';
      case Mood.upset:
        return '😢';
    }
  }

  String get label {
    switch (this) {
      case Mood.amazing:
        return 'Amazing';
      case Mood.good:
        return 'Good';
      case Mood.okay:
        return 'Okay';
      case Mood.down:
        return 'Down';
      case Mood.upset:
        return 'Upset';
    }
  }
}
