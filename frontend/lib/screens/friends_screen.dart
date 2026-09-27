import 'package:flutter/material.dart';
import '../models/friend_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../widgets/common/app_search_bar.dart';
import '../widgets/common/app_section_header.dart';
import '../widgets/common/gamescout_app_bar.dart';
import '../widgets/social/friend_card.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  int _selectedFriendFilter = 0; // 0 = All, 1 = Online (2)
  bool _hasPendingRequest = true;
  final TextEditingController _searchController = TextEditingController();

  static const String _avatarMarcus =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCdd37hee8AVlcS0vABl8jfjil1Axx-3w5eOF26nQVHLdyDEkj3CnJhw-ZA1zckeRwZmV7zR8u2FvbHqqZ6QiUhLG8U9smM9lNk3JIFq2Hot95gVGccy6_yNrLlHAFQTscck-RVKLAfcYC9qTkaBU2BFqZZsQhRrKnVWwzy6htgHyJk6CwlRHazGNB6bqQrczmpP-ZMzjcyq2TREjhCWDNB4fhr8QK7waVA5Wk1RAX1eIfNbMjJtVBGVA';
  static const String _avatarSarah =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCH2EY9D7lu1aI__1zEoQER2Uo_b6jFtSREVRjguHYfEqozUUS1nNpNvKg8sIqBzwingyWWRAcDJOpLSX0ZN6k0jBV4cO4mrDSVrReFZLAfojDaoIIEaUH5eWmiqmgI0yGMTMZ41L0OyxTLO1GvqRABiRMzT4szBaUNRqd5ks8sEuLCu50cmwzdzp8xR6QL0Qi6czFkoUMDdMdq5kopy6JmWaKS0eADQd22WTKjytpmtPxp-w6ebAX2Tw';
  static const String _avatarAlex =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCUIateGIolh6xKskQSAw9K_qCknlPw0h7OC2UaeL_JzKuj2cNsTxshSABYaRHCj5NsyNv4DFCt9BzCQZJIXOcPWPsldJ4-Byy9V1Ui3BL7ptidx_C6ObJzirN0O5zml2SPfBKWjodughXuPJVCCUyzWstxZw3au2BpHgwhQqfnExLojfFtte3u9WWwNXzJKwjwx6_bmNSLCsKozCE9-IRtB3guiNgIjqvFQqm68QOkQK6gDi1K11LgvQ';
  static const String _avatarMaya =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuDpcfYvmxffqV5IwhpJfVAkPFDpBXXkgGBfARq4aZNNNbZEGNQzKOiGMO1I_BWThlSAL01U7IyeqZsQdnmyvYkWNGf5lcGrHRn8gce3r85BTlYfo0FZ6wswQC104_lP3zve1yRKXJoXl5_gMJqqqqPWO7gKgFPvyH8fwaNd4d0uXSs1OzP6kE8-vCOFJjiksGrIvugJgYCekIvMN8NBLzxDbh1-g4BbXylk37eu4DgO466u__-GDObXtQ';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    // Title & Add Friend Action Bar
                    _buildTitleAndAddFriendBar(palette),

                    // Search & QR Scanner Row
                    _buildSearchAndQrRow(palette),

                    // Section 1: Friend Requests
                    if (_hasPendingRequest) ...[
                      _buildFriendRequestsSection(palette),
                      const SizedBox(height: 18),
                    ],

                    // Section 2: Your Friends (12) + Filter Pills
                    _buildYourFriendsHeader(palette),

                    const SizedBox(height: AppSpacing.sm + 2),

                    // Friends Cards List
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        children: [
                          FriendCard(
                            name: 'SarahJenkins',
                            avatarUrl: _avatarSarah,
                            gamesInCommon: 14,
                            gamesInCommonSuffix: 'Active Now',
                            isOnline: true,
                            activityType: FriendActivityType.currentlyPlaying,
                            activityGame: 'Cyberpunk 2077',
                            onViewProfile: () =>
                                _showFriendProfile('SarahJenkins'),
                          ),
                          const SizedBox(height: AppSpacing.sm + 2),
                          FriendCard(
                            name: 'AlexRider99',
                            avatarUrl: _avatarAlex,
                            gamesInCommon: 9,
                            gamesInCommonSuffix: 'L...',
                            isOnline: true,
                            activityType: FriendActivityType.mutualWishlist,
                            activityHighlight: 'Hades II',
                            onViewProfile: () =>
                                _showFriendProfile('AlexRider99'),
                          ),
                          if (_selectedFriendFilter == 0) ...[
                            const SizedBox(height: AppSpacing.sm + 2),
                            FriendCard(
                              name: 'MayaGamer',
                              avatarUrl: _avatarMaya,
                              gamesInCommon: 6,
                              gamesInCommonSuffix: '2h ago',
                              isOnline: false,
                              activityType: FriendActivityType.idle,
                              onViewProfile: () =>
                                  _showFriendProfile('MayaGamer'),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Bottom Discovery / Sync Card
                    _buildSyncAccountsCard(palette),

                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFriendProfile(String name) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Viewing $name\'s profile')));
  }

  // --- Title & Add Friend Action Bar ---
  Widget _buildTitleAndAddFriendBar(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Friends',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: palette.onSurface,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                'Connect, compare taste & co-op',
                style: TextStyle(
                  fontSize: 13.5,
                  color: palette.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Open Add Friend search')),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: palette.primary,
                borderRadius: AppRadius.roundedMd,
                boxShadow: [
                  BoxShadow(
                    color: palette.primary.withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_add_rounded, color: Colors.white, size: 17),
                  SizedBox(width: 6),
                  Text(
                    'Add Friend',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Search & QR Scanner Row ---
  Widget _buildSearchAndQrRow(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, 14),
      child: AppSearchBar(
        controller: _searchController,
        hintText: 'Search by gamer tag, Steam ID...',
        trailing: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('QR Scanner & Gamer Code opened')),
            );
          },
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: palette.cardBg,
              borderRadius: AppRadius.roundedMd,
              border: Border.all(color: palette.borderStroke),
            ),
            child: Icon(
              Icons.qr_code_scanner_rounded,
              color: palette.secondary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  // --- Section 1: Friend Requests (1) ---
  Widget _buildFriendRequestsSection(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'FRIEND REQUESTS', countBadge: '(1)'),
          const SizedBox(height: AppSpacing.sm),
          FriendRequestCard(
            name: 'Marcus_Vance',
            avatarUrl: _avatarMarcus,
            subtitle: 'Wants to sync taste profiles',
            mutualTags: '84% match · Both love Elden Ring',
            onAccept: () {
              setState(() => _hasPendingRequest = false);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Accepted Marcus_Vance\'s friend request!'),
                ),
              );
            },
            onIgnore: () {
              setState(() => _hasPendingRequest = false);
            },
          ),
        ],
      ),
    );
  }

  // --- Section 2: Your Friends Header + Filter Chips ---
  Widget _buildYourFriendsHeader(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionHeader(title: 'YOUR FRIENDS', countBadge: '(12)'),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _selectedFriendFilter = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedFriendFilter == 0
                            ? palette.onSurface
                            : palette.cardBg,
                        borderRadius: AppRadius.roundedSm,
                        border: _selectedFriendFilter == 0
                            ? null
                            : Border.all(color: palette.borderStroke),
                      ),
                      child: Text(
                        'All',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _selectedFriendFilter == 0
                              ? palette.cardBg
                              : palette.secondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs + 2),
                  GestureDetector(
                    onTap: () => setState(() => _selectedFriendFilter = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedFriendFilter == 1
                            ? palette.onSurface
                            : palette.cardBg,
                        borderRadius: AppRadius.roundedSm,
                        border: _selectedFriendFilter == 1
                            ? null
                            : Border.all(color: palette.borderStroke),
                      ),
                      child: Text(
                        'Online (2)',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _selectedFriendFilter == 1
                              ? palette.cardBg
                              : palette.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Bottom Sync Accounts Banner ---
  Widget _buildSyncAccountsCard(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md + 2),
        decoration: BoxDecoration(
          color: palette.cardBg,
          borderRadius: AppRadius.roundedCard,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: palette.isDark ? 0.2 : 0.04,
              ),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: palette.primaryFixed,
                borderRadius: AppRadius.roundedLargeCard,
              ),
              child: Center(
                child: Icon(
                  Icons.sync_alt_rounded,
                  color: palette.primary,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sync Platform Friends',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: palette.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    'Connect Steam, PSN, or Xbox',
                    style: TextStyle(fontSize: 12, color: palette.secondary),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: palette.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
