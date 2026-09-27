import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class ActionButtonBar extends StatelessWidget {
  final VoidCallback onPass;
  final VoidCallback onBookmark;
  final VoidCallback onLike;
  final VoidCallback? onUndo;

  const ActionButtonBar({
    super.key,
    required this.onPass,
    required this.onBookmark,
    required this.onLike,
    this.onUndo,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: const Color(0xCC101321),
      borderColor: AppColors.borderStroke,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Rewind / Undo (Optional)
          if (onUndo != null) ...[
            _buildCircularButton(
              size: 40,
              icon: Icons.replay_rounded,
              iconColor: AppColors.textMuted,
              bgColor: AppColors.surface2,
              onTap: onUndo!,
            ),
            const SizedBox(width: 14),
          ],

          // Pass / Dislike (Red)
          _buildCircularButton(
            size: 50,
            icon: Icons.close_rounded,
            iconColor: AppColors.actionPass,
            bgColor: AppColors.surface2,
            borderColor: AppColors.actionPass.withValues(alpha: 0.3),
            glowColor: AppColors.actionPassGlow,
            onTap: onPass,
          ),
          const SizedBox(width: 14),

          // Bookmark / Not Sure (Amber)
          _buildCircularButton(
            size: 44,
            icon: Icons.bookmark_border_rounded,
            iconColor: AppColors.actionBookmark,
            bgColor: AppColors.surface2,
            borderColor: AppColors.actionBookmark.withValues(alpha: 0.3),
            glowColor: AppColors.actionBookmarkGlow,
            onTap: onBookmark,
          ),
          const SizedBox(width: 14),

          // Like / Match (Violet / Emerald Gradient Glow)
          _buildCircularButton(
            size: 60,
            icon: Icons.favorite_rounded,
            iconColor: Colors.white,
            gradient: AppColors.primaryButtonGradient,
            glowColor: AppColors.primaryGlow,
            onTap: onLike,
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required double size,
    required IconData icon,
    required Color iconColor,
    Color? bgColor,
    Color? borderColor,
    Color? glowColor,
    Gradient? gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          gradient: gradient,
          shape: BoxShape.circle,
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1.5)
              : null,
          boxShadow: glowColor != null
              ? [
                  BoxShadow(
                    color: glowColor,
                    blurRadius: 18,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Icon(icon, color: iconColor, size: size * 0.48),
        ),
      ),
    );
  }
}
