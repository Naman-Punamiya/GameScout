import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../common/glass_container.dart';

class GameScoutBottomNavigationItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const GameScoutBottomNavigationItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

class GameScoutBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<GameScoutBottomNavigationItem> items;

  const GameScoutBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items = const [
      GameScoutBottomNavigationItem(
        icon: Icons.explore_outlined,
        activeIcon: Icons.explore_rounded,
        label: 'Discover',
      ),
      GameScoutBottomNavigationItem(
        icon: Icons.sports_esports_outlined,
        activeIcon: Icons.sports_esports_rounded,
        label: 'Matches',
      ),
      GameScoutBottomNavigationItem(
        icon: Icons.people_alt_outlined,
        activeIcon: Icons.people_alt_rounded,
        label: 'Friends',
      ),
      GameScoutBottomNavigationItem(
        icon: Icons.bookmark_border_rounded,
        activeIcon: Icons.bookmark_rounded,
        label: 'Wishlist',
      ),
      GameScoutBottomNavigationItem(
        icon: Icons.person_outline_rounded,
        activeIcon: Icons.person_rounded,
        label: 'Profile',
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return GlassContainer(
      borderRadius: AppRadius.pill,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md - 2,
        vertical: AppSpacing.sm,
      ),
      backgroundColor: palette.navBg,
      borderColor: palette.borderStroke,
      blurSigma: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md - 2,
                vertical: AppSpacing.sm - 2,
              ),
              decoration: BoxDecoration(
                color: isSelected ? palette.primaryFixed : Colors.transparent,
                borderRadius: AppRadius.roundedCard,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? (item.activeIcon ?? item.icon) : item.icon,
                    color: isSelected ? palette.primary : palette.secondary,
                    size: 22,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? palette.primary : palette.secondary,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
