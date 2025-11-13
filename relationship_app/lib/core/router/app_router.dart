import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/journal_entry.dart';
import '../../features/onboarding/welcome_social_proof_screen.dart';
import '../../features/onboarding/goals_screen.dart';
import '../../features/onboarding/notifications_screen.dart';
import '../../features/onboarding/welcome_screen.dart';
import '../../features/onboarding/about_you_screen.dart';
import '../../features/onboarding/relationship_screen.dart';
import '../../features/onboarding/preferences_interests_screen.dart';
import '../../features/onboarding/preferences_love_languages_screen.dart';
import '../../features/onboarding/preferences_gifts_screen.dart';
import '../../features/onboarding/preferences_activities_screen.dart';
import '../../features/onboarding/preferences_cuisines_screen.dart';
import '../../features/onboarding/progress_graph_screen.dart';
import '../../features/onboarding/thank_you_screen.dart';
import '../../features/onboarding/trial_offer_screen.dart';
import '../../features/onboarding/trial_timeline_screen.dart';
import '../../features/onboarding/payment_annual_screen.dart';
import '../../features/onboarding/payment_all_plans_screen.dart';
import '../../features/onboarding/payment_gift_screen.dart';
import '../../features/onboarding/link_partner_screen.dart';
import '../../features/onboarding/complete_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/home_design_showcase.dart';
import '../../features/journal/my_space_screen.dart';
import '../../features/journal/about_partner_screen.dart';
import '../../features/journal/journal_entry_screen.dart';
import '../../features/recommendations/recommendations_screen.dart';
import '../../features/games/games_hub_screen.dart';
import '../../features/games/doodle/doodle_game_screen.dart';
import '../../features/games/safari/safari_game_screen.dart';
import '../../features/garden/garden_screen.dart';
import '../../features/garden/garden_history_screen.dart';
import '../../features/settings/settings_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding/welcome-social',
    routes: [
      // Onboarding Routes - Marketing Flow
      GoRoute(
        path: '/onboarding/welcome-social',
        builder: (context, state) => const WelcomeSocialProofScreen(),
      ),
      GoRoute(
        path: '/onboarding/goals',
        builder: (context, state) => const GoalsScreen(),
      ),
      GoRoute(
        path: '/onboarding/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/onboarding/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/onboarding/about-you',
        builder: (context, state) => const AboutYouScreen(),
      ),
      GoRoute(
        path: '/onboarding/relationship',
        builder: (context, state) => const RelationshipScreen(),
      ),
      GoRoute(
        path: '/onboarding/preferences/interests',
        builder: (context, state) => const PreferencesInterestsScreen(),
      ),
      GoRoute(
        path: '/onboarding/preferences/love-languages',
        builder: (context, state) => const PreferencesLoveLanguagesScreen(),
      ),
      GoRoute(
        path: '/onboarding/preferences/gifts',
        builder: (context, state) => const PreferencesGiftsScreen(),
      ),
      GoRoute(
        path: '/onboarding/preferences/activities',
        builder: (context, state) => const PreferencesActivitiesScreen(),
      ),
      GoRoute(
        path: '/onboarding/preferences/cuisines',
        builder: (context, state) => const PreferencesCuisinesScreen(),
      ),
      
      // Post-preferences marketing
      GoRoute(
        path: '/onboarding/progress-graph',
        builder: (context, state) => const ProgressGraphScreen(),
      ),
      GoRoute(
        path: '/onboarding/thank-you',
        builder: (context, state) => const ThankYouScreen(),
      ),
      GoRoute(
        path: '/onboarding/trial-offer',
        builder: (context, state) => const TrialOfferScreen(),
      ),
      GoRoute(
        path: '/onboarding/trial-timeline',
        builder: (context, state) => const TrialTimelineScreen(),
      ),
      
      // Payment
      GoRoute(
        path: '/onboarding/payment',
        builder: (context, state) => const PaymentAnnualScreen(),
      ),
      GoRoute(
        path: '/onboarding/payment/plans',
        builder: (context, state) => const PaymentAllPlansScreen(),
      ),
      GoRoute(
        path: '/onboarding/payment/gift',
        builder: (context, state) => const PaymentGiftScreen(),
      ),
      GoRoute(
        path: '/onboarding/link-partner',
        builder: (context, state) => const LinkPartnerScreen(),
      ),
      GoRoute(
        path: '/onboarding/complete',
        builder: (context, state) => const CompleteScreen(),
      ),

      // Main App Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/design-showcase',
        builder: (context, state) => const HomeDesignShowcase(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Journal Routes
      GoRoute(
        path: '/journal/my-space',
        builder: (context, state) => const MySpaceScreen(),
      ),
      GoRoute(
        path: '/journal/about-partner',
        builder: (context, state) => const AboutPartnerScreen(),
      ),
      GoRoute(
        path: '/journal/entry',
        builder: (context, state) {
          final space = state.uri.queryParameters['space'] ?? 'me';
          final entryId = state.uri.queryParameters['id'];
          return JournalEntryScreen(
            space: space == 'me' ? JournalSpace.me : JournalSpace.aboutPartner,
            entryId: entryId,
          );
        },
      ),

      // Recommendations Route
      GoRoute(
        path: '/recommendations',
        builder: (context, state) => const RecommendationsScreen(),
      ),

      // Games Routes
      GoRoute(
        path: '/games',
        builder: (context, state) => const GamesHubScreen(),
      ),
      GoRoute(
        path: '/games/doodle',
        builder: (context, state) => const DoodleGameScreen(),
      ),
      GoRoute(
        path: '/games/safari',
        builder: (context, state) => const SafariGameScreen(),
      ),

      // Garden Routes
      GoRoute(
        path: '/garden',
        builder: (context, state) => const GardenScreen(),
      ),
      GoRoute(
        path: '/garden/history',
        builder: (context, state) => const GardenHistoryScreen(),
      ),
    ],
  );
});
