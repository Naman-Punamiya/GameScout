import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

enum GameAction { pass, notSure, like }

enum GameActionBarVariant {
  standard, // Discover screen rectangular cards
  console, // Game Details record evaluation console
}

class GameActionBar extends StatelessWidget {
  final VoidCallback onPass;
  final VoidCallback onNotSure;
  final VoidCallback onLike;
  final int? selectedAction; // 0: Pass, 1: Not Sure, 2: Like
  final GameActionBarVariant variant;

  const GameActionBar({
    super.key,
    required this.onPass,
    required this.onNotSure,
    required this.onLike,
    this.selectedAction,
    this.variant = GameActionBarVariant.standard,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return Row(
      children: [
        // Pass Button
        Expanded(child: _buildPassButton(palette)),
        const SizedBox(width: AppSpacing.sm),

        // Not Sure Button
        Expanded(child: _buildNotSureButton(palette)),
        const SizedBox(width: AppSpacing.sm),

        // Like Button
        Expanded(child: _buildLikeButton(palette)),
      ],
    );
  }

  Widget _buildPassButton(AppPalette palette) {
    final isSelected = selectedAction == 0;

    return GestureDetector(
      onTap: onPass,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFDAD6) : palette.surfaceLow,
          borderRadius: AppRadius.roundedLg,
          border: isSelected
              ? Border.all(color: const Color(0xFFBA1A1A))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.close_rounded, size: 20, color: Color(0xFFBA1A1A)),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Pass',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: isSelected ? const Color(0xFFBA1A1A) : palette.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotSureButton(AppPalette palette) {
    final isSelected = selectedAction == 1;

    return GestureDetector(
      onTap: onNotSure,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFEF3C7) : palette.surfaceLow,
          borderRadius: AppRadius.roundedLg,
          border: isSelected
              ? Border.all(color: const Color(0xFFD97706))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.schedule_rounded,
              size: 19,
              color: Color(0xFFD97706),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Not Sure',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: isSelected ? const Color(0xFFD97706) : palette.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLikeButton(AppPalette palette) {
    return GestureDetector(
      onTap: onLike,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: palette.primary,
          borderRadius: AppRadius.roundedLg,
          boxShadow: [
            BoxShadow(
              color: palette.primary.withValues(alpha: 0.35),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_rounded, size: 20, color: Colors.white),
            SizedBox(width: AppSpacing.xs),
            Text(
              'Like',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
