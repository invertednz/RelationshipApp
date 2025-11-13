# Relationship App — Product & Technical Spec

## Tech Stack
- **Platform**: Flutter 3.x for iOS and Android
- **State Management**: Riverpod for reactive state and dependency injection
- **Navigation**: go_router for declarative routing
- **Local Storage**: Hive for entries, preferences, and offline-first data
- **Backend (MVP)**: Mock services with injectable repositories; future: Supabase/Firebase
- **Camera**: camera plugin for Photo Safari
- **Canvas**: custom_paint for Couples Doodle
- **Animations**: Lottie for garden growth, native Flutter animations

## Vision & Goals
- **Vision**: A safe, private space for couples to reflect individually and together, then gently surface helpful guidance, activities, and shared play that strengthens the relationship.
- **Primary goals**:
  - **Private journaling** for each person: separate spaces for "About Me" and "About My Partner".
  - **Consent-first sharing**: private by default; share controls at entry/tag level.
  - **Implicit recommendations**: use what each person writes to suggest date ideas, activities, nudges—without exposing private text to the other person.
  - **Playful connection**: lightweight games—Couples Doodle and Photo Safari.
  - **Together Garden**: a shared garden that grows when both are present and focused together.
- **Non-goals (MVP)**:
  - Real-time multi-device sync with conflict-free merging.
  - Deep ML models; start with heuristics and simple embeddings.
  - Production backend; use mocked services initially.

## Personas
- **Partner A / B**: Busy adults who want light, low-friction tools to feel closer and be better partners, with strong privacy expectations.
- **Relationship Coach (implicit)**: The app acts like a coach, surfacing helpful, consent-aligned suggestions—never shaming or revealing sensitive content.

## Information Architecture & Routes
Current pages observed in `pages/`: `diary.html`, `highlights.html`, `wishlist.html`, `coach.html`, `connection.html`, `growth.html`, `fun.html`, `wellness.html`.

Proposed additions (HTML-first, matching current structure/style):
- **Onboarding** (`pages/onboarding/`)
  - `welcome.html` — Welcome, value props, privacy promise.
  - `about-you.html` — Name, pronouns, notifications.
  - `relationship.html` — Partner name, relationship start date, important dates.
  - `preferences.html` — Interests, cuisines, budget band, comfort levels (indoors/outdoors, travel), love languages quick quiz.
  - `privacy.html` — Data policy, encryption overview, sharing defaults.
  - `link-partner.html` — Pairing via invite code/QR.
  - `install.html` — “Add to Home Screen” (PWA) guidance.
  - `complete.html` — Confirmation + quick tips.
- **Journals & Recommendations**
  - `my-space.html` — Private “About Me” journal.
  - `about-partner.html` — Private “About My Partner” journal.
  - `recommendations.html` — Suggested dates/activities (explainable, no quotes from journals).
- **Games** (`pages/games/`)
  - `index.html` — Game hub.
  - `doodle.html` — Couples Doodle (canvas + prompts).
  - `safari.html` — Photo Safari (camera + prompts).
- **Garden**
  - `garden.html` — Garden overview, start focus session.
  - `garden-history.html` — Sessions, streaks, achievements.
- **Support**
  - `settings.html` — Privacy, pairing, export, theme.
  - `invite.html` — Generate/accept partner invite.
  - `privacy-policy.html` — Plain-language policy summary.

Navigation
- Keep the current bottom nav from `index.html` and add entry points to: `recommendations.html`, `games/index.html`, `garden.html` (or nest within Explore).

## Onboarding (inspired by SkinCareApp)
- **Flow**: 7–8 screens with progress indicator, skip/prev, save-on-advance.
- **Collected data**:
  - Profile: name, pronouns, dob (optional), timezone.
  - Relationship: partner name, start date, important dates, reminders opt-in.
  - Preferences: date vibe (adventurous/relaxing/romantic/fun), budget ($–$$$), location preference (home/indoors/outdoors), cuisines, activities, love languages quick quiz.
  - Privacy: share defaults (private by default), local encryption key setup (optional passphrase).
  - Pairing: invite code or QR to link partners.
  - Install: PWA A2HS guidance.
- **Design**: Color scheme similar to `songs4kids` (see Theme section). Use current Tailwind card + rounded-xl motif for visual continuity.

