# Relationship App - Flutter Setup Guide

## Overview
A Flutter mobile app for iOS and Android that helps couples grow together through private journaling, personalized recommendations, fun games, and a shared "Together Garden."

## Features Implemented

### ✅ Onboarding (like SkinCareApp)
- **Welcome Screen**: Value props and feature highlights
- **About You**: Name, pronouns
- **Relationship**: Partner name, start date
- **Preferences**: Interests, cuisines, budget (chips selection)
- **Link Partner**: Code-based pairing (mock)
- **Complete**: Onboarding confirmation

### ✅ Core Features
- **My Space Journal**: Private "About Me" entries with mood tracking
- **About Partner Journal**: Private thoughts about partner
- **Entry Creation**: Mood selector, text input, share toggle
- **Recommendations**: AI-powered date ideas based on journal analysis
- **Games Hub**: Access to Couples Doodle and Photo Safari
- **Together Garden**: Grow together through focus sessions

### ✅ Architecture
- **State Management**: Riverpod
- **Navigation**: go_router
- **Local Storage**: Hive (offline-first)
- **Theme**: songs4kids-inspired color palette
- **Mock Backend**: All services work offline with mock data

## Tech Stack
- Flutter 3.5.4+
- Dart 3.5.4+
- Riverpod 2.6.1
- Hive 2.2.3
- go_router 14.8.1
- Google Fonts
- Camera plugin (for Photo Safari)

## Setup Instructions

### 1. Prerequisites
```bash
# Verify Flutter installation
flutter doctor

# Ensure you have:
# - Flutter SDK 3.5.4 or higher
# - Xcode (for iOS) or Android Studio (for Android)
# - CocoaPods (for iOS)
```

### 2. Install Dependencies
```bash
cd relationship_app
flutter pub get
```

### 3. Generate Hive Adapters
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This will generate the following files:
- `lib/core/models/journal_entry.g.dart`
- `lib/core/models/user_profile.g.dart`
- `lib/core/models/garden_session.g.dart`

### 4. Run the App

#### iOS
```bash
flutter run -d ios
```

#### Android
```bash
flutter run -d android
```

#### To select a specific device
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

## Project Structure

```
lib/
├── core/
│   ├── models/          # Data models (Journal, User, Garden, DateIdea)
│   ├── theme/           # App theme and colors
│   └── router/          # go_router configuration
├── data/
│   ├── repositories/    # Data access layer
│   └── mock_date_catalog.dart
├── providers/           # Riverpod state management
└── features/
    ├── onboarding/      # 6-screen onboarding flow
    ├── home/            # Main dashboard
    ├── journal/         # My Space & About Partner
    ├── recommendations/ # Date idea suggestions
    ├── games/           # Doodle & Safari
    └── garden/          # Together Garden
```

## Key Features Detail

### Private Journals
- **Two Spaces**: "My Space" (about self) and "About Partner" (private thoughts)
- **Mood Tracking**: 5 moods (Amazing, Good, Okay, Down, Upset)
- **Privacy Controls**: Per-entry sharing toggle
- **NLP Processing**: Keyword extraction and sentiment analysis
- **Local-first**: All data stored in Hive, no network required

### Recommendations Engine
- **Keyword Extraction**: Identifies interests from journal text
- **Time Decay**: Recent entries weighted more heavily (30-day half-life)
- **Budget Filtering**: Matches user's budget preference
- **Explainable**: Shows "why" chips (e.g., "You mentioned hiking")
- **15 Curated Ideas**: Sunset picnic hike, cooking class, museum, beach day, etc.

### Games
- **Couples Doodle**: Draw-and-guess (canvas implementation pending)
- **Photo Safari**: 8 photo challenges (camera integration pending)

### Together Garden
- **Progress Tracking**: Total minutes, current/longest streak
- **Leveling**: Every 60 minutes = 1 level
- **Achievements**: First hour, week streak, 10 hours
- **Session Management**: Start/end focus sessions

## Mock Backend

All repositories use local Hive storage:
- **UserRepository**: Stores single user profile
- **JournalRepository**: CRUD for journal entries
- **GardenRepository**: Sessions and progress tracking
- **RecommendationService**: Client-side NLP and matching

## Color Scheme (songs4kids-inspired)

```dart
Primary (Pink/Rose):
- Light: #F9D5E5
- Default: #EC6B9E
- Dark: #D44A7E

Secondary (Blue):
- Light: #D4F0FC
- Default: #64C4ED
- Dark: #3AA0D1

Accent (Yellow):
- Light: #FFF3CD
- Default: #FFD166
- Dark: #E6B800
```

## Next Steps / Roadmap

### MVP Enhancements
- [ ] Canvas drawing for Couples Doodle
- [ ] Camera integration for Photo Safari
- [ ] Actual focus session timer for Garden
- [ ] Partner linking backend
- [ ] Data export/import

### Backend Integration (Future)
- [ ] Supabase or Firebase setup
- [ ] E2EE for shared content
- [ ] Real-time sync for games
- [ ] Push notifications
- [ ] Cloud backup

### Advanced Features (Future)
- [ ] Bluetooth proximity detection for Garden
- [ ] ML-based sentiment analysis
- [ ] Shared calendar/reminders
- [ ] Memory time capsules
- [ ] Relationship milestones

## Troubleshooting

### Build Runner Issues
If you see errors about missing adapters:
```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Hive Initialization Errors
Ensure adapters are registered in `main.dart` before opening boxes.

### iOS Build Issues
```bash
cd ios
pod install
cd ..
flutter clean
flutter run
```

### Android Build Issues
- Ensure Java version is compatible (Java 17+)
- Check `android/gradle/wrapper/gradle-wrapper.properties`

## Testing

### Manual Testing Checklist
- [ ] Complete onboarding flow
- [ ] Create journal entries (both spaces)
- [ ] View recommendations (after creating entries)
- [ ] Navigate to games
- [ ] View garden stats

### Unit Tests (Future)
```bash
flutter test
```

## Performance Notes

- All data is local-first (instant load times)
- Recommendation engine runs client-side (no network latency)
- Images/assets lazy-loaded
- Optimized for 60fps animations

## License
Proprietary - Relationship App

## Support
For issues or questions, contact the development team.

---

**Status**: ✅ MVP Complete - Ready for Testing
**Last Updated**: November 11, 2025
