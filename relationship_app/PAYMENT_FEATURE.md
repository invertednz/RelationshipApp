# Payment & Subscription Feature

## Overview
Implemented a complete payment/subscription flow with gift mechanism for the Relationship App, allowing users to choose from multiple subscription plans or receive a gifted subscription.

## Features Implemented

### 1. Subscription Plans

#### Annual Plan - $49/year (BEST VALUE)
- Price: \$49/year (\$4.08/month)
- Savings: \$59 vs monthly
- Features:
  - Unlimited journal entries
  - Personalized date recommendations
  - All games & activities
  - Together Garden tracker
  - Priority support

#### Monthly Plan - $9/month
- Price: \$9/month
- Cancel anytime
- Features:
  - Unlimited journal entries
  - Personalized date recommendations
  - All games & activities
  - Together Garden tracker

#### Pay It Forward - $59/year
- Price: \$59/year
- Annual plan + gift a couple in need
- Features:
  - Everything in Annual Plan
  - Gift subscription to another couple
  - Exclusive "Supporter" badge
  - Early access to new features
  - Warm fuzzy feelings ❤️

#### Gift Plan - $29 (3 months)
- Price: \$29 for 3 months
- Received from another user
- Features:
  - Unlimited journal entries
  - Personalized date recommendations
  - All games & activities
  - Together Garden tracker

### 2. Payment Flow

#### Screen 1: Annual Plan (Default)
**File**: `lib/features/onboarding/payment_annual_screen.dart`

- Shows the annual plan prominently
- Beautiful gradient card with "BEST VALUE" badge
- Feature list with check icons
- "View all plans" button to see alternatives
- "Skip" button → leads to gift screen
- Mock payment processing (2-second delay)

**Design Features**:
- Gradient card (primary to primaryDark)
- Box shadow for depth
- Large price display (\$49)
- Feature checklist with green check icons
- Processing state with spinner

#### Screen 2: All Plans
**File**: `lib/features/onboarding/payment_all_plans_screen.dart`

- Shows all 3 payment options: Annual, Pay It Forward, Monthly
- Selectable plan cards with radio selection
- Dynamic feature display based on selected plan
- "POPULAR" badge on Annual plan
- Savings badges on Annual and Pay It Forward
- Skip button → leads to gift screen

**Design Features**:
- Full-width plan cards
- Selection state with border and check icon
- Highlighted selected plan
- Bottom sheet style action bar
- Money-back guarantee message

#### Screen 3: Gift Received
**File**: `lib/features/onboarding/payment_gift_screen.dart`

- Shown when user clicks "Skip" on payment screens
- Random benefactor selection (70% female, 30% male names)
- 70 female names + 30 male names pool
- Random location assignment
- Animated gift icon (scale animation with elastic curve)
- Inspirational quote from benefactor
- Share button to share app with others
- Accept gift button
- Option to view paid plans instead

**Design Features**:
- Animated gift icon with elastic bounce
- Gradient benefactor card
- Avatar with initial
- Location display
- Quote bubble
- Gift plan value breakdown
- "Pay it forward" encouragement CTA
- Share functionality via share_plus

### 3. Gift Name System
**File**: `lib/core/utils/gift_names.dart`

**Female Names** (70 total):
Emma, Olivia, Ava, Isabella, Sophia, Mia, Charlotte, Amelia, Harper, Evelyn, Abigail, Emily, Elizabeth, Mila, Ella, Avery, Sofia, Camila, Aria, Scarlett, Victoria, Madison, Luna, Grace, Chloe, Penelope, Layla, Riley, Zoey, Nora, Lily, Eleanor, Hannah, Lillian, Addison, Aubrey, Ellie, Stella, Natalie, Zoe, Leah, Hazel, Violet, Aurora, Savannah, Audrey, Brooklyn, Bella, Claire, Skylar, Lucy, Paisley, Everly, Anna, Caroline, Nova, Genesis, Emilia, Kennedy, Samantha, Maya, Willow, Kinsley, Naomi, Aaliyah, Elena, Sarah, Ariana, Allison, Gabriella

**Male Names** (30 total):
Liam, Noah, Oliver, Elijah, James, William, Benjamin, Lucas, Henry, Alexander, Mason, Michael, Ethan, Daniel, Jacob, Logan, Jackson, Levi, Sebastian, Mateo, Jack, Owen, Theodore, Aiden, Samuel, Joseph, John, David, Wyatt, Matthew

**Locations** (15 total):
San Francisco CA, Austin TX, Portland OR, Seattle WA, Denver CO, Boston MA, Nashville TN, Chicago IL, New York NY, Los Angeles CA, Miami FL, Phoenix AZ, Philadelphia PA, San Diego CA, Minneapolis MN

**Logic**:
- `getRandomName()`: 70% probability female name, 30% male
- `getRandomLocation()`: Random city selection
- Names and locations are independently randomized

### 4. Data Models
**File**: `lib/core/models/subscription_plan.dart`

```dart
enum PlanType {
  monthly,
  annual,
  payItForward,
  gift,
}

class SubscriptionPlan {
  final PlanType type;
  final String title;
  final String price;
  final double amount;
  final String interval;
  final String? description;
  final List<String> features;
  final bool isPopular;
  final String? savingsText;
}
```

