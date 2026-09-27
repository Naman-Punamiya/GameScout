import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../widgets/common/app_section_header.dart';
import '../widgets/common/gamescout_app_bar.dart';
import '../widgets/game/game_action_bar.dart';
import '../widgets/game/game_image.dart';
import '../widgets/game/game_media_carousel.dart';
import '../widgets/game/game_rating.dart';
import '../widgets/game/game_tag_chip.dart';
import '../widgets/game/platform_badge.dart';
import '../widgets/game/recommendation_reason.dart';
import '../widgets/social/peer_endorsement_bar.dart';

class GameDetailsScreen extends StatefulWidget {
  final GameItem? game;

  const GameDetailsScreen({super.key, this.game});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  String _decisionStatus = 'Pending Decision';
  Color? _statusColor;
  int _selectedDecision = -1; // 0: Pass, 1: Not Sure, 2: Like

  // Fallback / Showcase Media
  static const String _defaultCover =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuANDc--Bug7PBtpKpqCZ22Gwpqz1lgOKJc1e7upW6GQlBE8jGZksSjdIxoRmOlxEeaCLQIVmzf13d0cGhxuMxa51sFV_dRMEAewfz9a1WVarDvNfAQ5F-QgEr_Lq38fXnSuVc5Px0Q07BnHenKm8JSv1STDU3Wfcp9-NgUvMDgJHpPCJkTXmPmzT_HfzyjzJx_rwf9Spll_amgWt4yA70DPJFF2h4xChtVXv8KvSFkK1NM6LoHtJ7UVMg';
  static const String _trailerImg =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAUgyjgWE7cBuITPdTzQzeTUTYd1s01jGOhabic4zQTGSYaPQuZzWvN7VK0VbLuMgruK2Gn4uEBdG2H7SwNt0Cn2ND_ioByQ02DhjsLzkEiUdr8PMQEYy6KRvUfT8CTnWt9J1I-Ka12qxnHaFUncWb4RP3FqVOVtkdjIyav6Ha2gvPER234XQpa87oqIUjavuIwqqtrqyUSzisfL06p9eRXNydUYhE84_H4_itT1_0QUTGYgTQlhKHFgw';
  static const String _capture1 =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuB9CmgjgOMngMYWT966KUfGho2TktiIwNEC8B5tNoPvEEnEdWMGaS4vaH8lAUODfcDFK_amfLxOqN6DUXpxaR5lpz7UjVrVM3Tuh-YVU6eGfGN_SYXagWVG_DI7oQTZrVPctygUMChal7peNZ3sKdRId1u5szJA20tgl25XVaMl7JynIAsYBuf0Ny0bmj9Ax0Vhu05noLH8FDE8N7amtQX_1i3jm-jYO6gVv8SVi8152xH8tIVaq8aFaw';
  static const String _capture2 =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuD_vdtjoDwNPxk_bA7jcfMc_rqda5jbXJyCGuSZtQjVrkqZyCXHw_ZECt0iA5CwL_pkxA78rnKK8TMvrLWqEWlSLOqLWr4x1vIbZzZqbFfTV2wRNeKuzPId2bjXmYw9N1NudRMoyqID6lMKXyVqEPaKcMnmGf5Sr5WbCR0u8H5D4dIbbef74X996O8r1neixjEmoSG9T9zbLgTGMI-MpkuWrbRnk6oo4YrsGQMwUy4UVmJgvZL-vco7jw';

