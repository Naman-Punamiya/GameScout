import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final bool isOnline;
  final bool showOnlineIndicator;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final IconData fallbackIcon;

  const UserAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.isOnline = false,
    this.showOnlineIndicator = false,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.fallbackIcon = Icons.person_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);
    final effectiveBgColor = backgroundColor ?? palette.surfaceContainer;

    Widget avatarContent;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = Image.network(
        imageUrl!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _buildFallback(effectiveBgColor, palette),
      );
    } else if (initials != null && initials!.isNotEmpty) {
      avatarContent = Container(
        width: size,
        height: size,
        color: effectiveBgColor,
        alignment: Alignment.center,
        child: Text(
          initials!,
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      );
    } else {
      avatarContent = _buildFallback(effectiveBgColor, palette);
    }

    Widget avatarWidget = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderColor != null && borderWidth > 0
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
      ),
      child: ClipOval(child: avatarContent),
    );

    if (!showOnlineIndicator) {
      return avatarWidget;
    }

    final indicatorSize = (size * 0.28).clamp(8.0, 14.0);

    return Stack(
      children: [
        avatarWidget,
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: indicatorSize,
            height: indicatorSize,
            decoration: BoxDecoration(
              color: isOnline
                  ? const Color(0xFF10B981)
                  : const Color(0xFF64748B),
              shape: BoxShape.circle,
              border: Border.all(color: palette.cardBg, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFallback(Color bgColor, AppPalette palette) {
    return Container(
      width: size,
      height: size,
      color: bgColor,
      child: Center(
        child: Icon(fallbackIcon, size: size * 0.5, color: palette.secondary),
      ),
    );
  }
}
