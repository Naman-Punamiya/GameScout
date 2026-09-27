import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

class RecommendationReason extends StatelessWidget {
  final String reason;
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry padding;

  const RecommendationReason({
    super.key,
    required this.reason,
    this.icon = Icons.auto_awesome_rounded,
    this.backgroundColor,
    this.foregroundColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.sm + 2,
      vertical: AppSpacing.xs,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);
    final bg = backgroundColor ?? palette.secondaryContainer;
    final fg = foregroundColor ?? palette.primary;

    return Container(
      padding: padding,
      decoration: BoxDecoration(color: bg, borderRadius: AppRadius.roundedCard),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: fg, size: 14),
          const SizedBox(width: AppSpacing.xs + 1),
          Flexible(
            child: Text(
              reason,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
