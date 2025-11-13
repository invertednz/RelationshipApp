# Preferences Onboarding Expansion

## Summary
Expanded the single preferences screen into a **5-screen comprehensive preference flow** with full-row items, icons, descriptions, and custom input capability.

## Changes Made

### 1. Enhanced UserProfile Model
**File**: `lib/core/models/user_profile.dart`

Added new fields:
- `loveLanguages: List<String>` - User's love language preferences
- `giftPreferences: List<String>` - Types of gifts they appreciate
- `activities: List<String>` - Favorite couple activities
- `customInterests: List<String>` - User-written custom interests
- `customActivities: List<String>` - User-written custom activities

### 2. New Reusable Widget
**File**: `lib/features/onboarding/widgets/preference_item.dart`

Created `PreferenceItem` widget with:
- **Full-row layout** with icon, label, description
- **Selection state** with visual feedback
- **Check circle icon** when selected
- **Colored background** and border on selection
- **Tap handling** for toggling

### 3. New Preference Screens

#### Interests Screen
**File**: `lib/features/onboarding/preferences_interests_screen.dart`
- 15 interest options with icons (Hiking, Cooking, Movies, Museums, etc.)
- Custom interest input field
- Chips display for custom entries
- Progress: 50%

#### Love Languages Screen
**File**: `lib/features/onboarding/preferences_love_languages_screen.dart`
- 5 love languages (Words of Affirmation, Quality Time, Receiving Gifts, Acts of Service, Physical Touch)
- Each with description explaining what it means
- Progress: 60%

#### Gift Preferences Screen
**File**: `lib/features/onboarding/preferences_gifts_screen.dart`
- 12 gift categories (Flowers, Handwritten Notes, Jewelry, Books, Tech, etc.)
- Custom gift input field
- Chips for custom preferences
- Progress: 70%

#### Activities Screen
**File**: `lib/features/onboarding/preferences_activities_screen.dart`
- 16 couple activity options (Walks, Cooking Together, Movie Nights, etc.)
- Custom activity input
- Chips for custom activities
- Progress: 80%

#### Cuisines & Budget Screen
**File**: `lib/features/onboarding/preferences_cuisines_screen.dart`
- 12 cuisine options with food-related icons
- Budget preference selector (3 levels: Budget-friendly, Moderate, Splurge)
- Redesigned budget selection with descriptions
- Progress: 90%

### 4. Updated Navigation
**File**: `lib/core/router/app_router.dart`

Added routes:
- `/onboarding/preferences/interests`
- `/onboarding/preferences/love-languages`
- `/onboarding/preferences/gifts`
- `/onboarding/preferences/activities`
- `/onboarding/preferences/cuisines`

**Flow**: Welcome → About You → Relationship → **Interests → Love Languages → Gifts → Activities → Cuisines** → Link Partner → Complete

### 5. Updated Relationship Screen
**File**: `lib/features/onboarding/relationship_screen.dart`

Changed navigation from `/onboarding/preferences` to `/onboarding/preferences/interests`

## Design Features

### Full-Row Items with Icons
Each preference option now displays as a full card with:
```
┌──────────────────────────────────────┐
│ [Icon] Label                       ✓ │
│        Description (if provided)     │
└──────────────────────────────────────┘
```

### Visual Feedback
- **Selected**: Primary color border, light background, check icon
- **Unselected**: Neutral border, white background, empty circle icon
- **Icons**: Each category has themed icons (hiking, heart, gift, etc.)

### Custom Input
Every screen (except Love Languages) allows users to:
1. Type custom entries in a text field
2. Click "Add" or press Enter
3. See custom entries as removable chips
4. Delete by clicking the × on the chip

### Icons Used
- **Interests**: `hiking`, `restaurant`, `movie`, `museum`, `beach_access`, `sports_esports`, `palette`, `music_note`, `flight`, `shopping_bag`, `menu_book`, `fitness_center`, `camera_alt`, `nightlife`, `extension`
- **Love Languages**: `chat_bubble_outline`, `favorite`, `card_giftcard`, `handshake`, `touch_app`
- **Gifts**: `local_florist`, `edit_note`, `diamond`, `menu_book`, `devices`, `checkroom`, `chair`, `confirmation_number`, `cake`, `spa`, `palette`, `card_membership`
- **Activities**: `directions_walk`, `restaurant_menu`, `movie`, `luggage`, `restaurant`, `fitness_center`, `music_note`, `sports_esports`, `explore`, `volunteer_activism`, `local_cafe`, `landscape`, `brush`, `nightlife`, `outdoor_grill`, `nights_stay`
- **Cuisines**: `local_pizza`, `ramen_dining`, `lunch_dining`, `restaurant`, `rice_bowl`, `curry`, `fastfood`, `cake`, `kebab_dining`, `soup_kitchen`, `food_bank`, `tapas`

## Data Storage

All preferences are saved to `UserProfile` model and persisted via Hive:
```dart
final profile = UserProfile(
  interests: ['hiking', 'movies'],
  customInterests: ['birdwatching'],
  loveLanguages: ['quality_time', 'words'],
  giftPreferences: ['flowers', 'handwritten notes'],
  activities: ['walks', 'cooking'],
  customActivities: ['pottery classes'],
  cuisines: ['italian', 'japanese'],
  budgetPreference: 2,
);
```

## Testing Checklist

- [ ] Complete interests screen with standard options
- [ ] Add custom interest and verify chip appears
- [ ] Navigate to love languages screen
- [ ] Select multiple love languages
- [ ] Continue to gifts screen
- [ ] Add custom gift preference
- [ ] Continue to activities screen
- [ ] Add custom activity
- [ ] Complete cuisines and budget
- [ ] Verify all data persists in profile
- [ ] Verify back navigation works
- [ ] Check progress indicators on each screen

## Future Enhancements

- Add search/filter for long lists
- Group options by category
- Show partner's preferences (if linked)
- Suggest compatibility based on shared preferences
- Allow reordering by drag-and-drop
- Add "Most Popular" badge to common selections
- Import preferences from partner profile

---

**Status**: ✅ Complete - Ready for testing
**Hive Adapters**: Need to regenerate with `flutter pub run build_runner build`
