import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';

class MainShellScreen extends StatelessWidget {
  final Widget child;

  const MainShellScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int index) => _onItemTapped(index, context),
        backgroundColor: AppColors.deepForest,
        indicatorColor: AppColors.emeraldPrimary.withValues(alpha: 0.2),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppColors.emeraldPrimary),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded, color: AppColors.emeraldPrimary),
            label: 'Read',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            selectedIcon: Icon(Icons.chat_bubble_rounded, color: AppColors.emeraldPrimary),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline_rounded),
            selectedIcon: Icon(Icons.people_rounded, color: AppColors.emeraldPrimary),
            label: 'Community',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz_outlined),
            selectedIcon: Icon(Icons.more_horiz_rounded, color: AppColors.emeraldPrimary),
            label: 'More',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(RouteConstants.home)) return 0;
    if (location.startsWith(RouteConstants.surahs)) return 1;
    if (location.startsWith(RouteConstants.reading)) return 1;
    if (location.startsWith(RouteConstants.chat)) return 2;
    if (location.startsWith(RouteConstants.social)) return 3;
    if (location.startsWith(RouteConstants.settings)) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RouteConstants.home);
        break;
      case 1:
        context.go(RouteConstants.surahs); 
        break;
      case 2:
        context.go(RouteConstants.chat);
        break;
      case 3:
        context.go(RouteConstants.social);
        break;
      case 4:
        context.go(RouteConstants.settings);
        break;
    }
  }
}
