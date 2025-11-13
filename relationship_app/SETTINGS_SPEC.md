# Settings & Subscription Management Spec

## Overview
Complete settings screen with role-based access controls for subscription management, partner connections, and account actions.

---

## User Roles

### Primary User (Paying User)
- The user who subscribed and pays for the account
- **Can**:
  - Cancel subscription (affects both users)
  - Remove partner from account
  - Manage payment method
  - Delete entire account (deletes all data)
  - Invite partner

### Partner User (Non-Paying User)
- The user who was invited by the primary user
- **Can**:
  - Leave the relationship account
  - Delete their own account (removes only their data)
  - View subscription status (read-only)
  - Cannot cancel subscription or remove primary user

---

## Settings Screen Structure

### 1. Account Section
- **Profile** - Edit personal information (Coming soon)
- **Notifications** - Manage notification preferences (Coming soon)

### 2. Relationship Section

#### If No Partner:
- **Invite Partner** - Send email invitation to connect

#### If Partner Connected:
- **Partner Connected** - Shows partner email with checkmark
- **Remove Partner** (Primary user only) - Disconnect partner
- **Leave Relationship** (Partner user only) - Disconnect from account

### 3. Subscription Section (Primary User Only)
- **Premium Plan** - Shows status, price, next billing date
- **Payment Method** - Manage credit card (Coming soon)
- **Cancel Subscription** - End premium membership

### 4. Support Section
- **Help & FAQ** - Common questions (Coming soon)
- **Contact Support** - Get help (Coming soon)
- **Privacy Policy** - Data protection info (Coming soon)
- **Terms of Service** - Usage terms (Coming soon)

### 5. Danger Zone
- **Delete Account** - Permanently delete all data

---

## Key Dialogs

### Invite Partner Dialog
- Email input field
- Sends invitation link
- Partner creates account and links via invitation code
- Success message on send

### Remove Partner Dialog (Primary User)
**Warning**: "Are you sure you want to remove your partner?"

**Effects**:
- Partner loses access to shared features
- Partner's private journal entries remain intact
- Can be invited again later

**Actions**: Cancel | Remove Partner

### Leave Relationship Dialog (Partner User)
**Warning**: "Are you sure you want to leave this relationship account?"

**Effects**:
- You lose access to shared features
- Your private journal entries are preserved
- Primary user can invite you again later

**Actions**: Cancel | Leave

### Cancel Subscription Dialog (Primary User)
**Warning**: "Are you sure you want to cancel your premium subscription?"

**Effects**:
- Lose access to premium features
- Partner also loses access
- Data is preserved
- Can resubscribe anytime
- Subscription remains active until end of billing period

**Actions**: Keep Subscription | Cancel Subscription

### Delete Account Dialog

#### Primary User Version:
**⚠️ WARNING: Permanent action**

**Effects**:
- Cancels subscription immediately
- Removes partner's access
- Deletes ALL journal entries (both users)
- Deletes ALL shared data and progress

**Confirmation**: Type "DELETE" to confirm

#### Partner User Version:
**⚠️ WARNING: Permanent action**

**Effects**:
- Removes your access to this account
- Deletes ALL your journal entries
- Preserves the primary account

**Confirmation**: Type "DELETE" to confirm

**Actions**: Cancel | Delete Forever

---

## Visual Design

### Card-Based Layout
Each setting is a card with:
- Icon (color-coded by function)
- Title (bold)
- Subtitle (description)
- Trailing element (arrow, badge, or checkmark)
- Border color matches function (warning = orange, error = red)

### Section Headers
- All caps with letter spacing
- Gray color
- Separates logical groups

### Color Coding
- **Normal**: Default text color
- **Success/Active**: Green (partner connected, active subscription)
- **Warning**: Orange (remove partner, leave relationship)
- **Error/Danger**: Red (cancel subscription, delete account)

---

## State Management (TODO)

### Required State:
```dart
class UserAccount {
  String userId;
  String email;
  bool isPrimaryUser; // Did this user subscribe?
  String? partnerId;
  String? partnerEmail;
  
  SubscriptionStatus subscription;
  PaymentMethod? paymentMethod;
}

class SubscriptionStatus {
  bool isActive;
  String plan; // e.g., "Premium Annual"
  double price; // e.g., 49.00
  DateTime nextBillingDate;
  DateTime? cancellationDate; // If cancelled but still active
}
```

