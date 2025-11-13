import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

/// Design 2: Card Carousel - Swipeable horizontal cards with garden preview
class HomeScreenDesign2 extends StatefulWidget {
  const HomeScreenDesign2({super.key});

  @override
  State<HomeScreenDesign2> createState() => _HomeScreenDesign2State();
}

class _HomeScreenDesign2State extends State<HomeScreenDesign2> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      _CarouselCardData(
        title: 'My Space',
        subtitle: 'Express yourself freely',
        icon: Icons.auto_stories,
        gradient: const LinearGradient(
          colors: [Color(0xFFEC6B9E), Color(0xFFD44A7E)],
        ),
        route: '/journal/my-space',
      ),
      _CarouselCardData(
        title: 'About Partner',
        subtitle: 'Appreciate & understand',
        icon: Icons.favorite_border,
        gradient: const LinearGradient(
          colors: [Color(0xFF64C4ED), Color(0xFF3AA0D1)],
        ),
        route: '/journal/about-partner',
      ),
      _CarouselCardData(
        title: 'Date Ideas',
        subtitle: 'Perfect moments together',
        icon: Icons.emoji_objects,
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD166), Color(0xFFE6B800)],
        ),
        route: '/recommendations',
      ),
      _CarouselCardData(
        title: 'Play Together',
        subtitle: 'Fun games & activities',
        icon: Icons.sports_esports,
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
        ),
        route: '/games',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with garden
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const Text(
                            'Relationship App',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.spa, color: AppColors.success, size: 20),
                            const SizedBox(width: 6),
                            Text(
                              'Lvl 5',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.success,
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
            
            // Carousel
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: cards.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return _CarouselCard(
                    data: cards[index],
                    isActive: index == _currentPage,
                  );
                },
              ),
            ),
            
            // Page Indicator
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  cards.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? AppColors.primary : AppColors.neutral,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarouselCardData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Gradient gradient;
  final String route;

  _CarouselCardData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.route,
  });
}

class _CarouselCard extends StatelessWidget {
  final _CarouselCardData data;
  final bool isActive;

  const _CarouselCard({required this.data, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: isActive ? 0 : 8,
        vertical: isActive ? 0 : 24,
      ),
      child: GestureDetector(
        onTap: () => context.push(data.route),
        child: Container(
          decoration: BoxDecoration(
            gradient: data.gradient,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background pattern
              Positioned.fill(
                child: CustomPaint(
                  painter: _PatternPainter(),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(data.icon, color: Colors.white, size: 50),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data.subtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Open',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_forward, color: Colors.white.withOpacity(0.9), size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    for (var i = 0; i < 6; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.8, size.height * (0.2 * i)),
        40,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
