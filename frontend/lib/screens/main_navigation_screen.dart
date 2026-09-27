import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/navigation/gamescout_bottom_navigation.dart';
import 'discover_screen.dart';
import 'friends_screen.dart';
import 'profile_screen.dart';
import 'squad_matches_screen.dart';
import 'wishlist_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0; // Default to Discover screen

  final List<Widget> _screens = const [
    DiscoverScreen(),
    SquadMatchesScreen(),
    FriendsScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return Scaffold(
      backgroundColor: palette.bgSurface,
      body: Stack(
        children: [
          // Current Screen
          IndexedStack(index: _currentIndex, children: _screens),

          // Floating Glass Bottom Navigation Bar (5 tabs matching reference UI)
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: GameScoutBottomNavigation(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}
