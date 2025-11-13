import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

/// Design 6: Story Feed - Vertical social feed style
class HomeScreenDesign6 extends StatelessWidget {
  const HomeScreenDesign6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primaryLight,
                    child: const Icon(Icons.favorite, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Together',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Your relationship journey',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            
            // Feed
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _StoryCard(
                    title: 'Your Garden is Growing!',
                    subtitle: 'Level 5 • 240 minutes together',
                    image: Icons.park,
                    color: AppColors.success,
                    actionText: 'Visit Garden',
                    onTap: () => context.push('/garden'),
                  ),
                  _StoryCard(
                    title: 'Private Space',
                    subtitle: 'Express your thoughts freely',
                    image: Icons.create,
                    color: AppColors.primary,
                    actionText: 'Journal Now',
                    onTap: () => context.push('/journal/my-space'),
                  ),
                  _StoryCard(
                    title: 'About Your Partner',
                    subtitle: 'Reflect on what you appreciate',
                    image: Icons.favorite_border,
                    color: AppColors.secondary,
                    actionText: 'Write Entry',
                    onTap: () => context.push('/journal/about-partner'),
                  ),
                  _StoryCard(
                    title: 'Date Night Ideas',
                    subtitle: 'Personalized recommendations',
                    image: Icons.lightbulb_outline,
                    color: AppColors.accent,
                    actionText: 'Explore Ideas',
                    onTap: () => context.push('/recommendations'),
                  ),
                  _StoryCard(
                    title: 'Play Together',
                    subtitle: 'Fun games to connect',
                    image: Icons.games,
                    color: const Color(0xFF9C27B0),
                    actionText: 'Play Now',
                    onTap: () => context.push('/games'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData image;
  final Color color;
  final String actionText;
  final VoidCallback onTap;

  const _StoryCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image header
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(image, size: 64, color: color.withOpacity(0.6)),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Action button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: color,
                      side: BorderSide(color: color, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      actionText,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
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
