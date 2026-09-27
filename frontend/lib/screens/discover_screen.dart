import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../widgets/common/avatar_stack.dart';
import '../widgets/common/gamescout_app_bar.dart';
import '../widgets/common/user_avatar.dart';
import '../widgets/game/game_image.dart';
import '../widgets/game/game_rating.dart';
import '../widgets/game/game_tag_chip.dart';
import '../widgets/game/platform_badge.dart';
import '../widgets/game/recommendation_reason.dart';
import 'game_details_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _currentIndex = 3; // 4 / 15 as shown in reference design

  static const String _cyberpunkCover =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuC5jQg7PUuaApEsJpn5hEdeHUH3PhrXZQ-gagd6HUaUe1EEqFbgsjLOokuqFkw6_RpeWfPkIvBW6fl8fc78GmUn9MqSP99ep_JHfm-KY6LMOqGg9MXcmCYigIhED00x9pOdBoziO0X1muHYzPa79OhYomyai7eGoqPz84WEMsBz9lE3PZIQHN-Nok7hfLWyOYlE-ZIOWEM3E3mUWvvw2jcDYS2htDAzi761XT4QZ3BvDFVoWmPFEiha_g';

  void _handleAction(String type) {
    String msg = '';
    if (type == 'PASS') {
      msg = 'Passed on this title.';
    } else if (type == 'NOT_SURE') {
      msg = 'Saved for later consideration.';
    } else if (type == 'LIKE') {
      msg = 'Liked! Added to your collection.';
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 1)),
    );

    setState(() {
      _currentIndex = (_currentIndex + 1) % 15;
    });
  }

  void _navigateToDetails() {
    final game = GameItem.mockGames[0];
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => GameDetailsScreen(game: game)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return Scaffold(
      backgroundColor: palette.bgSurface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top App Bar
            const GameScoutAppBar(title: 'GameScout'),

            // Main Scrollable Area
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  90,
                ),
                child: Column(
                  children: [
                    // Daily Selection Status Bar
                    _buildDailyStatusBar(palette),

                    const SizedBox(height: AppSpacing.sm),

                    // Primary Discovery Card Stack
                    _buildDiscoveryCardDeck(palette),

                    const SizedBox(height: 18),

                    // Intent Discovery Action Bar (Pass, Not Sure, Like)
                    _buildActionButtons(palette),

                    const SizedBox(height: AppSpacing.md),

                    // Deep Dive Hint Button
                    GestureDetector(
                      onTap: _navigateToDetails,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.xs,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Explore game details',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: palette.secondary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 16,
                              color: palette.secondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Daily Selection Status Bar ---
  Widget _buildDailyStatusBar(AppPalette palette) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: palette.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'DAILY SELECTION',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: palette.secondary,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: palette.surfaceContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            '${_currentIndex + 1} / 15',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: palette.secondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  // --- Primary Discovery Card Deck ---
  Widget _buildDiscoveryCardDeck(AppPalette palette) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Subtle Underneath Card Layer for Depth
        Positioned(
          left: 10,
          right: 10,
          bottom: -6,
          top: 10,
          child: Container(
            decoration: BoxDecoration(
              color: palette.isDark
                  ? const Color(0xFF1E233D)
                  : const Color(0xFFE8E8E9),
              borderRadius: AppRadius.roundedXl,
            ),
          ),
        ),

        // Active Discovery Card
        GestureDetector(
          onTap: _navigateToDetails,
          child: Container(
            decoration: BoxDecoration(
              color: palette.cardBg,
              borderRadius: AppRadius.roundedXl,
              border: Border.all(color: palette.borderStroke),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: palette.isDark ? 0.2 : 0.06,
                  ),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Artwork Framing
                Stack(
                  children: [
                    SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: GameImage(
                        imageUrl: _cyberpunkCover,
                        borderRadius: AppRadius.roundedCard,
                      ),
                    ),

                    // Top Left Platform Badge
                    const Positioned(
                      top: 10,
                      left: 10,
                      child: PlatformBadge(label: 'PC • PS5 • XBOX'),
                    ),

                    // Top Right Rating
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: GameRating(rating: 4.6),
                    ),

                    // Bottom Right: DLC Included
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: GameTagChip(
                        label: 'DLC Included',
                        hasDot: true,
                        backgroundColor: palette.cardBg.withValues(alpha: 0.92),
                        textColor: palette.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Recommendation Context Pill
                const RecommendationReason(
                  reason: 'Because you played The Witcher 3',
                ),
                const SizedBox(height: AppSpacing.sm),

                // Studio & Year
                Row(
                  children: [
                    Text(
                      'CD PROJEKT RED',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: palette.secondary,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '•',
                      style: TextStyle(color: palette.secondary, fontSize: 11),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '2023',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: palette.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),

                // Game Title
                Text(
                  'Cyberpunk 2077: Phantom Liberty',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                    color: palette.onSurface,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),

                // Curated Tags
                const Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    GameTagChip(
                      label: 'Open World',
                      variant: GameTagVariant.status,
                    ),
                    GameTagChip(
                      label: 'Action RPG',
                      variant: GameTagVariant.status,
                    ),
                    GameTagChip(
                      label: 'Narrative Thriller',
                      variant: GameTagVariant.status,
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Editorial Synopsis
                Text(
                  'Enter the espionage thriller in Dogtown. Step into the shoes of cyber-enhanced mercenaries to rescue the...',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: palette.secondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.md),

                // Social Proof / Friend Endorsement Box
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: palette.surfaceLow,
                    borderRadius: AppRadius.roundedMd,
                    border: Border.all(color: palette.borderStroke),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AvatarStack(
                            avatars: [
                              UserAvatar(
                                initials: 'S',
                                size: 24,
                                backgroundColor: palette.secondaryContainer,
                                borderColor: palette.cardBg,
                                borderWidth: 1.5,
                              ),
                              UserAvatar(
                                initials: 'A',
                                size: 24,
                                backgroundColor: const Color(0xFFC1E8FF),
                                borderColor: palette.cardBg,
                                borderWidth: 1.5,
                              ),
                            ],
                            overlap: 14.0,
                            height: 24.0,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 11.5,
                                color: palette.secondary,
                              ),
                              children: [
                                const TextSpan(text: 'Recommended by '),
                                TextSpan(
                                  text: 'Sarah',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: palette.onSurface,
                                  ),
                                ),
                                const TextSpan(text: ' & '),
                                TextSpan(
                                  text: 'Alex',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: palette.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.thumb_up_outlined,
                        size: 16,
                        color: palette.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Intent Discovery Action Buttons (Pass, Not Sure, Like) ---
  Widget _buildActionButtons(AppPalette palette) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pass Action Button
        GestureDetector(
          onTap: () => _handleAction('PASS'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: palette.cardBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: palette.borderStroke),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.close_rounded,
                    color: Color(0xFFE5394F),
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Pass',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: palette.secondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.xxl),

        // Not Sure Action Button
        GestureDetector(
          onTap: () => _handleAction('NOT_SURE'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: palette.cardBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: palette.borderStroke),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.schedule_rounded,
                    color: Color(0xFFD99100),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Not Sure',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: palette.secondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.xxl),

        // Like Action Button
        GestureDetector(
          onTap: () => _handleAction('LIKE'),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: palette.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: palette.primary.withValues(alpha: 0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Like',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: palette.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
