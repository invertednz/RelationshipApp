import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';

class GardenScreen extends ConsumerWidget {
  const GardenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(gardenProgressProvider);
    final activeSession = ref.watch(activeGardenSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Together Garden'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => context.push('/garden/history'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: AppColors.secondaryLight,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.spa,
                      size: 80,
                      color: _getGardenColor(progress.level),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Level ${progress.level}',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text('${progress.totalMinutes} minutes together'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stats',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    _StatRow(
                      icon: Icons.local_fire_department,
                      label: 'Current Streak',
                      value: '${progress.currentStreak} days',
                    ),
                    const SizedBox(height: 12),
                    _StatRow(
                      icon: Icons.emoji_events,
                      label: 'Longest Streak',
                      value: '${progress.longestStreak} days',
                    ),
                    const SizedBox(height: 12),
                    _StatRow(
                      icon: Icons.star,
                      label: 'Achievements',
                      value: '${progress.achievements.length}',
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            if (activeSession == null)
              ElevatedButton(
                onPressed: () {
                  // Start new session
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Session tracking coming soon! Both partners need to be present.'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Start Focus Session'),
              )
            else
              ElevatedButton(
                onPressed: () {
                  // End session
                  ref.read(activeGardenSessionProvider.notifier).clearSession();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('End Session'),
              ),
          ],
        ),
      ),
    );
  }

  Color _getGardenColor(int level) {
    if (level < 3) return Colors.brown;
    if (level < 6) return Colors.green.shade300;
    if (level < 10) return Colors.green;
    return Colors.green.shade900;
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary),
        const SizedBox(width: 12),
        Expanded(child: Text(label)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
