import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';

class BossShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BossShell({
    super.key,
    required this.navigationShell,
  });

  void _onItemTapped(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onItemTapped,
        backgroundColor: AppTheme.surface,
        indicatorColor: AppTheme.primary.withOpacity(0.1),
        destinations: [
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.house),
            selectedIcon: Icon(PhosphorIconsFill.house, color: AppTheme.primary),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.shoppingCart),
            selectedIcon: Icon(PhosphorIconsFill.shoppingCart, color: AppTheme.primary),
            label: 'Order',
          ),
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.kanban),
            selectedIcon: Icon(PhosphorIconsFill.kanban, color: AppTheme.primary),
            label: 'Produksi',
          ),
          NavigationDestination(
            icon: Icon(PhosphorIconsRegular.user),
            selectedIcon: Icon(PhosphorIconsFill.user, color: AppTheme.primary),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
