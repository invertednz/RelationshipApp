import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

/// Design 5: Grid Dashboard - iOS-style tile grid
class HomeScreenDesign5 extends StatelessWidget {
  const HomeScreenDesign5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Relationship',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.eco, color: AppColors.success, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '5',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(20),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _GridTile(
                    title: 'My Space',
                    icon: Icons.auto_stories,
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    onTap: () => context.push('/journal/my-space'),
                  ),
                  _GridTile(
                    title: 'About Partner',
                    icon: Icons.favorite,
                    gradient: LinearGradient(
                      colors: [AppColors.secondary, AppColors.secondaryDark],
                    ),
                    onTap: () => context.push('/journal/about-partner'),
                  ),
                  _GridTile(
                    title: 'Together Garden',
                    icon: Icons.park,
                    gradient: LinearGradient(
                      colors: [AppColors.success, const Color(0xFF388E3C)],
                    ),
                    onTap: () => context.push('/garden'),
                    large: true,
                  ),
                  _GridTile(
                    title: 'Date Ideas',
                    icon: Icons.emoji_objects,
                    gradient: LinearGradient(
                      colors: [AppColors.accent, AppColors.accentDark],
                    ),
                    onTap: () => context.push('/recommendations'),
                  ),
                  _GridTile(
                    title: 'Games',
                    icon: Icons.sports_esports,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
                    ),
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

class _GridTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;
  final bool large;

  const _GridTile({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.onTap,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: large ? 56 : 48,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
