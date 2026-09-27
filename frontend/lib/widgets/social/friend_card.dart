import 'package:flutter/material.dart';
import '../../models/friend_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../common/user_avatar.dart';

class FriendCard extends StatelessWidget {
  final FriendModel? friend;
  final String name;
  final String avatarUrl;
  final int gamesInCommon;
  final bool isOnline;
  final FriendActivityType activityType;
  final String? activityGame;
  final String? activityHighlight;
  final String gamesInCommonSuffix;
  final VoidCallback? onViewProfile;

  const FriendCard({
    super.key,
    this.friend,
    this.name = '',
    this.avatarUrl = '',
    this.gamesInCommon = 0,
    this.isOnline = false,
    this.activityType = FriendActivityType.idle,
    this.activityGame,
    this.activityHighlight,
    this.gamesInCommonSuffix = '',
    this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    final effectiveName = name.isNotEmpty ? name : (friend?.name ?? '');
    final effectiveAvatar = avatarUrl.isNotEmpty
        ? avatarUrl
        : (friend?.avatarUrl ?? '');
    final effectiveCommon = gamesInCommon > 0
        ? gamesInCommon
        : (friend?.gamesInCommon ?? 0);
    final effectiveOnline = isOnline || (friend?.isOnline ?? false);
    final effectiveType = activityType != FriendActivityType.idle
        ? activityType
        : (friend?.activityType ?? FriendActivityType.idle);
    final effectiveGame = activityGame ?? friend?.activityGame;
    final effectiveHighlight = activityHighlight ?? friend?.activityHighlight;

    String commonSubtitle = '$effectiveCommon games in common';
    if (gamesInCommonSuffix.isNotEmpty) {
      commonSubtitle += ' · $gamesInCommonSuffix';
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md + 2),
      decoration: BoxDecoration(
        color: palette.cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: palette.isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header Row: Avatar, Name & Common Games, Action
          Row(
            children: [
              UserAvatar(
                imageUrl: effectiveAvatar,
                size: 44,
                isOnline: effectiveOnline,
                showOnlineIndicator: true,
              ),
              const SizedBox(width: AppSpacing.md),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      effectiveName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: palette.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      commonSubtitle,
                      style: TextStyle(fontSize: 12, color: palette.secondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: onViewProfile,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: palette.surfaceContainer,
                    borderRadius: AppRadius.roundedMd,
                  ),
                  child: Text(
                    'View Profile',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: palette.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Activity Banner (if any)
          if (effectiveType != FriendActivityType.idle) ...[
            const SizedBox(height: AppSpacing.sm + 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: palette.surfaceLow,
                borderRadius: AppRadius.roundedMd,
              ),
              child: Row(
                children: [
                  Icon(
                    effectiveType == FriendActivityType.currentlyPlaying
                        ? Icons.sports_esports_rounded
                        : Icons.favorite_rounded,
                    color: palette.primary,
                    size: 16,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: palette.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text:
                                effectiveType ==
                                    FriendActivityType.currentlyPlaying
                                ? 'Currently playing '
                                : 'Both wishlisted ',
                          ),
                          TextSpan(
                            text:
                                effectiveType ==
                                    FriendActivityType.currentlyPlaying
                                ? (effectiveGame ?? '')
                                : (effectiveHighlight ?? ''),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: palette.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class FriendRequestCard extends StatelessWidget {
  final String name;
  final String avatarUrl;
  final String subtitle;
  final String mutualTags;
  final VoidCallback? onAccept;
  final VoidCallback? onIgnore;

  const FriendRequestCard({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.subtitle,
    required this.mutualTags,
    this.onAccept,
    this.onIgnore,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md + 2),
      decoration: BoxDecoration(
        color: palette.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.borderStroke),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: palette.isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              UserAvatar(imageUrl: avatarUrl, size: 44),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: palette.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12, color: palette.secondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm + 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: palette.surfaceLow,
              borderRadius: AppRadius.roundedMd,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color: palette.primary,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    mutualTags,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: palette.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onAccept,
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: palette.primary,
                      borderRadius: AppRadius.roundedMd,
                    ),
                    child: const Center(
                      child: Text(
                        'Accept Request',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: GestureDetector(
                  onTap: onIgnore,
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: palette.surfaceLow,
                      borderRadius: AppRadius.roundedMd,
                    ),
                    child: Center(
                      child: Text(
                        'Ignore',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: palette.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
