import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

class PlatformBadge extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  const PlatformBadge({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? palette.cardBg.withValues(alpha: 0.92),
        borderRadius: AppRadius.roundedLargeCard,
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 4),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor ?? palette.onSurface,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class PlatformBadgeRow extends StatelessWidget {
  final List<String> platforms;
  final double iconSize;
  final Color? iconColor;

  const PlatformBadgeRow({
    super.key,
    required this.platforms,
    this.iconSize = 16,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);
    final effectiveColor = iconColor ?? palette.secondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: platforms.map((p) {
        IconData platformIcon = Icons.computer_rounded;
        if (p.toLowerCase().contains('ps') ||
            p.toLowerCase().contains('playstation')) {
          platformIcon = Icons.gamepad_rounded;
        } else if (p.toLowerCase().contains('xbox')) {
          platformIcon = Icons.sports_esports_rounded;
        } else if (p.toLowerCase().contains('deck') ||
            p.toLowerCase().contains('switch')) {
          platformIcon = Icons.tablet_mac_rounded;
        }

        return Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Icon(platformIcon, size: iconSize, color: effectiveColor),
        );
      }).toList(),
    );
  }
}
