import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';
import 'widgets/preference_item.dart';

class PreferencesActivitiesScreen extends ConsumerStatefulWidget {
  const PreferencesActivitiesScreen({super.key});

  @override
  ConsumerState<PreferencesActivitiesScreen> createState() => _PreferencesActivitiesScreenState();
}

class _PreferencesActivitiesScreenState extends ConsumerState<PreferencesActivitiesScreen> {
  final List<String> _selectedActivities = [];
  final List<String> _customActivities = [];
  final _customController = TextEditingController();

  final List<Map<String, dynamic>> _activityOptions = [
    {'label': 'Going for walks', 'icon': Icons.directions_walk, 'value': 'walks'},
    {'label': 'Cooking meals together', 'icon': Icons.restaurant_menu, 'value': 'cooking'},
    {'label': 'Movie nights', 'icon': Icons.movie, 'value': 'movies'},
    {'label': 'Weekend getaways', 'icon': Icons.luggage, 'value': 'getaways'},
    {'label': 'Trying new restaurants', 'icon': Icons.restaurant, 'value': 'dining'},
    {'label': 'Exercise & sports', 'icon': Icons.fitness_center, 'value': 'fitness'},
    {'label': 'Concerts & live shows', 'icon': Icons.music_note, 'value': 'concerts'},
    {'label': 'Game nights', 'icon': Icons.sports_esports, 'value': 'games'},
    {'label': 'Exploring new places', 'icon': Icons.explore, 'value': 'exploring'},
    {'label': 'Volunteering', 'icon': Icons.volunteer_activism, 'value': 'volunteering'},
    {'label': 'Coffee shop visits', 'icon': Icons.local_cafe, 'value': 'coffee'},
    {'label': 'Outdoor adventures', 'icon': Icons.landscape, 'value': 'outdoors'},
    {'label': 'Arts & crafts projects', 'icon': Icons.brush, 'value': 'crafts'},
    {'label': 'Dancing', 'icon': Icons.nightlife, 'value': 'dancing'},
    {'label': 'Picnics', 'icon': Icons.outdoor_grill, 'value': 'picnics'},
    {'label': 'Stargazing', 'icon': Icons.nights_stay, 'value': 'stargazing'},
  ];

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _toggleActivity(String activity) {
    setState(() {
      if (_selectedActivities.contains(activity)) {
        _selectedActivities.remove(activity);
      } else {
        _selectedActivities.add(activity);
      }
    });
  }

  void _addCustomActivity() {
    if (_customController.text.trim().isNotEmpty) {
      setState(() {
        _customActivities.add(_customController.text.trim());
        _customController.clear();
      });
    }
  }

  void _continue() {
    final currentProfile = ref.read(userProfileProvider);
    if (currentProfile != null) {
      final updated = currentProfile.copyWith(
        activities: _selectedActivities,
        customActivities: _customActivities,
      );
      ref.read(userProfileProvider.notifier).updateProfile(updated);
    }
    context.go('/onboarding/preferences/cuisines');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/preferences/gifts'),
        ),
        title: const Text('Activities'),
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
                  const LinearProgressIndicator(value: 0.8),
                  const SizedBox(height: 24),
                  Text(
                    'What do you love doing together?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select your favorite couple activities',
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
                  ..._activityOptions.map((option) {
                    return PreferenceItem(
                      icon: option['icon'],
                      label: option['label'],
                      isSelected: _selectedActivities.contains(option['value']),
                      onTap: () => _toggleActivity(option['value']),
                    );
                  }),
                  const SizedBox(height: 16),
                  Text(
                    'Add your own activity',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _customController,
                    decoration: InputDecoration(
                      hintText: 'e.g., Birdwatching, Pottery classes',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add_circle, color: AppColors.primary),
                        onPressed: _addCustomActivity,
                      ),
                    ),
                    onSubmitted: (_) => _addCustomActivity(),
                  ),
                  if (_customActivities.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _customActivities.map((custom) {
                        return Chip(
                          label: Text(custom),
                          backgroundColor: AppColors.secondaryLight,
                          deleteIcon: const Icon(Icons.close, size: 18),
                          onDeleted: () {
                            setState(() => _customActivities.remove(custom));
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
