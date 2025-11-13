import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

/// Design 8: Timeline - Vertical timeline with garden at top
class HomeScreenDesign8 extends StatelessWidget {
  const HomeScreenDesign8({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Garden Banner
            Container(
              margin: const EdgeInsets.all(20),
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF4CAF50),
                    const Color(0xFF81C784),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4CAF50).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Decorative elements
                  Positioned(
                    right: -20,
                    top: -20,
                    child: Icon(
                      Icons.eco,
                      size: 120,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Together Garden',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _Stat(label: 'Level 5', icon: Icons.trending_up),
                            const SizedBox(width: 24),
                            _Stat(label: '240 min', icon: Icons.access_time),
                            const SizedBox(width: 24),
                            _Stat(label: '7 days', icon: Icons.local_fire_department),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Timeline
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Your Journey',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  _TimelineItem(
                    title: 'My Private Space',
                    subtitle: 'Reflect and express yourself',
                    icon: Icons.edit_note,
                    color: AppColors.primary,
                    isFirst: true,
                    onTap: () => context.push('/journal/my-space'),
                  ),
                  
                  _TimelineItem(
                    title: 'About My Partner',
                    subtitle: 'Appreciate what makes them special',
                    icon: Icons.favorite,
                    color: AppColors.secondary,
                    onTap: () => context.push('/journal/about-partner'),
                  ),
                  
                  _TimelineItem(
                    title: 'Date Ideas',
                    subtitle: 'Discover new experiences together',
                    icon: Icons.lightbulb,
                    color: AppColors.accent,
                    onTap: () => context.push('/recommendations'),
                  ),
                  
                  _TimelineItem(
                    title: 'Play Games',
                    subtitle: 'Connect through fun activities',
                    icon: Icons.games,
                    color: const Color(0xFF9C27B0),
                    isLast: true,
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

class _Stat extends StatelessWidget {
  final String label;
  final IconData icon;

  const _Stat({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.isFirst = false,
    this.isLast = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line
          SizedBox(
            width: 40,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: color.withOpacity(0.3),
                    ),
                  ),
                
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: color.withOpacity(0.3),
                    ),
                  ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
