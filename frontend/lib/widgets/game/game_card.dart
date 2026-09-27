import 'package:flutter/material.dart';
import '../../models/game_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';
import '../social/peer_endorsement_bar.dart';
import 'game_image.dart';
import 'game_rating.dart';
import 'game_tag_chip.dart';
import 'platform_badge.dart';
import 'recommendation_reason.dart';

enum GameCardVariant {
  standard, // Wishlist 2-column or list view
  discovery, // Full editorial card in Discover
  compact, // Compact list tile
}

class GameCard extends StatelessWidget {
  final GameItem? game;
  final String title;
  final String developer;
  final String releaseYear;
  final String coverUrl;
  final double rating;
  final int? ratingCount;
  final String? ratingBadge;
  final String? platformBadge;
  final bool hasDlc;
  final List<String> tags;
  final String? price;
  final String? originalPrice;
  final String? description;
  final String? recommendationReason;
  final bool isSaved;
  final GameCardVariant variant;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  const GameCard({
    super.key,
    this.game,
    this.title = '',
    this.developer = '',
    this.releaseYear = '',
    this.coverUrl = '',
    this.rating = 0.0,
    this.ratingCount,
    this.ratingBadge,
    this.platformBadge,
    this.hasDlc = false,
    this.tags = const [],
    this.price,
    this.originalPrice,
    this.description,
    this.recommendationReason,
    this.isSaved = false,
    this.variant = GameCardVariant.standard,
    this.onTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    // Resolve properties from GameItem if provided
    final effectiveTitle = title.isNotEmpty ? title : (game?.title ?? '');
    final effectiveDeveloper = developer.isNotEmpty
        ? developer
        : (game?.developer ?? '');
    final effectiveYear = releaseYear.isNotEmpty
        ? releaseYear
        : (game?.releaseYear ?? '');
    final effectiveCover = coverUrl.isNotEmpty
        ? coverUrl
        : (game?.coverUrl ?? '');
    final effectiveRating = rating > 0 ? rating : (game?.rating ?? 4.6);
    final effectiveCount = ratingCount ?? game?.ratingCount;
    final effectiveTags = tags.isNotEmpty ? tags : (game?.genres ?? []);
    final effectiveDescription = description ?? game?.description ?? '';

    if (variant == GameCardVariant.discovery) {
      return _buildDiscoveryVariant(
        context,
        palette,
        effectiveTitle,
        effectiveDeveloper,
        effectiveYear,
        effectiveCover,
        effectiveRating,
        effectiveCount,
        effectiveTags,
        effectiveDescription,
      );
    }

    return _buildStandardVariant(
      context,
      palette,
      effectiveTitle,
      effectiveDeveloper,
      effectiveYear,
      effectiveCover,
      effectiveRating,
      effectiveTags,
    );
  }

  // --- Standard Grid / List Variant (e.g. Wishlist) ---
  Widget _buildStandardVariant(
    BuildContext context,
    AppPalette palette,
    String effectiveTitle,
    String effectiveDeveloper,
    String effectiveYear,
    String effectiveCover,
    double effectiveRating,
    List<String> effectiveTags,
  ) {
    final devText = effectiveYear.isNotEmpty
        ? '$effectiveDeveloper · $effectiveYear'
        : effectiveDeveloper;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: palette.cardBg,
          borderRadius: AppRadius.roundedCard,
          border: Border.all(color: palette.borderStroke),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Artwork Image with Overlays
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 10.5,
                  child: GameImage(
                    imageUrl: effectiveCover,
                    borderRadius: BorderRadius.zero,
                  ),
                ),

                // Top Left Platform Badge
                if (platformBadge != null && platformBadge!.isNotEmpty)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: PlatformBadge(label: platformBadge!),
                  ),