## Safe Journals & Privacy Model
- **Spaces**:
  - `My Space` (About Me): personal reflections, moods, habits.
  - `About My Partner`: private feedback, needs, appreciations.
- **Privacy**:
  - Private by default. Sharing requires explicit action per entry/tag.
  - Partner never sees your raw text unless shared. Recommendations are aggregated.
- **Security**:
  - MVP local-only: store entries in `localStorage`/`IndexedDB` per device; no cloud sync.
  - Cloud option (recommended): Supabase or Firebase with Row Level Security, plus client-side encryption via Web Crypto.
  - E2EE pairing: derive a shared key (e.g., using a passphrase or ECDH exchange). Encrypt entries marked “shareable” before upload.
- **Entry structure (JSON)**:
```json
{
  "id": "uuid",
  "space": "me|about_partner",
  "createdAt": "2025-11-11T19:00:00Z",
  "mood": "amazing|good|okay|down|upset",
  "text": "string",
  "tags": ["communication", "date-night"],
  "shareWithPartner": false,
  "sentiment": 0.42,
  "entities": ["sushi", "beach", "movies"],
  "encrypted": true
}
```
- **Controls**: per-entry sharing toggle; bulk export; delete; lock-with-passphrase; redaction warning before sharing.

## Recommendations Engine
- **Goal**: Suggest dates/activities and nudges derived from journals + preferences without leaking private text.
- **Signals**:
  - Keywords/entities: cuisines, activities, venues, time-of-day, budgets.
  - Sentiment/mood trends: recent vs long-term.
  - Tags & categories: “communication”, “conflict”, “gratitude”, “adventure”.
  - Onboarding preferences.
  - Engagement (wishlist saves, liked dates).
- **Pipeline (client-first, no network required)**:
  - Tokenize text, extract keywords (simple regex + stopwords), map to controlled vocab (e.g., cuisines, activity types).
  - Sentiment: rule-based or small lexicon to start; optional lightweight model later.
  - Build a weighted preference vector with time decay (e.g., half-life 30 days).
  - Sample 1–3 ideas from a curated Date Idea Catalog filtered by constraints (budget, location), weighted by preferences.
- **Explainability**: Show “Why this?” chips (e.g., “You both mentioned sushi recently”); never show raw private text.
- **Pseudocode**:
```js
const now = Date.now();
for (const entry of entries) {
  const ageDays = (now - new Date(entry.createdAt)) / 86400000;
  const w = Math.exp(-ageDays / 30);
  for (const k of extractKeywords(entry.text)) prefs[k] = (prefs[k] || 0) + w;
  prefs.mood = ema(prefs.mood, sentiment(entry.text));
}
const candidates = catalog.filter(c => fits(c, userPrefs));
return weightedSample(candidates, prefs, 3);
```
- **Catalog format**:
```json
{
  "id": "sunset-picnic-hike",
  "title": "Sunset Picnic Hike",
  "tags": ["outdoors", "adventurous"],
  "budget": 2,
  "durationHrs": 2.5,
  "location": "outdoors",
  "requirements": ["blanket", "snacks"],
  "why": ["outdoors", "hiking", "sunset", "picnic"]
}
```
- **Data protection**: Keep raw entries local; only derived tags/scores sync by default. If cloud is enabled, keep E2EE for any shared data.

## Games
### Couples Doodle (`pages/games/doodle.html`)
- **MVP**: Pass-and-play on one device.
  - Prompt shown to Drawer; timer (e.g., 60s); guesser sees drawing; after round, reveal answer and score.
  - Canvas drawing with brush/eraser/colors; export doodle to `highlights`.
- **Prompts**: Favorite holiday, first date location, dream trip, shared hobby, inside joke, “favourite holiday couple has to guess”, etc.
- **Remote roadmap**: Add Supabase Realtime or WebRTC for turn sync.
- **Data**: `{ sessionId, prompts, rounds, scores, exportedToHighlights }`.

