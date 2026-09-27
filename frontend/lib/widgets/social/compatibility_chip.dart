import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

enum ChipVariant { primary, secondary, action, neutral }

class CompatibilityChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final ChipVariant variant;

  const CompatibilityChip({
    super.key,
    required this.label,
    this.icon,
    this.variant = ChipVariant.neutral,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color border;
    Color text;

    switch (variant) {
      case ChipVariant.primary:
        bg = const Color(0x267C3AED);
        border = const Color(0x668B5CF6);
        text = const Color(0xFFC4B5FD);
        break;
      case ChipVariant.secondary:
        bg = const Color(0x1F38BDF8);
        border = const Color(0x5938BDF8);
        text = AppColors.secondary;
        break;
      case ChipVariant.action:
        bg = const Color(0x2610B981);
        border = const Color(0x5910B981);
        text = AppColors.actionLike;
        break;
      case ChipVariant.neutral:
        bg = AppColors.surface2;
        border = AppColors.borderStroke;
        text = AppColors.textSecondary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm + 2,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: text),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label.toUpperCase(),
            style: AppTypography.labelSm.copyWith(color: text),
          ),
        ],
      ),
    );
  }
}
