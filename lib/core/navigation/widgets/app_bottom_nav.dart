import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intiva_mobile_application/core/navigation/router/router_names.dart';
import 'package:intiva_mobile_application/core/theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final Widget child;

  const AppBottomNav({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(RouteNames.catalog)) return 1;
    if (location.startsWith(RouteNames.settings)) return 2;
    if (location.startsWith(RouteNames.profile)) return 3;
    return 0; // home
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.catalog);
        break;
      case 2:
        context.go(RouteNames.settings);
        break;
      case 3:
        context.go(RouteNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _currentIndex(context);
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Expanded(child: child),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: 10,
            bottom: bottomPadding > 0 ? bottomPadding + 6 : 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                index: 0,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_rounded,
                label: 'Inicio',
                isSelected: selectedIndex == 0,
              ),
              _buildNavItem(
                context: context,
                index: 1,
                icon: Icons.directions_car_outlined,
                selectedIcon: Icons.directions_car_rounded,
                label: 'Catálogo',
                isSelected: selectedIndex == 1,
              ),
              _buildNavItem(
                context: context,
                index: 2,
                icon: Icons.settings_outlined,
                selectedIcon: Icons.settings_rounded,
                label: 'Configuración',
                isSelected: selectedIndex == 2,
              ),
              _buildNavItem(
                context: context,
                index: 3,
                icon: Icons.person_outline_rounded,
                selectedIcon: Icons.person_rounded,
                label: 'Perfil',
                isSelected: selectedIndex == 3,
              ),
            ],
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData selectedIcon,
    required String label,
    required bool isSelected,
  }) {
    final Color selectedColor = AppColors.primary;
    final Color unselectedColor = const Color(0xFF64748B);
    final Color pillColor = const Color(0xFFE5ECFF);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(context, index),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: isSelected ? pillColor : Colors.transparent,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected ? selectedIcon : icon,
                  color: isSelected ? selectedColor : unselectedColor,
                  size: 24,
                ),
                const SizedBox(height: 5),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? selectedColor : unselectedColor,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