### Photo Safari (`pages/games/safari.html`)
- **MVP**: Prompt list -> use `getUserMedia` camera -> capture stills via canvas -> score on completion.
- **Prompts**: “Partner holding a duck”, “Partner looking at something green”, “Matching smiles”, “Both in a mirror”, “Heart shape in the wild”.
- **Safety**: On-device only by default; ask before saving/sharing images; EXIF stripped.
- **Roadmap**: Timed hunts, shared albums, remote head-to-head.

## Together Garden (`pages/garden.html`)
- **Core mechanic**: Garden grows with verified “together focus time”.
- **Web MVP (constraints-aware)**:
  - Both partners open `garden.html`, start a focus session with a 6-digit code handshake (one creates, one joins).
  - Server creates a session and tracks elapsed time; clients can lock screens; periodic re-taps required (e.g., every 20–30 min) to curb abuse.
  - If fully offline: local timer with honor system and optional post-session partner confirm.
- **Advanced Web (PWA)**:
  - Use Idle Detection API (Chromium) to avoid counting when device is active elsewhere.
  - Optional coarse co-location check (approx geolocation consent; never store precise coords).
- **Native Roadmap**:
  - Capacitor/Ionic wrapper to detect screen-off, Bluetooth proximity beacons, and background timers more reliably.
- **Progression**: Seeds -> sprouts -> plants -> seasonal events; streaks, badges; tie-in with `highlights`.
- **Data**: `{ gardenId, totalMinutes, streakDays, sessionHistory[], achievements[] }`.

## Theme & Visual Design (similar to songs4kids)
- **Approach**: Keep playful, high-contrast palette and rounded shapes.
- **Tokens** (current app uses):
  - Primary `#EC6B9E`, Secondary `#64C4ED`, Accent `#FFD166`, Neutral scale.
- **Action**: Extract songs4kids palette and map to Tailwind tokens in a shared snippet; update all pages for consistency.
- **Typography/Icons**: System UI font; Heroicons for continuity.

## Data & Storage Options
- **Local-only (MVP)**: IndexedDB for entries, files, and catalog; export/import JSON.
- **Cloud sync**: Supabase Postgres + RLS; E2EE via Web Crypto; partner link grants row access only for derived signals and explicitly shared items.
- **Backups**: Manual export, optional encrypted cloud backup.

## Security & Privacy
- **Private by default**: No partner access to private text unless explicitly shared.
- **Encryption**: Client-side for any synced content; shared key created during pairing.
- **Explainable AI**: “Why this suggestion” shows categories, not quotes.
- **Data minimization**: Derive tags locally; upload only aggregate preferences by default.

## Analytics (privacy-preserving)
- Local-only usage analytics by default; optional opt-in anonymous events (screen views, feature usage) without content.

## Implementation Milestones
- **M0 – Spec & Theme**
  - Spec approved; theme tokens extracted from songs4kids; shared Tailwind token snippet.
- **M1 – Onboarding**
  - Build `pages/onboarding/*` flow; local persistence; invite code flow; PWA guide.
- **M2 – Journals & Recs**
  - `my-space.html`, `about-partner.html` with local storage; basic NLP + recs in `recommendations.html`; wishlist integration.
- **M3 – Games**
  - Doodle + Safari MVP with local persistence; export to `highlights`.
- **M4 – Garden**
  - Focus session MVP (honor-system + handshake); session history + badges.
- **M5 – Optional Cloud**
  - Supabase with RLS; E2EE for shared items; partner link.

## Open Questions
- Songs4kids palette: provide hex codes or allow me to extract.
- SkinCareApp onboarding specifics to mirror (copy tone/layout exactly or just structure?).
- Preferred backend (Supabase vs Firebase) and whether to ship MVP local-only first.
- PWA requirement now or later.
- Any restricted content categories to exclude from prompts.

## Next Steps
- Confirm palette and onboarding details.
- Approve IA and page list.
- I’ll scaffold `pages/onboarding/*`, `recommendations.html`, games stubs, and `garden.html` with the shared theme for iteration.

---

### Appendix A — Sample Prompt Sets
- **Doodle**: Favorite holiday, first concert together, dream home, perfect Sunday, our inside joke, best meal this year, favorite animal, where we first met, ideal weekend, favorite movie scene.
- **Photo Safari**: Partner holding a duck, something heart-shaped, both in a reflection, matching color outfits, partner smelling something nice, laughing candid, favorite café sign, shadows making a pattern.
