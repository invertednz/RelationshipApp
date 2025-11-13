import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'home_screen_design1_garden_hero.dart';
import 'home_screen_design2_card_carousel.dart';
import 'home_screen_design3_magazine.dart';
import 'home_screen_design4_neumorphic.dart';
import 'home_screen_design5_grid_dashboard.dart';
import 'home_screen_design6_story_feed.dart';
import 'home_screen_design7_floating_action.dart';
import 'home_screen_design8_timeline.dart';
import 'home_screen_design9_bottom_sheet.dart';
import 'home_screen_design10_animated_cards.dart';

/// Design Showcase - View all 10 home screen design concepts
class HomeDesignShowcase extends StatelessWidget {
  const HomeDesignShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    final designs = [
      _DesignInfo(
        number: 1,
        name: 'Garden Hero',
        description: 'Garden visualization at top with flowing gradient cards',
        style: 'Bold, colorful, modern',
        widget: const HomeScreenDesign1(),
        color: AppColors.primary,
      ),
      _DesignInfo(
        number: 2,
        name: 'Card Carousel',
        description: 'Swipeable horizontal cards with page indicators',
        style: 'Interactive, playful, engaging',
        widget: const HomeScreenDesign2(),
        color: AppColors.secondary,
      ),
      _DesignInfo(
        number: 3,
        name: 'Magazine Layout',
        description: 'Editorial style with bold typography and feature story',
        style: 'Clean, sophisticated, editorial',
        widget: const HomeScreenDesign3(),
        color: AppColors.accent,
      ),
      _DesignInfo(
        number: 4,
        name: 'Neumorphic',
        description: 'Soft shadows and minimalist design with 3D effect',
        style: 'Modern, minimal, elegant',
        widget: const HomeScreenDesign4(),
        color: const Color(0xFF2C3E50),
      ),
      _DesignInfo(
        number: 5,
        name: 'Grid Dashboard',
        description: 'iOS-style tile grid with gradient backgrounds',
        style: 'Simple, organized, familiar',
        widget: const HomeScreenDesign5(),
        color: AppColors.success,
      ),
      _DesignInfo(
        number: 6,
        name: 'Story Feed',
        description: 'Vertical social feed style with action cards',
        style: 'Social, familiar, scrollable',
        widget: const HomeScreenDesign6(),
        color: const Color(0xFF9C27B0),
      ),
      _DesignInfo(
        number: 7,
        name: 'Floating Action',
        description: 'Minimal stats with animated FAB menu',
        style: 'Minimal, focused, clean',
        widget: const HomeScreenDesign7(),
        color: const Color(0xFF00BCD4),
      ),
      _DesignInfo(
        number: 8,
        name: 'Timeline',
        description: 'Vertical journey timeline with garden banner',
        style: 'Progressive, narrative, clear',
        widget: const HomeScreenDesign8(),
        color: const Color(0xFF4CAF50),
      ),
      _DesignInfo(
        number: 9,
        name: 'Bottom Sheet',
        description: 'Full-screen garden with draggable bottom drawer',
        style: 'Immersive, visual, modern',
        widget: const HomeScreenDesign9(),
        color: const Color(0xFF66BB6A),
      ),
      _DesignInfo(
        number: 10,
        name: 'Animated Cards',
        description: 'Tinder-style card stack with swipe navigation',
        style: 'Interactive, fun, engaging',
        widget: const HomeScreenDesign10(),
        color: const Color(0xFFFF6B9D),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Home Screen Designs',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '10 unique concepts to choose from',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Design Grid
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: designs.length,
                itemBuilder: (context, index) {
                  return _DesignCard(
                    info: designs[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => _DesignPreview(info: designs[index]),
                        ),
                      );
                    },
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

class _DesignInfo {
  final int number;
  final String name;
  final String description;
  final String style;
  final Widget widget;
  final Color color;

  _DesignInfo({
    required this.number,
    required this.name,
    required this.description,
    required this.style,
    required this.widget,
    required this.color,
  });
}

class _DesignCard extends StatelessWidget {
  final _DesignInfo info;
  final VoidCallback onTap;

  const _DesignCard({required this.info, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Number badge
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: info.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '#${info.number}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: info.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: info.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          info.style,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: info.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DesignPreview extends StatelessWidget {
  final _DesignInfo info;

  const _DesignPreview({required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Preview
          info.widget,
          
          // Overlay info bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
              ),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Design ${info.number}: ${info.name}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            info.style,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
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
