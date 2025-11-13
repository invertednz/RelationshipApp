import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class DoodleGameScreen extends StatefulWidget {
  const DoodleGameScreen({super.key});

  @override
  State<DoodleGameScreen> createState() => _DoodleGameScreenState();
}

class _DoodleGameScreenState extends State<DoodleGameScreen> {
  final List<String> _prompts = [
    'Favorite holiday destination',
    'First date location',
    'Dream home',
    'Perfect Sunday morning',
    'Favorite meal together',
  ];
  
  String? _currentPrompt;
  
  @override
  void initState() {
    super.initState();
    _prompts.shuffle();
    _currentPrompt = _prompts.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Couples Doodle'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: AppColors.primaryLight,
            child: Column(
              children: [
                Text(
                  'Draw this:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  _currentPrompt ?? '',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.draw, size: 80, color: AppColors.neutral),
                    const SizedBox(height: 16),
                    const Text('Canvas coming soon!'),
                    const SizedBox(height: 8),
                    const Text('This will include drawing tools,'),
                    const Text('timer, and turn-based gameplay'),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _prompts.shuffle();
                        _currentPrompt = _prompts.first;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('New Prompt'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
