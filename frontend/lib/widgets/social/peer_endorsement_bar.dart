import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../common/avatar_stack.dart';
import '../common/user_avatar.dart';

class PeerEndorsementBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<String>? avatarUrls;
  final List<String>? avatarInitials;
  final VoidCallback? onTap;

  const PeerEndorsementBar({
    super.key,
    this.title = 'Sarah & Alex liked this',
    this.subtitle = "Added to 2 friends' collections",
    this.avatarUrls,
    this.avatarInitials,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    List<Widget> avatarWidgets = [];
    if (avatarUrls != null && avatarUrls!.isNotEmpty) {
      avatarWidgets = avatarUrls!
          .map(
            (url) => UserAvatar(
              imageUrl: url,
              size: 26,
              borderColor: Colors.white,
              borderWidth: 1.5,
            ),
          )
          .toList();
    } else if (avatarInitials != null && avatarInitials!.isNotEmpty) {
      final colors = [palette.secondary, palette.primary];
      for (int i = 0; i < avatarInitials!.length; i++) {
        avatarWidgets.add(
          UserAvatar(
            initials: avatarInitials![i],
            size: 26,
            backgroundColor: colors[i % colors.length],
            borderColor: Colors.white,
            borderWidth: 1.5,
          ),
        );
      }
    } else {
      // Default Sarah & Alex avatars
      avatarWidgets = [
        UserAvatar(
          initials: 'S',
          size: 26,
          backgroundColor: palette.secondary,
          borderColor: Colors.white,
          borderWidth: 1.5,
        ),
        UserAvatar(
          initials: 'A',
          size: 26,
          backgroundColor: palette.primary,
          borderColor: Colors.white,
          borderWidth: 1.5,
        ),
      ];
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.lg - 6,
        ),
        decoration: BoxDecoration(
          color: palette.surfaceLow,
          borderRadius: AppRadius.roundedLg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AvatarStack(
                  avatars: avatarWidgets,
                  overlap: 18.0,
                  height: 26.0,
                ),
                const SizedBox(width: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: palette.onSurface,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: palette.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.group_rounded, color: palette.secondary, size: 18),
          ],
        ),
      ),
    );
  }
}