  void _recordDecision(int type, AppPalette palette) {
    setState(() {
      _selectedDecision = type;
      if (type == 0) {
        _decisionStatus = 'Dossier Dismissed';
        _statusColor = const Color(0xFFBA1A1A);
      } else if (type == 1) {
        _decisionStatus = 'Saved to Consideration';
        _statusColor = const Color(0xFFD97706);
      } else if (type == 2) {
        _decisionStatus = 'Saved to Loved Games';
        _statusColor = palette.primary;
      }
    });

    final messages = [
      'Passed on this dossier.',
      'Marked as Not Sure. Added to backlog.',
      'Liked! Saved to your collection.',
    ];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messages[type]),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);
    final game = widget.game ?? GameItem.mockGames[0];
    final cover = game.coverUrl.isNotEmpty ? game.coverUrl : _defaultCover;
    final title = game.title.isNotEmpty
        ? game.title
        : 'Cyberpunk 2077: Phantom Liberty';
    final developer = game.developer.isNotEmpty
        ? game.developer
        : 'CD PROJEKT RED';
    final releaseYear = game.releaseYear.isNotEmpty ? game.releaseYear : '2023';
    final rating = game.rating > 0 ? game.rating : 4.6;
    final ratingCount = game.ratingCount > 0 ? game.ratingCount : 14200;
    final description = game.description.isNotEmpty
        ? game.description
        : 'Enter the espionage thriller in Dogtown. Step into the shoes of cyber-enhanced mercenary V and dive into a high-stakes web of spies, betrayal, and political intrigue to rescue the NUSA President.';

    final tags = [
      'Open World',
      'Action RPG',
      'Narrative Thriller',
      'Ray Tracing',
      'HDR',
    ];

    return Scaffold(
      backgroundColor: palette.bgSurface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top App Bar
            GameScoutAppBar(
              title: 'Game Details',
              showBackButton: true,
              onBack: () => Navigator.of(context).pop(),
              actions: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Share link copied to clipboard!'),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.share_rounded,
                    size: 20,
                    color: palette.secondary,
                  ),
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: palette.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // Main Scrollable Area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xxxl,
                ),
                child: Column(
                  children: [
                    // Main Game Dossier Card
                    _buildMainDossierCard(
                      palette: palette,
                      cover: cover,
                      title: title,
                      developer: developer,
                      releaseYear: releaseYear,
                      rating: rating,
                      ratingCount: ratingCount,
                      description: description,
                      tags: tags,
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Sticky Record Evaluation Decision Console
                    _buildDecisionConsole(palette),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Main Game Dossier Card ---
  Widget _buildMainDossierCard({
    required AppPalette palette,
    required String cover,
    required String title,
    required String developer,
    required String releaseYear,
    required double rating,
    required int ratingCount,
    required String description,
    required List<String> tags,
  }) {
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
          // Visual Stage / Artwork with Overlays
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: GameImage(
                  imageUrl: cover,
                  borderRadius: BorderRadius.zero,
                ),
              ),

              // Top Left Badge: PC • PS5 • XBOX
              const Positioned(
                top: 12,
                left: 12,
                child: PlatformBadge(label: 'PC • PS5 • XBOX'),
              ),

              // Top Right Badge: Rating
              Positioned(
                top: 12,
                right: 12,
                child: GameRating(rating: rating, ratingCount: ratingCount),
              ),

              // Bottom Right: DLC Included pill
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

          // Editorial Dossier Header
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
                      '${developer.toUpperCase()} • $releaseYear • EXPANSION',
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
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                    color: palette.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Recommendation Context Pill
                const RecommendationReason(
                  reason: 'Because you played The Witcher 3',
                ),
                const SizedBox(height: 10),

                // Tags & Capabilities
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: tags.map((t) => GameTagChip(label: t)).toList(),
                ),
              ],
            ),
          ),

          // Dossier Specifications Grid (2x2)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 2.3,
              children: [
                _buildSpecCell('DEVELOPER', developer, palette),
                _buildSpecCell('RELEASE DATE', 'Sept 26, 2023', palette),
                _buildSpecCell('PLATFORMS', 'PC, PS5, Xbox Seri...', palette),
                _buildSpecCell('AGE RATING', 'Mature 17+ (ESRB)', palette),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Dossier Overview / Synopsis
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'DOSSIER OVERVIEW',
                  icon: Icons.fingerprint_rounded,
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: palette.secondary,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Media Carousel Section: Field Captures & Footage
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'FIELD CAPTURES & FOOTAGE',
                countBadge: '3 items',
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Reusable Media Carousel Strip
              GameMediaCarousel(
                items: const [
                  GameMediaItem(
                    imageUrl: _trailerImg,
                    isVideo: true,
                    label: 'Official Trailer',
                  ),
                  GameMediaItem(imageUrl: _capture1),
                  GameMediaItem(imageUrl: _capture2),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

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

  // --- Spec Grid Cell Helper ---
  Widget _buildSpecCell(String label, String value, AppPalette palette) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: palette.surfaceLow,
        borderRadius: AppRadius.roundedMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: palette.secondary,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: palette.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // --- Sticky Record Evaluation Decision Console ---
  Widget _buildDecisionConsole(AppPalette palette) {
    final statusColor = _statusColor ?? palette.primary;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
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
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RECORD EVALUATION',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: palette.secondary,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                _decisionStatus,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Reusable 3-Action Decision Bar (Pass, Not Sure, Like)
          GameActionBar(
            selectedAction: _selectedDecision,
            onPass: () => _recordDecision(0, palette),
            onNotSure: () => _recordDecision(1, palette),
            onLike: () => _recordDecision(2, palette),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Reassurance Disclaimer
          Text(
            'Viewing details or media does not count as a Like.',
            style: TextStyle(fontSize: 11, color: palette.secondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