                // Top Right Rating Badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: GameRating(
                    rating: effectiveRating,
                    ratingCountText: ratingBadge,
                  ),
                ),

                // Bottom Right DLC Pill
                if (hasDlc)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GameTagChip(
                      label: 'DLC Included',
                      hasDot: true,
                      backgroundColor: palette.cardBg.withValues(alpha: 0.92),
                      textColor: palette.onSurface,
                    ),
                  ),
              ],
            ),

            // Content Area
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Developer & Year
                  Text(
                    devText.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: palette.secondary,
                      letterSpacing: 0.4,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xxs),

                  // Title
                  Text(
                    effectiveTitle,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                      color: palette.onSurface,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Tags
                  if (effectiveTags.isNotEmpty)
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: effectiveTags
                          .take(2)
                          .map((t) => GameTagChip(label: t))
                          .toList(),
                    ),

                  const SizedBox(height: AppSpacing.md),

                  // Footer: Price & Saved Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (price != null)
                        Row(
                          children: [
                            Text(
                              price!,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: palette.onSurface,
                              ),
                            ),
                            if (originalPrice != null) ...[
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                originalPrice!,
                                style: TextStyle(
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough,
                                  color: palette.secondary,
                                ),
                              ),
                            ],
                          ],
                        )
                      else
                        const SizedBox.shrink(),
                      GestureDetector(
                        onTap: onBookmarkTap,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: isSaved
                                ? palette.primaryFixed
                                : palette.surfaceLow,
                            borderRadius: AppRadius.roundedSm,
                          ),
                          child: Icon(
                            isSaved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            size: 16,
                            color: isSaved
                                ? palette.primary
                                : palette.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Discovery Full Card Variant ---
  Widget _buildDiscoveryVariant(
    BuildContext context,
    AppPalette palette,
    String effectiveTitle,
    String effectiveDeveloper,
    String effectiveYear,
    String effectiveCover,
    double effectiveRating,
    int? effectiveCount,
    List<String> effectiveTags,
    String effectiveDescription,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: palette.cardBg,
        borderRadius: AppRadius.roundedCard,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Artwork with Overlays
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: GameImage(
                  imageUrl: effectiveCover,
                  borderRadius: BorderRadius.zero,
                ),
              ),

              // Top Left Badge
              Positioned(
                top: 12,
                left: 12,
                child: PlatformBadge(label: platformBadge ?? 'PC • PS5 • XBOX'),
              ),

              // Top Right Rating
              Positioned(
                top: 12,
                right: 12,
                child: GameRating(
                  rating: effectiveRating,
                  ratingCount: effectiveCount,
                ),
              ),

              // Bottom Right DLC Pill
              if (hasDlc)
                Positioned(
                  bottom: 10,
                  right: 12,
                  child: GameTagChip(
                    label: 'DLC Included',
                    hasDot: true,
                    backgroundColor: palette.cardBg.withValues(alpha: 0.92),
                    textColor: palette.onSurface,
                  ),
                ),
            ],
          ),

          // Editorial Content
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Metadata Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${effectiveDeveloper.toUpperCase()} • $effectiveYear • EXPANSION',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: palette.secondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'Single Player',
                      style: TextStyle(
                        fontSize: 11,
                        color: palette.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),

                // Main Title
                Text(
                  effectiveTitle,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                    color: palette.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Recommendation Context Pill
                if (recommendationReason != null &&
                    recommendationReason!.isNotEmpty) ...[
                  RecommendationReason(reason: recommendationReason!),
                  const SizedBox(height: AppSpacing.md),
                ],

                // Tags
                if (effectiveTags.isNotEmpty) ...[
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: effectiveTags
                        .map((t) => GameTagChip(label: t))
                        .toList(),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],

                // Synopsis
                if (effectiveDescription.isNotEmpty)
                  Text(
                    effectiveDescription,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: palette.secondary,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),

          // Peer Endorsement Bar
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: PeerEndorsementBar(),
          ),
        ],
      ),
    );
  }
}
