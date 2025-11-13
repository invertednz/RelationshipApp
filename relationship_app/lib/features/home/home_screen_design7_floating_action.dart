import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import 'dart:math' as math;

/// Design 7: Floating Action - Minimal design with FAB menu
class HomeScreenDesign7 extends StatefulWidget {
  const HomeScreenDesign7({super.key});

  @override
  State<HomeScreenDesign7> createState() => _HomeScreenDesign7State();
}

class _HomeScreenDesign7State extends State<HomeScreenDesign7>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_isOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _isOpen = !_isOpen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Minimal header
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppColors.success, AppColors.success.withOpacity(0.6)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.success.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.spa, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Together Garden',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.successLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Level 5 • Growing Strong',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Minimalist stats
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _MinimalStat(title: '240', subtitle: 'Minutes Together'),
                    const SizedBox(height: 32),
                    _MinimalStat(title: '7', subtitle: 'Day Streak'),
                    const SizedBox(height: 32),
                    _MinimalStat(title: '12', subtitle: 'Journal Entries'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Floating Action Menu
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          // Backdrop
          if (_isOpen)
            GestureDetector(
              onTap: _toggle,
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          
          // Menu items
          ..._buildMenuItems(),
          
          // Main FAB
          FloatingActionButton(
            onPressed: _toggle,
            backgroundColor: AppColors.primary,
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _controller,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    final items = [
      {'icon': Icons.create, 'label': 'My Space', 'route': '/journal/my-space', 'color': AppColors.primary},
      {'icon': Icons.favorite, 'label': 'Partner', 'route': '/journal/about-partner', 'color': AppColors.secondary},
      {'icon': Icons.lightbulb, 'label': 'Ideas', 'route': '/recommendations', 'color': AppColors.accent},
      {'icon': Icons.games, 'label': 'Games', 'route': '/games', 'color': AppColors.success},
    ];

    return List.generate(items.length, (index) {
      final item = items[index];
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final offset = (index + 1) * 70.0 * _controller.value;
          return Positioned(
            right: 0,
            bottom: offset + 56,
            child: Opacity(
              opacity: _controller.value,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      item['label'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FloatingActionButton(
                    heroTag: 'fab_$index',
                    mini: true,
                    backgroundColor: item['color'] as Color,
                    onPressed: () {
                      _toggle();
                      context.push(item['route'] as String);
                    },
                    child: Icon(item['icon'] as IconData, color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class _MinimalStat extends StatelessWidget {
  final String title;
  final String subtitle;

  const _MinimalStat({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w200,
            color: AppColors.primary,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
