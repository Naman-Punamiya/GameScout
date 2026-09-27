import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'compatibility_chip.dart';

class DiscoveryCard extends StatelessWidget {
  final GameItem game;
  final VoidCallback? onInfoTap;

  const DiscoveryCard({super.key, required this.game, this.onInfoTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderStroke, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x73000000),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Game Cover Image
            Image.network(
              game.coverUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.surface2,
                child: const Center(
                  child: Icon(
                    Icons.videogame_asset,
                    size: 64,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: AppColors.surface2,
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              },
            ),

            // Gradient Overlay
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.cardOverlayGradient,
              ),
            ),

            // Top Status Bar (Rating & Info Button)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rating Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xB3101321),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderStroke),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: Color(0xFFFBBF24),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          game.rating.toStringAsFixed(1),
                          style: AppTypography.labelMd.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${_formatCount(game.ratingCount)})',
                          style: AppTypography.bodySm.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ),

                  // Info / Details Button
                  GestureDetector(
                    onTap: onInfoTap,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xB3101321),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.borderStroke),
                      ),
                      child: const Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Content
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Compatibility Badges
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (game.isCrossplay)
                        const CompatibilityChip(
                          label: 'Crossplay',
                          icon: Icons.alt_route_rounded,
                          variant: ChipVariant.primary,
                        ),
                      if (game.isCoop)
                        const CompatibilityChip(
                          label: 'Co-Op',
                          icon: Icons.groups_rounded,
                          variant: ChipVariant.secondary,
                        ),
                      CompatibilityChip(
                        label: game.minMaxPlayers,
                        icon: Icons.person_outline_rounded,
                        variant: ChipVariant.neutral,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Title
                  Text(
                    game.title,
                    style: AppTypography.headlineLg.copyWith(fontSize: 26),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Developer & Year
                  Text(
                    '${game.developer} • ${game.releaseYear}',
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description snippet
                  Text(
                    game.description,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.85),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Platform Icons & Genre Badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Genre Badges
                      Expanded(
                        child: Wrap(
                          spacing: 6,
                          children: game.genres.take(2).map((genre) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surface2.withValues(
                                  alpha: 0.8,
                                ),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.borderStroke,
                                ),
                              ),
                              child: Text(
                                genre,
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Platforms row
                      Row(
                        children: game.platforms.map((p) {
                          IconData platformIcon = Icons.computer;
                          if (p.contains('PS')) {
                            platformIcon = Icons.gamepad_rounded;
                          }
                          if (p.contains('Xbox')) {
                            platformIcon = Icons.sports_esports_rounded;
                          }
                          if (p.contains('Deck')) {
                            platformIcon = Icons.tablet_mac_rounded;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Icon(
                              platformIcon,
                              size: 16,
                              color: AppColors.textMuted,
                            ),
                          );
                        }).toList(),
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

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
