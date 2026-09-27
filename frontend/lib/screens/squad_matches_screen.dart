import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../widgets/common/app_filter_chips.dart';
import '../widgets/common/gamescout_app_bar.dart';
import '../widgets/common/user_avatar.dart';
import '../widgets/social/squad_match_card.dart';
import 'game_details_screen.dart';

class SquadMatchesScreen extends StatefulWidget {
  const SquadMatchesScreen({super.key});

  @override
  State<SquadMatchesScreen> createState() => _SquadMatchesScreenState();
}

class _SquadMatchesScreenState extends State<SquadMatchesScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = [
    'All (8)',
    'Multiplayer',
    'Crossplay',
    'PC',
    'PlayStation',
    'Xbox',
    'Switch',
  ];

  static const String _helldiversCover =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBuXL38Gkf2Fd2H6P_g_ALXapNkOditMqv3rrcjfQke-3DpewX6aKSfVCP06dTX6IfsjxnL7e6B95zclKQDjVihbHxs5y7dKuEhvGK7Gv_Sp-8jYtXLq3sgVndOzZ1ZVMuRBk5Vgg48PIZ8PC6MozDn3qzygEcozC2VyKBGTmJJiH1bUnoOTpIzyGx6EF6Uf80UFgdLMZAPSDQm1MWF27J0jjnxPw40QqEjuCrW9B1vj-SKlrxUIPq5JA';
  static const String _baldursCover =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuD3U3p7W2tqj1xZ2s53rCkWwD1d_5eKz8m1W4x5y7dKuEhvGK7Gv_Sp-8jYtXLq3sgVndOzZ1ZVMuRBk5Vgg48PIZ8PC6MozDn3qzygEcozC2VyKBGTmJJiH1bUnoOTpIzyGx6EF6Uf80UFgdLMZAPSDQm1MWF27J0jjnxPw40QqEjuCrW9B1vj-SKlrxUIPq5JA';
  static const String _monsterHunterCover =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDYm7q4p6Z3x1W2s53rCkWwD1d_5eKz8m1W4x5y7dKuEhvGK7Gv_Sp-8jYtXLq3sgVndOzZ1ZVMuRBk5Vgg48PIZ8PC6MozDn3qzygEcozC2VyKBGTmJJiH1bUnoOTpIzyGx6EF6Uf80UFgdLMZAPSDQm1MWF27J0jjnxPw40QqEjuCrW9B1vj-SKlrxUIPq5JA';

  static const String _avatarSarah =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDfoT-aEZjzQXtS_GeUTvJcN_3DYtJCt4C-IBS9o0r_rM2HRARTcIu8pF5m92tVGeZTiLLWHmI7paAEkynpDdrquFiO2As5qRdQQKQyn2dLkvthHvKIerkrCXbeZNH_GsQBJMim1GUcoO2GZXwyxdLL7q9SywUh7Gcu1tT34RdFvnucfWLuWXAC859vj5ypO9bSXyfc7xAtAbb25aZUtkiyGVueqaTTYzniv-V5uu4hwqeUWUkvE_lmOQ';
  static const String _avatarAlex =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBD4jSMy7A99Oxu-6oaPR6wXgvnFkb3Qw7Errv2Rn0-fz6TpWN_F6qDF50owhsEl4zUm63y8LJglywMMmq9UKaGHwH4NL0MvMtpcbEwJPfUPK2sSNfuvdw0Qoqz8UyCXMCo6jATqPQISCy0c6fSA8kfmTB5JIAYi3LPWFXmxLv4ulLxk4lKFEbD_oj4zbPkZYB1j4eMYNm34F8bZL64QYjKLaTTaakGSgm9KKOPvrpXw6MuR8owC0DV9Q';

  void _navigateToDetails(String title) {
    final game = GameItem.mockGames.firstWhere(
      (g) => g.title.toLowerCase().contains(title.toLowerCase()),
      orElse: () => GameItem.mockGames[0],
    );
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

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Editorial Header Section
                    _buildEditorialHeader(palette),

                    // Horizontal Filter Chips Carousel
                    FilterChipRow(
                      filters: _filters,
                      selectedIndex: _selectedFilterIndex,
                      onSelected: (index) =>
                          setState(() => _selectedFilterIndex = index),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Match Cards Listing
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        children: [
                          SquadMatchCard(
                            title: 'Helldivers 2',
                            developer: 'Arrowhead Game Studios',
                            releaseYear: '2024',
                            genre: 'Co-op Shooter',
                            coverUrl: _helldiversCover,
                            matchBadge: '100% Squad Compatibility',
                            socialHeader: 'You + Sarah & Alex like this',
                            socialAvatarUrls: const [_avatarSarah, _avatarAlex],
                            tags: const [
                              'Multiplayer · 1–4 players',
                              'Platform Compatible',
                              'Crossplay Enabled',
                            ],
                            onTap: () => _navigateToDetails('Helldivers'),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          SquadMatchCard(
                            title: "Baldur's Gate 3",
                            developer: 'Larian Studios',
                            releaseYear: '2023',
                            genre: 'Party RPG',
                            coverUrl: _baldursCover,
                            matchBadge: '92% Squad Compatibility',
                            socialHeader: 'Sarah & Maya want to play',
                            socialAvatarUrls: const [_avatarSarah, _avatarAlex],
                            tags: const [
                              'Co-Op · 1–4 players',
                              'Turn-based Tactical',
                              'Cross-Save',
                            ],
                            actionButtonText: 'Coordinate Party Session',
                            onTap: () => _navigateToDetails("Baldur"),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          SquadMatchCard(
                            title: 'Monster Hunter Wilds',
                            developer: 'Capcom',
                            releaseYear: '2025',
                            genre: 'Action RPG',
                            coverUrl: _monsterHunterCover,
                            matchBadge: '88% Squad Wishlisted',
                            socialHeader: 'Alex & 2 others wishlisted',
                            socialAvatarUrls: const [_avatarAlex, _avatarSarah],
                            tags: const [
                              'Online Co-Op',
                              'Seamless Crossplay',
                              'Full Squad Hunts',
                            ],
                            actionButtonText: 'Set Squad Release Alert',
                            onTap: () => _navigateToDetails('Monster'),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          _buildSquadAvailabilityBanner(palette),
                          const SizedBox(height: AppSpacing.lg),
                        ],
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

  // --- Editorial Header Section ---
  Widget _buildEditorialHeader(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SOCIAL MATCHMAKING',
                style: TextStyle(
                  color: palette.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: palette.secondaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: palette.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '3 Online Friends',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: palette.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Matches',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              color: palette.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Games you and your friends can play together',
            style: TextStyle(
              fontSize: 14,
              color: palette.secondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // --- Squad Availability Banner ---
  Widget _buildSquadAvailabilityBanner(AppPalette palette) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: palette.cardBg,
        borderRadius: AppRadius.roundedCard,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SQUAD AVAILABILITY',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: palette.secondary,
                  letterSpacing: 0.8,
                ),
              ),
              Text(
                'Tonight at 8:00 PM',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: palette.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              UserAvatar(
                imageUrl: _avatarSarah,
                size: 36,
                isOnline: true,
                showOnlineIndicator: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              UserAvatar(
                imageUrl: _avatarAlex,
                size: 36,
                isOnline: true,
                showOnlineIndicator: true,
              ),
              const SizedBox(width: AppSpacing.sm),
              UserAvatar(
                initials: 'M',
                size: 36,
                backgroundColor: palette.secondary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  '3 players ready for Helldivers 2 squad session',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: palette.onSurface,
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
