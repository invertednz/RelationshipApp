# Quick Start Guide

## 🚀 Get Running in 5 Minutes

### 1. Install Dependencies
```bash
cd relationship_app
flutter pub get
```

### 2. Generate Code
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```
This creates Hive adapters for data models.

### 3. Run the App
```bash
# For iOS simulator
flutter run -d ios

# For Android emulator
flutter run -d android

# List all devices
flutter devices
```

### 4. Test the Flow
1. **Onboarding**: Complete all 6 screens
   - Enter your name
   - Add partner details
   - Select interests and cuisines
   - (Skip partner linking for now)

2. **Create Journal Entry**
   - Home → My Space
   - Select a mood
   - Write something (mention activities like "hiking" or "sushi")
   - Save

3. **Get Recommendations**
   - Home → Recommendations
   - See personalized date ideas based on your journal

4. **Explore Features**
   - Games → Try Doodle or Safari
   - Garden → View progress tracker

## 📱 App Structure

```
Home Screen
├── My Space (Private journal about yourself)
├── About Partner (Private thoughts about partner)
├── Recommendations (AI-powered date ideas)
├── Games (Doodle & Photo Safari)
└── Garden (Grow together through focus time)
```

## 🎨 Features Demo

### Journals
- **Two separate spaces** for different types of reflections
- **5 mood options** with emoji indicators
- **Privacy controls** on each entry
- **Automatic keyword extraction** for recommendations

### Recommendations
- Based on what you write in journals
- No quotes from private text shown
- Filters by budget preference
- Shows "why" tags (e.g., matched on "hiking")

### Games (UI Complete)
- **Couples Doodle**: Draw and guess prompts
- **Photo Safari**: 8 fun photo challenges

### Garden (Tracking Ready)
- Track focus time together
- Level up system (60 min = 1 level)
- Streak counter
- Achievement badges

## 🔧 Development Commands

```bash
# Hot reload (during development)
# Press 'r' in terminal or save files

# Hot restart (full restart)
# Press 'R' in terminal

# Clean build
flutter clean
flutter pub get
flutter run

# Format code
flutter format .

# Analyze code
flutter analyze

# Run tests (when added)
flutter test
```

## 📊 Test Data

The app includes:
- **15 curated date ideas** in the recommendation catalog
- **Sample prompts** for Couples Doodle
- **8 photo challenges** for Safari
- **Mock achievements** for Garden

## 🐛 Troubleshooting

### "Missing Hive Adapter" Error
Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### "No devices found"
```bash
# Start iOS simulator
open -a Simulator

# Or list Android emulators
flutter emulators
flutter emulators --launch <emulator_id>
```

### Build Errors
```bash
flutter clean
flutter pub get
flutter run
```

### iOS Pod Issues
```bash
cd ios
pod install
cd ..
flutter run
```

## 📝 What's Mock vs Real

### ✅ Fully Functional
- Onboarding flow
- Journal creation and storage
- Recommendation algorithm
- All navigation
- Theme and UI

### ⚠️ UI Only (Backend Needed)
- Partner linking (generates codes but doesn't sync)
- Garden focus sessions (no actual timer)
- Canvas drawing (Doodle game)
- Camera capture (Safari game)

## 🎯 Next Steps

1. **Test Core Flow**
   - Complete onboarding
   - Create 3-4 journal entries
   - Check recommendations update

2. **Try All Features**
   - Navigate through all screens
   - Test mood selector
   - View garden stats

3. **Customize**
   - Modify date idea catalog (`lib/data/mock_date_catalog.dart`)
   - Adjust theme colors (`lib/core/theme/app_colors.dart`)
   - Add more prompts for games

## 📚 Documentation

- `SETUP.md` - Detailed setup instructions
- `IMPLEMENTATION_NOTES.md` - Architecture and technical details
- `docs/SPEC.md` - Full product specification

## 🎨 Design System

### Colors (songs4kids-inspired)
- **Primary Pink**: #EC6B9E
- **Secondary Blue**: #64C4ED  
- **Accent Yellow**: #FFD166

### Typography
- Google Fonts: Poppins
- Material 3 design system

### Components
- Rounded cards (24px radius)
- Soft shadows
- Emoji-based mood indicators
- Icon-first navigation

---

**Ready to run?** Just `flutter run` and start exploring! 🚀
