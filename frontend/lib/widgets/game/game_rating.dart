import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

enum GameRatingVariant { pill, standard, compact }

class GameRating extends StatelessWidget {
  final double rating;
  final int? ratingCount;
  final String? ratingCountText;
  final GameRatingVariant variant;
  final Color? backgroundColor;

  const GameRating({
    super.key,
    required this.rating,
    this.ratingCount,
    this.ratingCountText,
    this.variant = GameRatingVariant.pill,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);
    final formattedRating = rating > 0 ? rating.toStringAsFixed(1) : '4.6';
    final formattedCount =
        ratingCountText ??
        (ratingCount != null && ratingCount! > 0
            ? '${(ratingCount! / 1000).toStringAsFixed(1)}k'
            : null);

    if (variant == GameRatingVariant.pill) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm + 2,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? palette.cardBg.withValues(alpha: 0.92),
          borderRadius: AppRadius.roundedLargeCard,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star_rounded, color: palette.primary, size: 14),
            const SizedBox(width: 3),
            Text(
              formattedRating,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: palette.onSurface,
              ),
            ),
            if (formattedCount != null) ...[
              const SizedBox(width: 3),
              Text(
                '($formattedCount)',
                style: TextStyle(fontSize: 10, color: palette.secondary),
              ),
            ],
          ],
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: palette.primary, size: 14),
        const SizedBox(width: 3),
        Text(
          formattedRating,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: palette.onSurface,
          ),
        ),
        if (formattedCount != null && variant != GameRatingVariant.compact) ...[
          const SizedBox(width: 3),
          Text(
            '($formattedCount)',
            style: TextStyle(fontSize: 10, color: palette.secondary),
          ),
        ],
      ],
    );
  }
}
