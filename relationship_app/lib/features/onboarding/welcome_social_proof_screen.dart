import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class WelcomeSocialProofScreen extends StatelessWidget {
  const WelcomeSocialProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // Congrats badge
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Text(
                    '🎉 Congratulations!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Main heading
              Text(
                'You\'re About to Transform Your Relationship',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              Text(
                'Join thousands of couples strengthening their bond through science-backed tools',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Stats cards
              Expanded(
                child: ListView(
                  children: [
                    _StatCard(
                      icon: Icons.psychology,
                      title: 'Research-Backed',
                      description: 'Built on 30+ years of relationship psychology research from the Gottman Institute',
                      accentColor: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    
                    _StatCard(
                      icon: Icons.trending_up,
                      title: '87% See Improvement',
                      description: 'Couples report stronger emotional connection within 3 weeks of daily use',
                      accentColor: AppColors.secondary,
                    ),
                    const SizedBox(height: 16),
                    
                    _StatCard(
                      icon: Icons.favorite,
                      title: '10,000+ Happy Couples',
                      description: 'Trusted by couples worldwide to strengthen their relationship every day',
                      accentColor: AppColors.accent,
                    ),
                    const SizedBox(height: 16),
                    
                    _StatCard(
                      icon: Icons.star,
                      title: '4.9 Star Rating',
                      description: '"This app saved our relationship. We communicate better than ever!" - Sarah & Tom',
                      accentColor: AppColors.success,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // CTA
              ElevatedButton(
                onPressed: () => context.go('/onboarding/goals'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: const Text(
                  'Start Building a Stronger Us',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.4,
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
