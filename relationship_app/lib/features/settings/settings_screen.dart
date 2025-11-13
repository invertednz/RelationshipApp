import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

/// Settings Screen - Manage account, subscription, and partner
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Get actual user role from state management
    // For now, mock as paying user
    final isPrimaryUser = true; // User who subscribed/paid
    final hasPartner = false; // Whether partner is linked
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Account Section
          const _SectionHeader(title: 'ACCOUNT'),
          const SizedBox(height: 12),
          
          _SettingsCard(
            icon: Icons.person,
            title: 'Profile',
            subtitle: 'Edit your personal information',
            onTap: () => _showComingSoon(context, 'Profile editing'),
          ),
          
          _SettingsCard(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Manage notification preferences',
            onTap: () => _showComingSoon(context, 'Notification settings'),
          ),
          
          const SizedBox(height: 24),
          
          // Partner Section
          const _SectionHeader(title: 'RELATIONSHIP'),
          const SizedBox(height: 12),
          
          if (!hasPartner)
            _SettingsCard(
              icon: Icons.person_add,
              title: 'Invite Partner',
              subtitle: 'Connect with your partner',
              color: AppColors.success,
              onTap: () => _showInvitePartnerDialog(context),
            )
          else ...[
            _SettingsCard(
              icon: Icons.favorite,
              title: 'Partner Connected',
              subtitle: 'partner@example.com',
              trailing: const Icon(Icons.check_circle, color: AppColors.success),
              onTap: null,
            ),
            
            if (isPrimaryUser)
              _SettingsCard(
                icon: Icons.person_remove,
                title: 'Remove Partner',
                subtitle: 'Disconnect your partner from this account',
                color: AppColors.warning,
                onTap: () => _showRemovePartnerDialog(context),
              )
            else
              _SettingsCard(
                icon: Icons.exit_to_app,
                title: 'Leave Relationship',
                subtitle: 'Disconnect from this account',
                color: AppColors.warning,
                onTap: () => _showLeaveDialog(context),
              ),
          ],
          
          const SizedBox(height: 24),
          
          // Subscription Section
          if (isPrimaryUser) ...[
            const _SectionHeader(title: 'SUBSCRIPTION'),
            const SizedBox(height: 12),
            
            _SettingsCard(
              icon: Icons.card_membership,
              title: 'Premium Plan',
              subtitle: '\$49/year • Next billing: Dec 15, 2025',
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
              ),
              onTap: null,
            ),
            
            _SettingsCard(
              icon: Icons.credit_card,
              title: 'Payment Method',
              subtitle: 'Visa ending in 4242',
              onTap: () => _showComingSoon(context, 'Payment method management'),
            ),
            
            _SettingsCard(
              icon: Icons.cancel,
              title: 'Cancel Subscription',
              subtitle: 'End your premium membership',
              color: AppColors.error,
              onTap: () => _showCancelSubscriptionDialog(context),
            ),
          ],
          
          const SizedBox(height: 24),
          
          // Support Section
          const _SectionHeader(title: 'SUPPORT'),
          const SizedBox(height: 12),
          
          _SettingsCard(
            icon: Icons.help_outline,
            title: 'Help & FAQ',
            subtitle: 'Get answers to common questions',
            onTap: () => _showComingSoon(context, 'Help center'),
          ),
          
          _SettingsCard(
            icon: Icons.mail_outline,
            title: 'Contact Support',
            subtitle: 'Get help from our team',
            onTap: () => _showComingSoon(context, 'Contact support'),
          ),
          
          _SettingsCard(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'How we protect your data',
            onTap: () => _showComingSoon(context, 'Privacy policy'),
          ),
          
          _SettingsCard(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            subtitle: 'Usage terms and conditions',
            onTap: () => _showComingSoon(context, 'Terms of service'),
          ),
          
          const SizedBox(height: 24),
          
          // Danger Zone
          const _SectionHeader(title: 'DANGER ZONE'),
          const SizedBox(height: 12),
          
          _SettingsCard(
            icon: Icons.delete_forever,
            title: 'Delete Account',
            subtitle: 'Permanently delete all your data',
            color: AppColors.error,
            onTap: () => _showDeleteAccountDialog(context, isPrimaryUser),
          ),
          
          const SizedBox(height: 32),
          
          // App Version
          Center(
            child: Text(
              'Relationship App v1.0.0',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Coming Soon'),
        content: Text('$feature will be available in a future update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showInvitePartnerDialog(BuildContext context) {
    final emailController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.person_add, color: AppColors.primary),
            const SizedBox(width: 12),
            const Text('Invite Partner'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send an invitation to your partner to join you in the app.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Partner\'s Email',
                hintText: 'partner@example.com',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement invite logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Invitation sent!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Send Invite'),
          ),
        ],
      ),
    );
  }

  void _showRemovePartnerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: AppColors.warning),
            const SizedBox(width: 12),
            const Text('Remove Partner'),
          ],
        ),
        content: const Text(
          'Are you sure you want to remove your partner from this account?\n\n'
          'They will lose access to shared features, but their private journal entries will remain intact. '
          'You can invite them again later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement remove partner logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Partner removed'),
                  backgroundColor: AppColors.warning,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove Partner'),
          ),
        ],
      ),
    );
  }

  void _showLeaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.exit_to_app, color: AppColors.warning),
            const SizedBox(width: 12),
            const Text('Leave Relationship'),
          ],
        ),
        content: const Text(
          'Are you sure you want to leave this relationship account?\n\n'
          'You will lose access to shared features, but your private journal entries will be preserved. '
          'The primary account holder can invite you again later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement leave logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have left the relationship account'),
                  backgroundColor: AppColors.warning,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
              foregroundColor: Colors.white,
            ),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  void _showCancelSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.cancel, color: AppColors.error),
            const SizedBox(width: 12),
            const Text('Cancel Subscription'),
          ],
        ),
        content: const Text(
          'Are you sure you want to cancel your premium subscription?\n\n'
          '• You\'ll lose access to premium features\n'
          '• Your partner will also lose access\n'
          '• Your data will be preserved\n'
          '• You can resubscribe anytime\n\n'
          'Your subscription will remain active until Dec 15, 2025.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keep Subscription'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement cancel subscription logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Subscription cancelled. Active until Dec 15, 2025'),
                  backgroundColor: AppColors.error,
                  duration: Duration(seconds: 4),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancel Subscription'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context, bool isPrimaryUser) {
    final confirmController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.delete_forever, color: AppColors.error),
            const SizedBox(width: 12),
            const Text('Delete Account'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isPrimaryUser
                  ? '⚠️ WARNING: This action is permanent and cannot be undone.\n\n'
                      'Deleting your account will:\n'
                      '• Cancel your subscription immediately\n'
                      '• Remove your partner\'s access\n'
                      '• Delete ALL journal entries (yours and partner\'s)\n'
                      '• Delete ALL shared data and progress\n\n'
                      'Type DELETE to confirm:'
                  : '⚠️ WARNING: This action is permanent and cannot be undone.\n\n'
                      'Deleting your account will:\n'
                      '• Remove your access to this account\n'
                      '• Delete ALL your journal entries\n'
                      '• Preserve the primary account\n\n'
                      'Type DELETE to confirm:',
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: confirmController,
              decoration: const InputDecoration(
                hintText: 'Type DELETE',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (confirmController.text == 'DELETE') {
                // TODO: Implement account deletion logic
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account deleted'),
                    backgroundColor: AppColors.error,
                  ),
                );
                // Navigate to onboarding or login
                context.go('/onboarding/welcome-social');
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please type DELETE to confirm'),
                    backgroundColor: AppColors.warning,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete Forever'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final Color? color;
  final VoidCallback? onTap;

  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.textPrimary;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color?.withOpacity(0.2) ?? Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: cardColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: cardColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: cardColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null)
                  trailing!
                else if (onTap != null)
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
