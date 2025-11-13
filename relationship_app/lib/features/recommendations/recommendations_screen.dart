import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/date_idea.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';

class RecommendationsScreen extends ConsumerWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(journalEntriesProvider);
    final recService = ref.read(recommendationServiceProvider);
    final profile = ref.watch(userProfileProvider);

    final recommendations = recService.getRecommendations(
      entries: entries,
      budgetPreference: profile?.budgetPreference,
      count: 5,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: recommendations.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_outline, size: 80, color: AppColors.neutral),
                  const SizedBox(height: 16),
                  const Text('Start journaling to get recommendations!'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final idea = recommendations[index];
                return _DateIdeaCard(idea: idea);
              },
            ),
    );
  }
}

class _DateIdeaCard extends StatelessWidget {
  final DateIdea idea;

  const _DateIdeaCard({required this.idea});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    idea.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('\$' * idea.budget),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(idea.description),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text('${idea.durationHrs} hours'),
                const SizedBox(width: 16),
                Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(idea.location.label),
              ],
            ),
            if (idea.whyReasons.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: idea.whyReasons.map((reason) {
                  return Chip(
                    label: Text(reason, style: const TextStyle(fontSize: 12)),
                    backgroundColor: AppColors.secondaryLight,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
