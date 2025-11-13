# Implementation Notes

## What's Built

### Complete Features ✅

1. **Full Onboarding Flow**
   - 6 screens matching SkinCareApp structure
   - Progress indicators
   - Form validation
   - State persistence with Riverpod

2. **Journal System**
   - My Space and About Partner journals
   - Mood tracking (5 states with emojis)
   - Rich text entry
   - Privacy controls (share toggle)
   - Local storage with Hive
   - NLP processing (keyword extraction, sentiment)

3. **Recommendations Engine**
   - Client-side algorithm
   - Time-decay weighting
   - Budget filtering
   - 15 pre-loaded date ideas
   - Explainable suggestions

4. **Games Hub**
   - Doodle game screen (UI ready, canvas pending)
   - Photo Safari (UI ready, camera pending)

5. **Together Garden**
   - Progress tracking
   - Level system
   - Streak calculations
   - Achievement system

6. **Theme & Design**
   - songs4kids color palette applied
   - Custom Tailwind-like theme tokens
   - Consistent card-based UI
   - Material 3 with custom colors

### Stub/Placeholder Features ⚠️

1. **Canvas Drawing** (Couples Doodle)
   - Needs CustomPaint implementation
   - Touch tracking for drawing
   - Color/brush selection
   - Clear/undo functionality

2. **Camera Integration** (Photo Safari)
   - Camera plugin configured but not connected
   - Need to implement camera preview
   - Image capture and storage
   - Gallery view

3. **Garden Focus Sessions**
   - Timer needs implementation
   - Partner sync via codes (mock)
   - Session history display

4. **Partner Linking**
   - Code generation works (local)
   - Backend API needed for actual pairing
   - Sync mechanism for shared data

## Architecture Decisions

### Why Hive?
- Offline-first requirement
- Fast, lightweight
- Type-safe with code generation
- No network dependency for MVP

### Why Riverpod?
- Modern state management
- Compile-time safety
- Easy testing
- Provider composition

### Why go_router?
- Declarative routing
- Deep linking ready
- Type-safe navigation
- Future-proof for web

### Mock Backend Strategy
All repositories are abstracted interfaces. Easy to swap with real backend:

```dart
abstract class IJournalRepository {
  Future<void> createEntry(JournalEntry entry);
  List<JournalEntry> getAllEntries();
}

// Current: Hive implementation
class JournalRepository implements IJournalRepository { ... }

// Future: Supabase implementation
class SupabaseJournalRepository implements IJournalRepository { ... }
```

## Code Generation

### Hive Adapters Required
After running `flutter pub run build_runner build`, you should see:

```
lib/core/models/journal_entry.g.dart
lib/core/models/user_profile.g.dart
lib/core/models/garden_session.g.dart
```

If build_runner fails:
1. Check all models have `part 'filename.g.dart';`
2. Ensure `@HiveType` and `@HiveField` annotations present
3. Run with `--delete-conflicting-outputs`

## Privacy & Security Model

### MVP (Current)
- All data local to device
- No cloud sync
- Partner linking is placeholder
- Export/import via JSON (future)

### Production (Future)
- Supabase with RLS
- Client-side encryption (Web Crypto API)
- E2EE for shared entries
- ECDH key exchange during pairing
- Zero-knowledge architecture (backend can't read private entries)

## Recommendation Algorithm

### Current Implementation
```
1. Extract keywords from journal text (stopword filtering)
2. Weight by time decay (30-day half-life)
3. Build preference vector: keyword -> score
4. Score each date idea by matching keywords
5. Filter by budget/location preference
6. Return top N sorted by score
```

### Future Enhancements
- TF-IDF weighting
- Embeddings (sentence transformers)
- Collaborative filtering (if multi-user)
- Contextual bandits (learn from interactions)

## Testing Strategy

### Unit Tests Needed
- [ ] Recommendation scoring logic
- [ ] Journal entry processing
- [ ] Garden streak calculation
- [ ] Time decay function

### Widget Tests Needed
- [ ] Onboarding flow
- [ ] Journal entry creation
- [ ] Mood selector
- [ ] Navigation

### Integration Tests Needed
- [ ] Full user journey (onboarding → journal → recommendations)
- [ ] Data persistence across app restarts

## Performance Considerations

### Current
- All operations are synchronous (local Hive)
- No pagination (assume < 1000 entries)
- No image caching (not implemented yet)

### Future Optimizations
- Paginated journal entry list
- Lazy loading for old entries
- Image compression and caching
- Background processing for NLP

## Known Limitations

1. **No Backend**: Everything is local-only
2. **No Sync**: Can't share between devices
3. **No Auth**: Single user per device
4. **No Camera**: Photo Safari needs implementation
5. **No Canvas**: Doodle needs drawing implementation
6. **No Real Garden Sessions**: Timer/sync pending

## Migration Path to Backend

### Phase 1: Add Backend (Keep Local-First)
1. Add Supabase client
2. Implement repositories with backend
3. Add sync logic (local → cloud)
4. Keep offline mode working

### Phase 2: Real-time Features
1. WebSocket for games
2. Presence detection for garden
3. Push notifications

### Phase 3: Advanced Features
1. E2EE implementation
2. Multi-device sync
3. Shared calendar
4. Photo albums

## Environment Setup for Developers

### Required Packages
- Flutter SDK 3.5.4+
- Xcode 15+ (iOS)
- Android Studio Hedgehog+ (Android)
- CocoaPods 1.13+

### Recommended IDE Setup
- VS Code with Flutter/Dart extensions
- Or Android Studio with Flutter plugin

### Build Variants (Future)
```yaml
# dev, staging, prod environments
--dart-define=ENVIRONMENT=dev
--dart-define=SUPABASE_URL=...
--dart-define=SUPABASE_ANON_KEY=...
```

## Deployment Checklist

### iOS
- [ ] Configure App Store Connect
- [ ] Set bundle identifier
- [ ] Add privacy descriptions in Info.plist
- [ ] Configure code signing
- [ ] Test on physical device

### Android
- [ ] Set applicationId in build.gradle
- [ ] Configure signing keys
- [ ] Add privacy policy link
- [ ] Test on physical device

## Analytics & Monitoring (Future)

### Events to Track
- Onboarding completion rate
- Journal entry frequency
- Recommendation clicks
- Game engagement
- Garden session duration

### Crash Reporting
- Firebase Crashlytics
- Sentry

### Privacy-Preserving Analytics
- No PII collection
- Aggregate usage patterns only
- Opt-in only

---

**Developer Notes**: The app is structured to be easily extensible. Each feature is modular. To add backend, simply create new repository implementations and inject via Riverpod providers.
