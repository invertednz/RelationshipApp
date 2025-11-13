import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';

class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({super.key});

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  final List<String> _selectedInterests = [];
  final List<String> _selectedCuisines = [];
  int _budgetPreference = 2;

  final List<String> _interestOptions = [
    'Hiking', 'Cooking', 'Movies', 'Museums', 'Beach',
    'Gaming', 'Art', 'Music', 'Travel', 'Shopping',
  ];

  final List<String> _cuisineOptions = [
    'Italian', 'Japanese', 'Mexican', 'Chinese', 'Thai',
    'Indian', 'American', 'French', 'Mediterranean',
  ];

  void _continue() {
    final currentProfile = ref.read(userProfileProvider);
    if (currentProfile != null) {
      final updated = currentProfile.copyWith(
        interests: _selectedInterests,
        cuisines: _selectedCuisines,
        budgetPreference: _budgetPreference,
      );
      ref.read(userProfileProvider.notifier).updateProfile(updated);
    }
    context.go('/onboarding/link-partner');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/relationship'),
        ),
        title: const Text('Preferences'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LinearProgressIndicator(value: 0.6),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      'What are you interested in?',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _interestOptions.map((interest) {
                        final isSelected = _selectedInterests.contains(interest);
                        return FilterChip(
                          label: Text(interest),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedInterests.add(interest);
                              } else {
                                _selectedInterests.remove(interest);
                              }
                            });
                          },
                          selectedColor: AppColors.primaryLight,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Favorite cuisines?',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _cuisineOptions.map((cuisine) {
                        final isSelected = _selectedCuisines.contains(cuisine);
                        return FilterChip(
                          label: Text(cuisine),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedCuisines.add(cuisine);
                              } else {
                                _selectedCuisines.remove(cuisine);
                              }
                            });
                          },
                          selectedColor: AppColors.accentLight,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Typical budget for dates',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _BudgetChip(
                          label: '\$',
                          value: 1,
                          selected: _budgetPreference == 1,
                          onTap: () => setState(() => _budgetPreference = 1),
                        ),
                        const SizedBox(width: 12),
                        _BudgetChip(
                          label: '\$\$',
                          value: 2,
                          selected: _budgetPreference == 2,
                          onTap: () => setState(() => _budgetPreference = 2),
                        ),
                        const SizedBox(width: 12),
                        _BudgetChip(
                          label: '\$\$\$',
                          value: 3,
                          selected: _budgetPreference == 3,
                          onTap: () => setState(() => _budgetPreference = 3),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BudgetChip extends StatelessWidget {
  final String label;
  final int value;
  final bool selected;
  final VoidCallback onTap;

  const _BudgetChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.neutralLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primaryDark : AppColors.neutral,
              width: 2,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
