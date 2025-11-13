import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';
import 'widgets/preference_item.dart';

class PreferencesCuisinesScreen extends ConsumerStatefulWidget {
  const PreferencesCuisinesScreen({super.key});

  @override
  ConsumerState<PreferencesCuisinesScreen> createState() => _PreferencesCuisinesScreenState();
}

class _PreferencesCuisinesScreenState extends ConsumerState<PreferencesCuisinesScreen> {
  final List<String> _selectedCuisines = [];
  int _budgetPreference = 2;

  final List<Map<String, dynamic>> _cuisineOptions = [
    {'label': 'Italian', 'icon': Icons.local_pizza, 'value': 'italian'},
    {'label': 'Japanese & Sushi', 'icon': Icons.ramen_dining, 'value': 'japanese'},
    {'label': 'Mexican', 'icon': Icons.lunch_dining, 'value': 'mexican'},
    {'label': 'Chinese', 'icon': Icons.restaurant, 'value': 'chinese'},
    {'label': 'Thai', 'icon': Icons.rice_bowl, 'value': 'thai'},
    {'label': 'Indian', 'icon': Icons.restaurant_menu, 'value': 'indian'},
    {'label': 'American', 'icon': Icons.fastfood, 'value': 'american'},
    {'label': 'French', 'icon': Icons.cake, 'value': 'french'},
    {'label': 'Mediterranean', 'icon': Icons.kebab_dining, 'value': 'mediterranean'},
    {'label': 'Korean', 'icon': Icons.soup_kitchen, 'value': 'korean'},
    {'label': 'Vietnamese', 'icon': Icons.food_bank, 'value': 'vietnamese'},
    {'label': 'Spanish & Tapas', 'icon': Icons.tapas, 'value': 'spanish'},
  ];

  void _toggleCuisine(String cuisine) {
    setState(() {
      if (_selectedCuisines.contains(cuisine)) {
        _selectedCuisines.remove(cuisine);
      } else {
        _selectedCuisines.add(cuisine);
      }
    });
  }

  void _continue() {
    final currentProfile = ref.read(userProfileProvider);
    if (currentProfile != null) {
      final updated = currentProfile.copyWith(
        cuisines: _selectedCuisines,
        budgetPreference: _budgetPreference,
      );
      ref.read(userProfileProvider.notifier).updateProfile(updated);
    }
    context.go('/onboarding/progress-graph');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/preferences/activities'),
        ),
        title: const Text('Food Preferences'),
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
                  const LinearProgressIndicator(value: 0.9),
                  const SizedBox(height: 24),
                  Text(
                    'What cuisines do you love?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select your favorites',
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
                  ..._cuisineOptions.map((option) {
                    return PreferenceItem(
                      icon: option['icon'],
                      label: option['label'],
                      isSelected: _selectedCuisines.contains(option['value']),
                      onTap: () => _toggleCuisine(option['value']),
                    );
                  }),
                  const SizedBox(height: 24),
                  Text(
                    'Typical date budget',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _BudgetOption(
                        label: '\$',
                        description: 'Budget-friendly',
                        value: 1,
                        selected: _budgetPreference == 1,
                        onTap: () => setState(() => _budgetPreference = 1),
                      ),
                      const SizedBox(width: 12),
                      _BudgetOption(
                        label: '\$\$',
                        description: 'Moderate',
                        value: 2,
                        selected: _budgetPreference == 2,
                        onTap: () => setState(() => _budgetPreference = 2),
                      ),
                      const SizedBox(width: 12),
                      _BudgetOption(
                        label: '\$\$\$',
                        description: 'Splurge',
                        value: 3,
                        selected: _budgetPreference == 3,
                        onTap: () => setState(() => _budgetPreference = 3),
                      ),
                    ],
                  ),
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

class _BudgetOption extends StatelessWidget {
  final String label;
  final String description;
  final int value;
  final bool selected;
  final VoidCallback onTap;

  const _BudgetOption({
    required this.label,
    required this.description,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.primaryDark : AppColors.neutral,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: selected ? Colors.white : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: selected ? Colors.white.withOpacity(0.9) : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
