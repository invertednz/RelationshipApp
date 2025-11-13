import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../core/models/journal_entry.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';
import '../../data/repositories/recommendation_service.dart';

class JournalEntryScreen extends ConsumerStatefulWidget {
  final JournalSpace space;
  final String? entryId;

  const JournalEntryScreen({
    super.key,
    required this.space,
    this.entryId,
  });

  @override
  ConsumerState<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends ConsumerState<JournalEntryScreen> {
  Mood _selectedMood = Mood.good;
  final _textController = TextEditingController();
  bool _shareWithPartner = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _saveEntry() async {
    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something')),
      );
      return;
    }

    var entry = JournalEntry(
      id: const Uuid().v4(),
      space: widget.space,
      createdAt: DateTime.now(),
      mood: _selectedMood,
      text: _textController.text,
      shareWithPartner: _shareWithPartner,
    );

    // Process with recommendation service
    final recService = ref.read(recommendationServiceProvider);
    entry = recService.processEntry(entry);

    await ref.read(journalEntriesProvider.notifier).addEntry(entry);

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.space == JournalSpace.me ? 'My Space' : 'About Partner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'How are you feeling?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: Mood.values.map((mood) {
                return _MoodButton(
                  mood: mood,
                  isSelected: _selectedMood == mood,
                  onTap: () => setState(() => _selectedMood = mood),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'What\'s on your mind?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: 'Write your thoughts...',
                  border: OutlineInputBorder(),
                ),
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Share with partner'),
              value: _shareWithPartner,
              onChanged: (value) => setState(() => _shareWithPartner = value),
              activeColor: AppColors.primary,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  final Mood mood;
  final bool isSelected;
  final VoidCallback onTap;

  const _MoodButton({
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryLight : AppColors.neutralLight,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.neutral,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(mood.emoji, style: const TextStyle(fontSize: 28)),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            mood.label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
