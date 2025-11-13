import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';
import 'widgets/preference_item.dart';

class PreferencesLoveLanguagesScreen extends ConsumerStatefulWidget {
  const PreferencesLoveLanguagesScreen({super.key});

  @override
  ConsumerState<PreferencesLoveLanguagesScreen> createState() => _PreferencesLoveLanguagesScreenState();
}

class _PreferencesLoveLanguagesScreenState extends ConsumerState<PreferencesLoveLanguagesScreen> {
  final List<String> _selectedLanguages = [];

  final List<Map<String, dynamic>> _languageOptions = [
    {
      'label': 'Words of Affirmation',
      'icon': Icons.chat_bubble_outline,
      'value': 'words',
      'description': 'Compliments, encouragement, and verbal appreciation',
    },
    {
      'label': 'Quality Time',
      'icon': Icons.favorite,
      'value': 'quality_time',
      'description': 'Undivided attention and meaningful conversations',
    },
    {
      'label': 'Receiving Gifts',
      'icon': Icons.card_giftcard,
      'value': 'gifts',
      'description': 'Thoughtful presents that show you care',
    },
    {
      'label': 'Acts of Service',
      'icon': Icons.handshake,
      'value': 'acts',
      'description': 'Doing helpful things to make life easier',
    },
    {
      'label': 'Physical Touch',
      'icon': Icons.touch_app,
      'value': 'touch',
      'description': 'Hugs, holding hands, and physical closeness',
    },
  ];

  void _toggleLanguage(String language) {
    setState(() {
      if (_selectedLanguages.contains(language)) {
        _selectedLanguages.remove(language);
      } else {
        _selectedLanguages.add(language);
      }
    });
  }

  void _continue() {
    final currentProfile = ref.read(userProfileProvider);
    if (currentProfile != null) {
      final updated = currentProfile.copyWith(
        loveLanguages: _selectedLanguages,
      );
      ref.read(userProfileProvider.notifier).updateProfile(updated);
    }
    context.go('/onboarding/preferences/gifts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/preferences/interests'),
        ),
        title: const Text('Love Languages'),
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
                  const LinearProgressIndicator(value: 0.6),
                  const SizedBox(height: 24),
                  Text(
                    'How do you feel loved?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select your top love languages',
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
                  ..._languageOptions.map((option) {
                    return PreferenceItem(
                      icon: option['icon'],
                      label: option['label'],
                      description: option['description'],
                      isSelected: _selectedLanguages.contains(option['value']),
                      onTap: () => _toggleLanguage(option['value']),
                    );
                  }),
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