### Required Providers:
```dart
// Current user account info
final userAccountProvider = StateNotifierProvider<UserAccountNotifier, UserAccount?>(...);

// Subscription management
final subscriptionProvider = StateNotifierProvider<SubscriptionNotifier, SubscriptionStatus?>(...);
```

---

## API Endpoints (TODO - Backend)

### Partner Management
```
POST /api/partners/invite
  Body: { email: string }
  Response: { invitationId: string, sent: boolean }

DELETE /api/partners/remove
  Body: { partnerId: string }
  Response: { success: boolean }

POST /api/partners/leave
  Response: { success: boolean }
```

### Subscription Management
```
POST /api/subscription/cancel
  Response: { cancelledAt: timestamp, activeUntil: timestamp }

GET /api/subscription/status
  Response: { status, plan, price, nextBilling }

PUT /api/subscription/payment-method
  Body: { paymentToken: string }
  Response: { success: boolean }
```

### Account Management
```
DELETE /api/account
  Body: { confirmation: "DELETE" }
  Response: { success: boolean }
```

---

## Navigation

### Access Points:
1. **Home screen** - Settings icon in top-right (magazine layout)
2. **App bar** - Settings option in menu (other screens)
3. **Direct route**: `/settings`

### Exit Points:
- Back button returns to previous screen
- After account deletion → Redirect to onboarding

---

## Files Created

1. **`lib/features/settings/settings_screen.dart`** (520 lines)
   - Complete settings UI
   - All dialogs implemented
   - Role-based rendering
   - Mock data (isPrimaryUser = true, hasPartner = false)

2. **`SETTINGS_SPEC.md`** (this file)
   - Complete specification
   - User roles documentation
   - Dialog flows
   - State management requirements

---

## Files Modified

1. **`lib/core/router/app_router.dart`**
   - Added `/settings` route
   - Imported `SettingsScreen`

2. **`lib/features/home/home_screen_design3_magazine.dart`**
   - Added settings icon button to header
   - Routes to `/settings` on tap

---

## Testing Checklist

### UI Testing:
- [ ] Settings screen loads
- [ ] All sections render correctly
- [ ] Cards are tappable
- [ ] Dialogs open/close properly
- [ ] Role-based sections show/hide correctly

### Role Testing:
- [ ] Primary user sees subscription section
- [ ] Primary user sees "Remove Partner" option
- [ ] Partner user sees "Leave Relationship" option
- [ ] Partner user does NOT see subscription management

### Dialog Testing:
- [ ] Invite partner dialog accepts email
- [ ] Remove partner shows correct warning
- [ ] Leave relationship shows correct warning
- [ ] Cancel subscription shows effects clearly
- [ ] Delete account requires "DELETE" confirmation
- [ ] Delete account shows different text for primary vs partner

### Navigation Testing:
- [ ] Settings icon works from home screen
- [ ] Back button returns to previous screen
- [ ] After deletion, redirects to onboarding

---

## Implementation Priority

### Phase 1: ✅ Complete (UI Only)
- Settings screen UI
- All dialogs with mock actions
- Role-based rendering (hardcoded)
- Navigation integration

### Phase 2: Backend Integration (TODO)
- State management setup
- API endpoint implementation
- Real subscription status
- Real partner linking
- Payment method integration

### Phase 3: Polish (TODO)
- Loading states during API calls
- Error handling & retry
- Email validation
- Confirmation emails
- Success animations

---

## Security Considerations

### Authorization:
- Backend must verify user role before allowing:
  - Subscription cancellation (primary only)
  - Partner removal (primary only)
  - Account deletion (verify ownership)

### Data Privacy:
- Partner email only visible to both users
- Subscription details only visible to primary user
- Payment info never fully displayed
- Deletion is irreversible (confirm carefully)

### Audit Trail:
- Log all subscription changes
- Log partner additions/removals
- Log account deletions
- Maintain records for billing disputes

---

## Future Enhancements

### Phase 4: Advanced Features
- [ ] Multiple payment methods
- [ ] Billing history
- [ ] Download data export before deletion
- [ ] Referral/gift codes
- [ ] Family plan (3+ users)
- [ ] Pause subscription (not cancel)
- [ ] Downgrade to free tier
- [ ] Annual renewal reminders

### Phase 5: Communication
- [ ] In-app chat with support
- [ ] Video tutorials
- [ ] Contextual help tooltips
- [ ] Feature announcements

---

**Status**: ✅ Phase 1 Complete - UI Ready for Testing
**Next Step**: Implement state management and API integration
**Access**: Home screen → Settings icon → `/settings`
