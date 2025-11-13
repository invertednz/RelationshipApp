import 'package:equatable/equatable.dart';

class DateIdea extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final int budget; // 1-3 ($, $$, $$$)
  final double durationHrs;
  final LocationType location;
  final List<String> requirements;
  final List<String> whyReasons; // Keywords that matched

  const DateIdea({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.budget,
    required this.durationHrs,
    required this.location,
    this.requirements = const [],
    this.whyReasons = const [],
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        tags,
        budget,
        durationHrs,
        location,
        requirements,
        whyReasons,
      ];

  DateIdea copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? tags,
    int? budget,
    double? durationHrs,
    LocationType? location,
    List<String>? requirements,
    List<String>? whyReasons,
  }) {
    return DateIdea(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      budget: budget ?? this.budget,
      durationHrs: durationHrs ?? this.durationHrs,
      location: location ?? this.location,
      requirements: requirements ?? this.requirements,
      whyReasons: whyReasons ?? this.whyReasons,
    );
  }
}

enum LocationType {
  home,
  indoors,
  outdoors,
}

extension LocationTypeExtension on LocationType {
  String get label {
    switch (this) {
      case LocationType.home:
        return 'Home';
      case LocationType.indoors:
        return 'Indoors';
      case LocationType.outdoors:
        return 'Outdoors';
    }
  }
}