Static plan instances available:
- `SubscriptionPlan.annual`
- `SubscriptionPlan.monthly`
- `SubscriptionPlan.payItForward`
- `SubscriptionPlan.gift`
- `SubscriptionPlan.allPlans` (list of all)

### 5. Updated Navigation Flow

**New Onboarding Sequence**:
1. Welcome
2. About You
3. Relationship
4. Preferences - Interests
5. Preferences - Love Languages
6. Preferences - Gifts
7. Preferences - Activities
8. Preferences - Cuisines
9. **Payment (Annual Plan)** ← NEW
10. Link Partner (optional, after payment or gift)
11. Complete

**Payment Routes**:
- `/onboarding/payment` → Annual plan screen
- `/onboarding/payment/plans` → All plans screen
- `/onboarding/payment/gift` → Gift received screen

**User Paths**:
1. **Purchase Path**: Cuisines → Payment → Select Plan → Complete
2. **Gift Path**: Cuisines → Payment → Skip → Gift Screen → Accept → Complete
3. **Alternative Plans Path**: Cuisines → Payment → View All Plans → Select → Complete

### 6. Router Updates
**File**: `lib/core/router/app_router.dart`

Added imports:
```dart
import '../../features/onboarding/payment_annual_screen.dart';
import '../../features/onboarding/payment_all_plans_screen.dart';
import '../../features/onboarding/payment_gift_screen.dart';
```

Added routes after cuisines and before link-partner.

### 7. Dependencies Added
**File**: `pubspec.yaml`

```yaml
dependencies:
  share_plus: ^10.0.2  # For sharing app from gift screen
```

## Design Patterns

### Color Usage
- **Primary gradient**: Payment cards use gradient from `AppColors.primary` to `AppColors.primaryDark`
- **Accent badges**: "BEST VALUE" and "POPULAR" use `AppColors.accent`
- **Success icons**: Check marks use `AppColors.success`
- **Gift accent**: Gift card uses `AppColors.accentLight` and `accentDark`

### Animations
- **Gift screen**: Scale animation with `Curves.elasticOut` for bounce effect (800ms)
- **Payment processing**: 2-second simulated delay with loading spinner

### UX Patterns
- **Skip everywhere**: Users can skip payment on all screens
- **Back navigation**: All screens support back navigation
- **Share integration**: Gift screen has native share button
- **Processing states**: Loading spinners during payment simulation
- **Success feedback**: SnackBar confirmation on payment/acceptance

## Mock Payment Processing

All payment screens simulate payment processing:
```dart
Future<void> _handlePayment() async {
  setState(() => _isProcessing = true);
  await Future.delayed(const Duration(seconds: 2));
  // Show success, navigate to complete
}
```

No actual payment integration (Stripe, etc.) in this MVP version.

## Testing Checklist

- [ ] Navigate through full onboarding to payment screen
- [ ] View annual plan features
- [ ] Click "View all plans" → See 3 options
- [ ] Select each plan and view features
- [ ] Click "Skip" from annual plan → See gift screen
- [ ] Verify random benefactor name appears
- [ ] Verify random location appears
- [ ] Click share button → Share dialog appears
- [ ] Accept gift → Navigate to complete
- [ ] Test payment processing states
- [ ] Verify back navigation works on all screens
- [ ] Test "View paid plans instead" from gift screen

## Future Enhancements

### Backend Integration
- [ ] Connect to Stripe/RevenueCat for real payments
- [ ] Store subscription status in user profile
- [ ] Implement trial period logic
- [ ] Track subscription renewals
- [ ] Handle payment failures

### Gift System
- [ ] Real gift code generation and redemption
- [ ] Track who gifted to whom
- [ ] Send notification when gift is accepted
- [ ] Analytics on gift conversion rates
- [ ] Gift inventory management

### Features
- [ ] Promo codes and discounts
- [ ] Family plan for multiple couples
- [ ] Lifetime plan option
- [ ] Restore purchases
- [ ] Subscription management page
- [ ] Receipt/invoice generation
- [ ] Cancel subscription flow
- [ ] Resubscribe flow

### Analytics Events
- `payment_screen_viewed`
- `plan_selected: {plan_type}`
- `payment_initiated: {plan_type, amount}`
- `payment_completed: {plan_type, amount}`
- `payment_skipped`
- `gift_received_viewed`
- `gift_accepted: {benefactor_name}`
- `gift_shared`
- `all_plans_viewed`

## Files Created

1. `lib/core/models/subscription_plan.dart` - Plan data models
2. `lib/core/utils/gift_names.dart` - Random name generator
3. `lib/features/onboarding/payment_annual_screen.dart` - Annual plan screen
4. `lib/features/onboarding/payment_all_plans_screen.dart` - All plans screen
5. `lib/features/onboarding/payment_gift_screen.dart` - Gift received screen

## Files Modified

1. `lib/core/router/app_router.dart` - Added payment routes
2. `lib/features/onboarding/preferences_cuisines_screen.dart` - Navigate to payment
3. `pubspec.yaml` - Added share_plus dependency

---

**Status**: ✅ Complete - Ready for testing
**Next Step**: Run `flutter pub get` to install share_plus dependency
