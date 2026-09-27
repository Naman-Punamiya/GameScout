import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

enum GameTagVariant { neutral, accent, status }

class GameTagChip extends StatelessWidget {
  final String label;
  final GameTagVariant variant;
  final IconData? icon;
  final bool hasDot;
  final Color? dotColor;
  final Color? backgroundColor;
  final Color? textColor;

  const GameTagChip({
    super.key,
    required this.label,
    this.variant = GameTagVariant.neutral,
    this.icon,
    this.hasDot = false,
    this.dotColor,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    Color bg;
    Color fg;

    switch (variant) {
      case GameTagVariant.accent:
        bg = backgroundColor ?? palette.secondaryContainer;
        fg = textColor ?? palette.primary;
        break;
      case GameTagVariant.status:
        bg = backgroundColor ?? palette.primaryFixed;
        fg = textColor ?? palette.primary;
        break;
      case GameTagVariant.neutral:
        bg = backgroundColor ?? palette.surfaceLow;
        fg = textColor ?? palette.secondary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(color: bg, borderRadius: AppRadius.roundedSm),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: dotColor ?? palette.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
