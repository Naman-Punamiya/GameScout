import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../widgets/common/app_filter_chips.dart';
import '../widgets/common/gamescout_app_bar.dart';
import '../widgets/game/game_image.dart';
import '../widgets/game/game_tag_chip.dart';
import '../widgets/game/platform_badge.dart';
import 'game_details_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  int _selectedFilterIndex = 0;
  final String _currentSort = 'Recently Added';
  bool _priceDropAlertsEnabled = true;

  final List<String> _filters = [
    'All (18)',
    'On Sale (4)',
    'Unreleased (3)',
    'PC / Console',
  ];

  // Wishlist mock items matching Stitch design
  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'title': 'Cyberpunk 2077: Phantom Liberty',
      'developer': 'CD PROJEKT RED · 2023',
      'coverUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA85yizOSz24huEck-Lel8m8AF5kIFXaJle05GDajaZudSmZmftvx-LUxMwML9ru618Ufr5y7bZACIg0r3oCzNoJHOP4MxRN6KfVNPoxi0xyq8zP_vAVanX2CmaT4bhsL5Uhul3hItbSn91-y4-hEw-UzYjrxphQ7FJwX48qf5UG8TiRjzrt2jJ6Z3TV3-zBCkEwEmoSyXiW1ncRWDdUNPauZ_rVJpCUkbGLhPosfDae7RNNm8yqahhsvAHH9jV-QMeIWk',
      'platformBadge': 'PC · PS5 · XBOX',
      'ratingBadge': '4.6',
      'hasDlc': true,
      'tags': ['Single Player', 'RPG'],
      'price': r'$29.99',
      'originalPrice': r'$39.99',
      'isSaved': true,
    },
    {
      'title': 'Elden Ring: Shadow of the Erdtree',
      'developer': 'FromSoftware · 2024',
      'coverUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBqWsFfh9WdKlFb2yV3fcYpjsHVNtJaBUr5q8vmYCHI5bCUE0cfXHxH4ZubB-7XNDS04bi5gfYXt6nT-7OZQnhgrtPSCAj4kZ3iTz7Ja-09Vf1iXMclWcvArbFVuSUgu-qDVbHXxCYdNyHJAHXkYdS0CZrY4jCA7P4t3xDbLuZHwW5s9yrhDZvBghb98tlPav1Fz16Mnbl4GLNV_oPzC2o8bQ3edUrtDi9iwB51f_XpCY3Q2FCAqzL_SQ',
      'platformBadge': 'Multiplatform',
      'ratingBadge': '4.9',
      'hasDlc': false,
      'tags': ['Action RPG', 'Souls'],
      'price': r'$39.99',
      'originalPrice': null,
      'isSaved': true,
    },
    {
      'title': 'Hades II',
      'developer': 'Supergiant · 2024',
      'coverUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCfN6EqKZ6heyIDiqnBIebLJLzYwQQqFk7ws40tRPQhI7pTiI-SrO11xbQt4ULc5oydH8Wlu-cpogwjqcQr9fOfySqHEwg5BvhaHtrcvHU3kgOyAMoVZWoSKh9-io3Sw19PI_zQJZeLTdGFqyrN7HIGgP1KfyOstIFl3CO3cluoLy_Tod2oKCS-qh16dRA6OkO2kLi5x_wHRqH3ISXdqz153vNZJGEX9_NE1XSMnl1CKexxNXIqNEwzLg',
      'platformBadge': 'Early Access · PC',
      'ratingBadge': '4.8',
      'hasDlc': false,
      'tags': ['Roguelike', 'Indie'],
      'price': r'$29.99',
      'originalPrice': null,
      'isSaved': true,
    },
    {
      'title': 'Grand Theft Auto VI',
      'developer': 'Rockstar Games',
      'coverUrl':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDuqCul6Cn8-qCSefWfDe9DHfeFyvjBC_J-t_AdJVTqoTK0DQpGsscDKzWNmi8GmDrYs95OYcMH_r_usncpE-6IqOeZGI5x3DmUO51PK3fX9I39MTfT65tbA08BqbEYgs6bTCyQHzft2DHz1XkfdhCsWknxytfheZsIwnEkW2PxKYIUopEPdhsc0J_DCbQm8HkyZyZ7B8CHgEtey3t6U5n2BXsdWHR0SzyCSgRJxC3MDH6D-TPahTp5_Q',
      'platformBadge': 'PS5 · Xbox Series',
      'ratingBadge': '2025',
      'hasDlc': false,
      'tags': ['Open World', 'Action'],
      'price': 'Coming Soon',
      'originalPrice': null,
      'isSaved': true,
    },
  ];

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
                    // Header Section (Wishlist + 18 Saved)
                    _buildHeaderSection(palette),

                    // Sort & Filter Action Bar
                    _buildSortAndFilterBar(palette),

                    // Horizontal Filter Chips Carousel
                    FilterChipRow(
                      filters: _filters,
                      selectedIndex: _selectedFilterIndex,
                      onSelected: (index) =>
                          setState(() => _selectedFilterIndex = index),
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // 2-Column Grid of Wishlist Cards
                    _buildWishlistGrid(context, palette),

                    const SizedBox(height: AppSpacing.lg),

                    // Price Drop Alerts Card
                    _buildPriceDropAlertsCard(palette),

                    const SizedBox(height: 18),

                    // Footer Monograph Text
                    Center(
                      child: Text(
                        'GAMESCOUT MONOGRAPH CATALOG · LIVE TRACKING',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: palette.secondary,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Header Section ---
  Widget _buildHeaderSection(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wishlist',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  color: palette.onSurface,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                'Games you want to check out later',
                style: TextStyle(
                  fontSize: 13.5,
                  color: palette.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: palette.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              '18 Saved',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: palette.onSecondaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Sort & Filter Action Bar ---
  Widget _buildSortAndFilterBar(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sort options: Recently Added, Price, Rating'),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: palette.cardBg,
                borderRadius: AppRadius.roundedMd,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.sort_rounded, size: 16, color: palette.secondary),
                  const SizedBox(width: 6),
                  Text(
                    _currentSort,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: palette.onSurface,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.expand_more_rounded,
                    size: 16,
                    color: palette.secondary,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filter & View panel opened')),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: palette.cardBg,
                  borderRadius: AppRadius.roundedMd,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.tune_rounded,
                      size: 16,
                      color: palette.secondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Filter & View',
                      style: TextStyle(
                        fontSize: 12,
                        color: palette.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 2-Column Wishlist Game Cards Grid ---
  Widget _buildWishlistGrid(BuildContext context, AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _wishlistItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 0.58,
        ),
        itemBuilder: (context, index) {
          final item = _wishlistItems[index];
          return _buildWishlistCard(context, item, index, palette);
        },
      ),
    );
  }

  // --- Individual Wishlist Card ---
  Widget _buildWishlistCard(
    BuildContext context,
    Map<String, dynamic> item,
    int index,
    AppPalette palette,
  ) {
    final bool isSaved = item['isSaved'] as bool;

    return GestureDetector(
      onTap: () {
        final game = GameItem.mockGames.firstWhere(
          (g) => g.title.toLowerCase().contains(
            (item['title'] as String).toLowerCase().split(':')[0],
          ),
          orElse: () => GameItem.mockGames[0],
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GameDetailsScreen(game: game),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: palette.cardBg,
          borderRadius: BorderRadius.circular(14),
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
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: GameImage(
                    imageUrl: item['coverUrl'] as String,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: PlatformBadge(label: item['platformBadge'] as String),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: palette.cardBg.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if ((item['ratingBadge'] as String).contains('.')) ...[
                          Icon(
                            Icons.star_rounded,
                            color: palette.primary,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                        ],
                        Text(
                          item['ratingBadge'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: palette.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (item['hasDlc'] == true)
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: GameTagChip(
                      label: 'DLC Included',
                      hasDot: true,
                      backgroundColor: palette.cardBg.withValues(alpha: 0.95),
                      textColor: palette.onSurface,
                    ),
                  ),
              ],
            ),

            // Card Body
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['developer'] as String,
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: palette.secondary,
                            letterSpacing: 0.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item['title'] as String,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.2,
                            color: palette.onSurface,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: (item['tags'] as List<String>)
                              .map((t) => GameTagChip(label: t))
                              .toList(),
                        ),
                      ],
                    ),

                    // Price & Bookmark Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              item['price'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: (item['originalPrice'] != null)
                                    ? palette.primary
                                    : palette.onSurface,
                              ),
                            ),
                            if (item['originalPrice'] != null) ...[
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                item['originalPrice'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
                                  color: palette.secondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              item['isSaved'] = !isSaved;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  item['isSaved'] == true
                                      ? 'Added "${item['title']}" to wishlist'
                                      : 'Removed "${item['title']}" from wishlist',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isSaved
                                  ? palette.primaryFixed
                                  : palette.surfaceLow,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
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
                        ),
                      ],
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

  // --- Price Drop Alerts Card ---
  Widget _buildPriceDropAlertsCard(AppPalette palette) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: palette.cardBg,
          borderRadius: AppRadius.roundedCard,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: palette.primaryFixed,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.notifications_active_rounded,
                      color: palette.primary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Drop Alerts',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: palette.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      'Instant ping when wishlisted titles discount',
                      style: TextStyle(fontSize: 11, color: palette.secondary),
                    ),
                  ],
                ),
              ],
            ),
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: _priceDropAlertsEnabled,
                onChanged: (val) {
                  setState(() => _priceDropAlertsEnabled = val);
                },
                activeThumbColor: Colors.white,
                activeTrackColor: palette.primary,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: palette.isDark
                    ? const Color(0xFF282A36)
                    : const Color(0xFFE2E2E3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
