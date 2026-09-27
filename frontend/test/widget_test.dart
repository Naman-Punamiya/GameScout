import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_scout/main.dart';
import 'package:game_scout/theme/theme_controller.dart';
import 'package:game_scout/widgets/common/app_filter_chips.dart';
import 'package:game_scout/widgets/common/app_search_bar.dart';
import 'package:game_scout/widgets/common/app_section_header.dart';
import 'package:game_scout/widgets/common/gamescout_app_bar.dart';
import 'package:game_scout/widgets/common/user_avatar.dart';
import 'package:game_scout/widgets/game/game_action_bar.dart';
import 'package:game_scout/widgets/game/game_rating.dart';
import 'package:game_scout/widgets/game/game_tag_chip.dart';
import 'package:game_scout/widgets/game/platform_badge.dart';
import 'package:game_scout/widgets/game/recommendation_reason.dart';
import 'package:game_scout/widgets/navigation/gamescout_bottom_navigation.dart';
import 'package:game_scout/widgets/social/friend_card.dart';
import 'package:game_scout/widgets/social/peer_endorsement_bar.dart';
import 'package:game_scout/widgets/social/squad_match_card.dart';

void main() {
  testWidgets('GameScout smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const GameScoutApp());
    expect(find.text('Friends'), findsWidgets);
  });

  testWidgets('ThemeController switches themes dynamically', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GameScoutApp());

    ThemeController.instance.setThemeMode(ThemeMode.light);
    await tester.pumpAndSettle();
    expect(ThemeController.instance.themeMode, ThemeMode.light);

    ThemeController.instance.setThemeMode(ThemeMode.dark);
    await tester.pumpAndSettle();
    expect(ThemeController.instance.themeMode, ThemeMode.dark);

    ThemeController.instance.setThemeMode(ThemeMode.system);
    await tester.pumpAndSettle();
    expect(ThemeController.instance.themeMode, ThemeMode.system);
  });

  testWidgets('Common & Game Reusable Components render correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: GameScoutAppBar(title: 'Custom Title'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SectionHeader(title: 'HEADER TEST', countBadge: '(5)'),
                const AppSearchBar(hintText: 'Search games...'),
                FilterChipRow(
                  filters: const ['All', 'Action', 'RPG'],
                  selectedIndex: 0,
                  onSelected: (i) {},
                ),
                const UserAvatar(
                  initials: 'GS',
                  isOnline: true,
                  showOnlineIndicator: true,
                ),
                const PlatformBadge(label: 'PC • PS5'),
                const GameRating(rating: 4.8, ratingCount: 12000),
                const GameTagChip(label: 'Open World'),
                const RecommendationReason(
                  reason: 'Because you played The Witcher 3',
                ),
                GameActionBar(onPass: () {}, onNotSure: () {}, onLike: () {}),
                const PeerEndorsementBar(
                  title: 'Sarah liked this',
                  subtitle: 'Added to 1 collection',
                ),
                const FriendCard(
                  name: 'TestFriend',
                  gamesInCommon: 5,
                  isOnline: true,
                ),
                const SquadMatchCard(
                  title: 'Helldivers 2',
                  developer: 'Arrowhead',
                  releaseYear: '2024',
                ),
              ],
            ),
          ),
          bottomNavigationBar: GameScoutBottomNavigation(
            currentIndex: 0,
            onTap: (i) {},
          ),
        ),
      ),
    );

    expect(find.text('Custom Title'), findsOneWidget);
    expect(find.text('HEADER TEST'), findsOneWidget);
    expect(find.text('(5)'), findsOneWidget);
    expect(find.text('PC • PS5'), findsOneWidget);
    expect(find.text('Because you played The Witcher 3'), findsOneWidget);
    expect(find.text('Pass'), findsOneWidget);
    expect(find.text('Like'), findsOneWidget);
    expect(find.text('TestFriend'), findsOneWidget);
    expect(find.text('Helldivers 2'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
  });
}
