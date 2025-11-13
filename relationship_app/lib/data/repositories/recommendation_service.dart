import 'dart:math';
import '../../core/models/date_idea.dart';
import '../../core/models/journal_entry.dart';
import '../mock_date_catalog.dart';

class RecommendationService {
  // Simple NLP: extract keywords from text
  List<String> _extractKeywords(String text) {
    final stopWords = {
      'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for',
      'of', 'with', 'by', 'from', 'up', 'about', 'into', 'through', 'during',
      'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had',
      'do', 'does', 'did', 'will', 'would', 'should', 'could', 'may', 'might',
      'i', 'you', 'we', 'they', 'he', 'she', 'it', 'my', 'your', 'our', 'their',
    };

    final words = text.toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .split(RegExp(r'\s+'))
        .where((word) => word.length > 3 && !stopWords.contains(word))
        .toList();

    // Extract meaningful entities (simple approach)
    final entities = <String>[];
    final activityKeywords = [
      'hiking', 'cooking', 'beach', 'movie', 'museum', 'game', 'coffee',
      'restaurant', 'park', 'walk', 'bike', 'art', 'music', 'food',
      'outdoors', 'indoors', 'home', 'travel', 'shopping', 'exercise',
      'sushi', 'italian', 'pizza', 'wine', 'painting', 'dancing',
    ];

    for (final word in words) {
      if (activityKeywords.any((keyword) => word.contains(keyword))) {
        entities.add(word);
      }
    }

    return entities;
  }

  // Simple sentiment analysis (rule-based)
  double _analyzeSentiment(String text, Mood mood) {
    final positiveWords = ['happy', 'love', 'great', 'wonderful', 'amazing', 
                           'fantastic', 'excellent', 'perfect', 'beautiful'];
    final negativeWords = ['sad', 'angry', 'frustrated', 'upset', 'disappointed',
                           'terrible', 'awful', 'bad', 'worse'];

    final lowerText = text.toLowerCase();
    var score = 0.0;

    for (final word in positiveWords) {
      if (lowerText.contains(word)) score += 0.1;
    }
    for (final word in negativeWords) {
      if (lowerText.contains(word)) score -= 0.1;
    }

    // Add mood-based sentiment
    switch (mood) {
      case Mood.amazing:
        score += 0.5;
        break;
      case Mood.good:
        score += 0.25;
        break;
      case Mood.okay:
        break;
      case Mood.down:
        score -= 0.25;
        break;
      case Mood.upset:
        score -= 0.5;
        break;
    }

    return score.clamp(-1.0, 1.0);
  }

  // Build preference vector from journal entries
  Map<String, double> _buildPreferences(List<JournalEntry> entries) {
    final preferences = <String, double>{};
    final now = DateTime.now();

    for (final entry in entries) {
      // Time decay (30-day half-life)
      final ageDays = now.difference(entry.createdAt).inDays;
      final weight = pow(0.5, ageDays / 30.0).toDouble();

      // Extract and weight keywords
      final keywords = _extractKeywords(entry.text);
      for (final keyword in keywords) {
        preferences[keyword] = (preferences[keyword] ?? 0.0) + weight;
      }

      // Weight tags more heavily
      for (final tag in entry.tags) {
        preferences[tag] = (preferences[tag] ?? 0.0) + (weight * 2.0);
      }

      // Add entities
      for (final entity in entry.entities) {
        preferences[entity] = (preferences[entity] ?? 0.0) + weight;
      }
    }

    return preferences;
  }

  // Score a date idea against preferences
  double _scoreDateIdea(DateIdea idea, Map<String, double> preferences) {
    var score = 0.0;

    // Match against why reasons
    for (final reason in idea.whyReasons) {
      score += preferences[reason] ?? 0.0;
    }

    // Match against tags
    for (final tag in idea.tags) {
      score += (preferences[tag] ?? 0.0) * 1.5;
    }

    return score;
  }

  // Get recommendations based on journal entries
  List<DateIdea> getRecommendations({
    required List<JournalEntry> entries,
    int? budgetPreference,
    LocationType? locationPreference,
    int count = 3,
  }) {
    if (entries.isEmpty) {
      // Return random ideas if no entries
      final shuffled = MockDateCatalog.catalog.toList()..shuffle();
      return shuffled.take(count).toList();
    }

    final preferences = _buildPreferences(entries);
    var candidates = MockDateCatalog.catalog.toList();

    // Filter by budget if specified
    if (budgetPreference != null) {
      candidates = candidates.where((idea) => 
        idea.budget <= budgetPreference).toList();
    }

    // Filter by location if specified
    if (locationPreference != null) {
      candidates = candidates.where((idea) => 
        idea.location == locationPreference).toList();
    }

    // Score and sort
    final scored = candidates.map((idea) {
      final score = _scoreDateIdea(idea, preferences);
      return MapEntry(idea, score);
    }).toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Return top matches with their matching reasons
    return scored.take(count).map((entry) {
      final matchedReasons = <String>[];
      for (final reason in entry.key.whyReasons) {
        if ((preferences[reason] ?? 0.0) > 0.1) {
          matchedReasons.add(reason);
        }
      }
      return entry.key.copyWith(whyReasons: matchedReasons);
    }).toList();
  }

  // Process new entry: extract entities and sentiment
  JournalEntry processEntry(JournalEntry entry) {
    final entities = _extractKeywords(entry.text);
    final sentiment = _analyzeSentiment(entry.text, entry.mood);
    
    return entry.copyWith(
      entities: entities,
      sentiment: sentiment,
    );
  }
}
