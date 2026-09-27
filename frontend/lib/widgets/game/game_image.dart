import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';

class GameImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? overlay;

  const GameImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.overlay,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);
    final effectiveRadius = borderRadius ?? AppRadius.roundedCard;

    Widget imageWidget = Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: palette.surfaceLow,
        child: Center(
          child: Icon(
            Icons.videogame_asset_rounded,
            size: 44,
            color: palette.secondary,
          ),
        ),
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          width: width,
          height: height,
          color: palette.surfaceLow,
          child: Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: palette.primary,
              ),
            ),
          ),
        );
      },
    );

    if (aspectRatio != null) {
      imageWidget = AspectRatio(aspectRatio: aspectRatio!, child: imageWidget);
    }

    if (overlay != null) {
      imageWidget = Stack(
        fit: StackFit.passthrough,
        children: [imageWidget, overlay!],
      );
    }

    return ClipRRect(borderRadius: effectiveRadius, child: imageWidget);
  }
}
