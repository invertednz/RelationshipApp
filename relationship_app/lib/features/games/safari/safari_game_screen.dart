import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class SafariGameScreen extends StatefulWidget {
  const SafariGameScreen({super.key});

  @override
  State<SafariGameScreen> createState() => _SafariGameScreenState();
}

class _SafariGameScreenState extends State<SafariGameScreen> {
  final List<String> _challenges = [
    'Partner holding a duck',
    'Something heart-shaped',
    'Both in a reflection',
    'Matching color outfits',
    'Partner smelling something nice',
    'Laughing candid',
    'Favorite café sign',
    'Shadows making a pattern',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Safari'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: AppColors.accentLight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Icon(Icons.camera_alt, size: 48, color: AppColors.accentDark),
                    const SizedBox(height: 12),
                    Text(
                      'Capture these moments!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Complete challenges to earn points'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _challenges.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: Text(_challenges[index]),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Camera integration coming soon!'),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
