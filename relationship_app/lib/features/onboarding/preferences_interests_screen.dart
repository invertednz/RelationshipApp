import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';
import 'widgets/preference_item.dart';

class PreferencesInterestsScreen extends ConsumerStatefulWidget {
  const PreferencesInterestsScreen({super.key});

  @override
  ConsumerState<PreferencesInterestsScreen> createState() => _PreferencesInterestsScreenState();
}

class _PreferencesInterestsScreenState extends ConsumerState<PreferencesInterestsScreen> {
  final List<String> _selectedInterests = [];
  final List<String> _customInterests = [];
  final _customController = TextEditingController();

  final List<Map<String, dynamic>> _interestOptions = [
    {'label': 'Hiking & Nature', 'icon': Icons.hiking, 'value': 'hiking'},
    {'label': 'Cooking Together', 'icon': Icons.restaurant, 'value': 'cooking'},
    {'label': 'Movies & TV Shows', 'icon': Icons.movie, 'value': 'movies'},
    {'label': 'Museums & Art', 'icon': Icons.museum, 'value': 'museums'},
    {'label': 'Beach & Water', 'icon': Icons.beach_access, 'value': 'beach'},
    {'label': 'Gaming', 'icon': Icons.sports_esports, 'value': 'gaming'},
    {'label': 'Arts & Crafts', 'icon': Icons.palette, 'value': 'art'},
    {'label': 'Live Music & Concerts', 'icon': Icons.music_note, 'value': 'music'},
    {'label': 'Travel & Adventure', 'icon': Icons.flight, 'value': 'travel'},
    {'label': 'Shopping', 'icon': Icons.shopping_bag, 'value': 'shopping'},
    {'label': 'Reading & Books', 'icon': Icons.menu_book, 'value': 'reading'},
    {'label': 'Fitness & Sports', 'icon': Icons.fitness_center, 'value': 'fitness'},
    {'label': 'Photography', 'icon': Icons.camera_alt, 'value': 'photography'},
    {'label': 'Dancing', 'icon': Icons.nightlife, 'value': 'dancing'},
    {'label': 'Board Games', 'icon': Icons.extension, 'value': 'board_games'},
  ];

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        _selectedInterests.add(interest);
      }
    });
  }

  void _addCustomInterest() {
    if (_customController.text.trim().isNotEmpty) {
      setState(() {
        _customInterests.add(_customController.text.trim());
        _customController.clear();
      });
    }
  }

  void _continue() {
    final currentProfile = ref.read(userProfileProvider);
    if (currentProfile != null) {
      final updated = currentProfile.copyWith(
        interests: _selectedInterests,
        customInterests: _customInterests,
      );
      ref.read(userProfileProvider.notifier).updateProfile(updated);
    }
    context.go('/onboarding/preferences/love-languages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/relationship'),
        ),
        title: const Text('Your Interests'),
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
                  const LinearProgressIndicator(value: 0.5),
                  const SizedBox(height: 24),
                  Text(
                    'What do you enjoy?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select all that apply',
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
                  ..._interestOptions.map((option) {
                    return PreferenceItem(
                      icon: option['icon'],
                      label: option['label'],
                      isSelected: _selectedInterests.contains(option['value']),
                      onTap: () => _toggleInterest(option['value']),
                    );
                  }),
                  const SizedBox(height: 16),
                  Text(
                    'Not seeing your interest?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _customController,
                          decoration: InputDecoration(
                            hintText: 'Add your own...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.add_circle, color: AppColors.primary),
                              onPressed: _addCustomInterest,
                            ),
                          ),
                          onSubmitted: (_) => _addCustomInterest(),
                        ),
                      ),
                    ],
                  ),
                  if (_customInterests.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _customInterests.map((custom) {
                        return Chip(
                          label: Text(custom),
                          backgroundColor: AppColors.secondaryLight,
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            setState(() => _customInterests.remove(custom));
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
