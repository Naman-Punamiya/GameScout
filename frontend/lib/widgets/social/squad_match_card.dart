import 'package:flutter/material.dart';
import '../../models/game_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../common/avatar_stack.dart';
import '../common/user_avatar.dart';
import '../game/game_image.dart';

class SquadMemberMatchInfo {
  final String name;
  final String avatarUrl;
  final String platform; // 'PC', 'PS5', 'Xbox', etc.
  final bool ownsGame;

  const SquadMemberMatchInfo({
    required this.name,
    required this.avatarUrl,
    required this.platform,
    this.ownsGame = true,
  });
}

class SquadMatchCard extends StatelessWidget {
  final GameItem? game;
  final String title;
  final String developer;
  final String releaseYear;
  final String genre;
  final String coverUrl;
  final String matchBadge; // e.g. '100% Squad Compatibility'
  final String socialHeader; // e.g. 'You + Sarah & Alex like this'
  final List<String> socialAvatarUrls;
  final List<String> tags;
  final String actionButtonText;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;

  const SquadMatchCard({
    super.key,
    this.game,
    this.title = '',
    this.developer = '',
    this.releaseYear = '',
    this.genre = '',
    this.coverUrl = '',
    this.matchBadge = '100% Squad Compatibility',
    this.socialHeader = 'You + Sarah & Alex like this',
    this.socialAvatarUrls = const [],
    this.tags = const [
      'Multiplayer · 1–4 players',
      'Platform Compatible',
      'Crossplay Enabled',
    ],
    this.actionButtonText = 'View Game & Plan Session',
    this.onTap,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    final effectiveTitle = title.isNotEmpty ? title : (game?.title ?? '');
    final effectiveDev = developer.isNotEmpty
        ? developer
        : (game?.developer ?? '');
    final effectiveYear = releaseYear.isNotEmpty
        ? releaseYear
        : (game?.releaseYear ?? '');
    final effectiveGenre = genre.isNotEmpty
        ? genre
        : (game?.genres.isNotEmpty == true ? game!.genres.first : 'Co-op');
    final effectiveCover = coverUrl.isNotEmpty
        ? coverUrl
        : (game?.coverUrl ?? '');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: palette.cardBg,
          borderRadius: AppRadius.roundedCard,
          border: Border.all(color: palette.borderStroke),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: palette.isDark ? 0.25 : 0.04,
              ),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artwork Image with Match Badge
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: GameImage(
                    imageUrl: effectiveCover,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: palette.primary,
                      borderRadius: AppRadius.roundedLargeCard,
                      boxShadow: [
                        BoxShadow(
                          color: palette.primary.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          color: Colors.white,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          matchBadge,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Card Body
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Social Consensus Bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: palette.surfaceLow,
                      borderRadius: AppRadius.roundedLg,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              if (socialAvatarUrls.isNotEmpty)
                                AvatarStack(
                                  avatars: socialAvatarUrls
                                      .map(
                                        (url) => UserAvatar(
                                          imageUrl: url,
                                          size: 26,
                                          borderColor: Colors.white,
                                          borderWidth: 1.5,
                                        ),
                                      )
                                      .toList(),
                                  overlap: 18.0,
                                  height: 26.0,
                                )
                              else
                                AvatarStack(
                                  avatars: [
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
                                  ],
                                  overlap: 18.0,
                                  height: 26.0,
                                ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(
                                  socialHeader,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: palette.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.groups_rounded,
                          color: palette.primary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Title & Metadata
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${effectiveDev.toUpperCase()} • $effectiveYear',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: palette.secondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        effectiveGenre,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: palette.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    effectiveTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                      color: palette.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Tag Clusters
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: tags.map((t) {
                      final isAccent =
                          t.contains('Platform') || t.contains('Crossplay');
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isAccent
                              ? palette.primaryFixed
                              : palette.surfaceContainer,
                          borderRadius: AppRadius.roundedSm,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              t.contains('Crossplay')
                                  ? Icons.sync_rounded
                                  : (t.contains('Platform')
                                        ? Icons.check_circle_rounded
                                        : Icons.group_rounded),
                              size: 14,
                              color: isAccent
                                  ? palette.primary
                                  : palette.secondary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              t,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: isAccent
                                    ? palette.primary
                                    : palette.secondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.md + 2),

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: onActionTap ?? onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: palette.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.roundedLg,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            actionButtonText,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_forward_rounded, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
