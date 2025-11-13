import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import 'dart:math' as math;

/// Design 10: Animated Stacked Cards - Tinder-style card stack
class HomeScreenDesign10 extends StatefulWidget {
  const HomeScreenDesign10({super.key});

  @override
  State<HomeScreenDesign10> createState() => _HomeScreenDesign10State();
}

class _HomeScreenDesign10State extends State<HomeScreenDesign10> with TickerProviderStateMixin {
  int _currentIndex = 0;
  
  final List<Map<String, dynamic>> _cards = [
    {
      'title': 'Together Garden',
      'subtitle': 'Level 5 • 240 minutes',
      'icon': Icons.park,
      'gradient': const LinearGradient(colors: [Color(0xFF4CAF50), Color(0xFF388E3C)]),
      'route': '/garden',
    },
    {
      'title': 'My Private Space',
      'subtitle': 'Journal your thoughts',
      'icon': Icons.auto_stories,
      'gradient': const LinearGradient(colors: [Color(0xFFEC6B9E), Color(0xFFD44A7E)]),
      'route': '/journal/my-space',
    },
    {
      'title': 'About My Partner',
      'subtitle': 'Reflect & appreciate',
      'icon': Icons.favorite,
      'gradient': const LinearGradient(colors: [Color(0xFF64C4ED), Color(0xFF3AA0D1)]),
      'route': '/journal/about-partner',
    },
    {
      'title': 'Date Ideas',
      'subtitle': 'Discover new experiences',
      'icon': Icons.lightbulb,
      'gradient': const LinearGradient(colors: [Color(0xFFFFD166), Color(0xFFE6B800)]),
      'route': '/recommendations',
    },
    {
      'title': 'Play Together',
      'subtitle': 'Fun games & activities',
      'icon': Icons.games,
      'gradient': const LinearGradient(colors: [Color(0xFF9C27B0), Color(0xFF7B1FA2)]),
      'route': '/games',
    },
  ];

  void _nextCard() {
    if (_currentIndex < _cards.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Relationship',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Swipe to explore',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${_currentIndex + 1}/${_cards.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            // Stacked Cards
            Expanded(
              child: Stack(
                children: [
                  // Back cards (stacked effect)
                  for (int i = math.min(_currentIndex + 2, _cards.length - 1); i > _currentIndex; i--)
                    _buildStackedCard(i, _currentIndex),
                  
                  // Current card
                  _buildActiveCard(_currentIndex),
                ],
              ),
            ),
            
            // Navigation
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _NavButton(
                    icon: Icons.arrow_back,
                    onPressed: _currentIndex > 0 ? _previousCard : null,
                  ),
                  const SizedBox(width: 24),
                  _NavButton(
                    icon: Icons.check,
                    isPrimary: true,
                    onPressed: () => context.push(_cards[_currentIndex]['route']),
                  ),
                  const SizedBox(width: 24),
                  _NavButton(
                    icon: Icons.arrow_forward,
                    onPressed: _currentIndex < _cards.length - 1 ? _nextCard : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStackedCard(int index, int currentIndex) {
    final offset = (index - currentIndex) * 8.0;
    final scale = 1 - ((index - currentIndex) * 0.05);
    
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.only(
          left: offset,
          right: offset,
          top: offset,
          bottom: 100,
        ),
        child: Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: 0.5,
            child: Container(
              decoration: BoxDecoration(
                gradient: _cards[index]['gradient'],
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveCard(int index) {
    final card = _cards[index];
    
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Container(
          margin: const EdgeInsets.only(bottom: 100),
          decoration: BoxDecoration(
            gradient: card['gradient'],
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Pattern
              Positioned.fill(
                child: CustomPaint(
                  painter: _CardPatternPainter(),
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        card['icon'],
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      card['title'],
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      card['subtitle'],
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      textAlign: TextAlign.center,
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

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const _NavButton({
    required this.icon,
    this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isPrimary ? 72 : 56,
      height: isPrimary ? 72 : 56,
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: isPrimary ? Colors.white : (onPressed != null ? Colors.black87 : Colors.grey),
          size: isPrimary ? 32 : 24,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class _CardPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    for (var i = 0; i < 8; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.9, size.height * (0.1 + i * 0.12)),
        50,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
