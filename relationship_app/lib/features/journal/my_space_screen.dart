import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/journal_entry.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';

class MySpaceScreen extends ConsumerWidget {
  const MySpaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(journalEntriesProvider)
        .where((e) => e.space == JournalSpace.me)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Space'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: entries.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_note, size: 80, color: AppColors.neutral),
                  const SizedBox(height: 16),
                  const Text('No entries yet'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.push('/journal/entry?space=me'),
                    child: const Text('Create First Entry'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Text(entry.mood.emoji, style: const TextStyle(fontSize: 28)),
                    title: Text(entry.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text('${entry.createdAt.day}/${entry.createdAt.month}/${entry.createdAt.year}'),
                    trailing: entry.shareWithPartner
                        ? const Icon(Icons.share, color: AppColors.primary)
                        : const Icon(Icons.lock, color: AppColors.neutralDark),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/journal/entry?space=me'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
