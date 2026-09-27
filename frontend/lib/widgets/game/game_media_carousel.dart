import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

class GameMediaItem {
  final String imageUrl;
  final bool isVideo;
  final String? label;

  const GameMediaItem({
    required this.imageUrl,
    this.isVideo = false,
    this.label,
  });
}

class GameMediaCarousel extends StatelessWidget {
  final List<GameMediaItem> items;
  final double height;
  final ValueChanged<int>? onItemTap;

  const GameMediaCarousel({
    super.key,
    required this.items,
    this.height = 120,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: items.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => onItemTap?.call(index),
            child: Container(
              width: 190,
              decoration: BoxDecoration(
                borderRadius: AppRadius.roundedLg,
                color: palette.surfaceContainer,
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: palette.surfaceLow,
                      child: Icon(
                        Icons.broken_image_rounded,
                        color: palette.secondary,
                      ),
                    ),
                  ),
                  if (item.isVideo) ...[
                    Container(color: Colors.black.withValues(alpha: 0.25)),
                    Center(
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: palette.primary,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                  if (item.label != null && item.label!.isNotEmpty)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xCC000000),
                          borderRadius: AppRadius.roundedXs,
                        ),
                        child: Text(
                          item.label!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
