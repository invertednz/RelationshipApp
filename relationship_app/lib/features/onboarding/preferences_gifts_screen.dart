import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';
import 'widgets/preference_item.dart';

class PreferencesGiftsScreen extends ConsumerStatefulWidget {
  const PreferencesGiftsScreen({super.key});

  @override
  ConsumerState<PreferencesGiftsScreen> createState() => _PreferencesGiftsScreenState();
}

class _PreferencesGiftsScreenState extends ConsumerState<PreferencesGiftsScreen> {
  final List<String> _selectedGifts = [];
  final _customController = TextEditingController();
  final List<String> _customGifts = [];

  final List<Map<String, dynamic>> _giftOptions = [
    {'label': 'Flowers & Plants', 'icon': Icons.local_florist, 'value': 'flowers'},
    {'label': 'Handwritten Notes', 'icon': Icons.edit_note, 'value': 'notes'},
    {'label': 'Jewelry & Accessories', 'icon': Icons.diamond, 'value': 'jewelry'},
    {'label': 'Books & Magazines', 'icon': Icons.menu_book, 'value': 'books'},
    {'label': 'Tech Gadgets', 'icon': Icons.devices, 'value': 'tech'},
    {'label': 'Clothing & Fashion', 'icon': Icons.checkroom, 'value': 'clothing'},
    {'label': 'Home Decor', 'icon': Icons.chair, 'value': 'decor'},
    {'label': 'Experiences & Tickets', 'icon': Icons.confirmation_number, 'value': 'experiences'},
    {'label': 'Food & Treats', 'icon': Icons.cake, 'value': 'food'},
    {'label': 'Self-Care Items', 'icon': Icons.spa, 'value': 'self_care'},
    {'label': 'Art & Collectibles', 'icon': Icons.palette, 'value': 'art'},
    {'label': 'Subscription Services', 'icon': Icons.card_membership, 'value': 'subscriptions'},
  ];

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _toggleGift(String gift) {
    setState(() {
      if (_selectedGifts.contains(gift)) {
        _selectedGifts.remove(gift);
      } else {
        _selectedGifts.add(gift);
      }
    });
  }

  void _addCustomGift() {
    if (_customController.text.trim().isNotEmpty) {
      setState(() {
        _customGifts.add(_customController.text.trim());
        _customController.clear();
      });
    }
  }

  void _continue() {
    final currentProfile = ref.read(userProfileProvider);
    if (currentProfile != null) {
      final allGifts = [..._selectedGifts, ..._customGifts];
      final updated = currentProfile.copyWith(giftPreferences: allGifts);
      ref.read(userProfileProvider.notifier).updateProfile(updated);
    }
    context.go('/onboarding/preferences/activities');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/preferences/love-languages'),
        ),
        title: const Text('Gift Preferences'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LinearProgressIndicator(value: 0.7),
                  const SizedBox(height: 24),
                  Text(
                    'What gifts do you love?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Help your partner know what you appreciate',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  ..._giftOptions.map((option) {
                    return PreferenceItem(
                      icon: option['icon'],
                      label: option['label'],
                      isSelected: _selectedGifts.contains(option['value']),
                      onTap: () => _toggleGift(option['value']),
                    );
                  }),
                  const SizedBox(height: 16),
                  Text(
                    'Add your own',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _customController,
                    decoration: InputDecoration(
                      hintText: 'e.g., Vintage vinyl records',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add_circle, color: AppColors.primary),
                        onPressed: _addCustomGift,
                      ),
                    ),
                    onSubmitted: (_) => _addCustomGift(),
                  ),
                  if (_customGifts.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _customGifts.map((custom) {
                        return Chip(
                          label: Text(custom),
                          backgroundColor: AppColors.accentLight,
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            setState(() => _customGifts.remove(custom));
                          },
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
