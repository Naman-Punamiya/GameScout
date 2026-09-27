import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/theme_controller.dart';
import '../widgets/compatibility_chip.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);
    final currentThemeMode = ThemeController.instance.themeMode;

    return Scaffold(
      backgroundColor: palette.bgSurface,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar / Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'GAMER PROFILE',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                      color: palette.onSurface,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: palette.cardBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: palette.borderStroke),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.settings_rounded,
                      size: 20,
                      color: palette.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Profile Overview Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: palette.cardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: palette.borderStroke),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.network(
                            'https://images.unsplash.com/photo-1566492031773-4f4e44671857?auto=format&fit=crop&w=200&q=80',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: palette.primaryFixed,
                                  child: Icon(
                                    Icons.person,
                                    color: palette.primary,
                                    size: 32,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alex Mercer',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: palette.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '@alex_prime',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: palette.primary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const CompatibilityChip(
                                label: 'Level 42 • Scout Vanguard',
                                variant: ChipVariant.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Stats Row
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: palette.surfaceLow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('LIKED', '124', palette),
                          Container(
                            width: 1,
                            height: 24,
                            color: palette.borderStroke,
                          ),
                          _buildStatItem('MATCHES', '38', palette),
                          Container(
                            width: 1,
                            height: 24,
                            color: palette.borderStroke,
                          ),
                          _buildStatItem('SQUAD', '12', palette),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Appearance & Theme Selector Card
              Text(
                'APPEARANCE & THEME',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: palette.secondary,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: palette.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: palette.borderStroke),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: palette.primaryFixed,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            currentThemeMode == ThemeMode.light
                                ? Icons.wb_sunny_rounded
                                : currentThemeMode == ThemeMode.dark
                                ? Icons.nightlight_round
                                : Icons.brightness_auto_rounded,
                            color: palette.primary,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Color Mode',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: palette.onSurface,
                              ),
                            ),
                            Text(
                              currentThemeMode == ThemeMode.system
                                  ? 'System default'
                                  : currentThemeMode == ThemeMode.light
                                  ? 'Light theme'
                                  : 'Dark theme',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: palette.secondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // 3 Theme Mode Option Chips
                    Row(
                      children: [
                        _buildThemeOption(
                          context: context,
                          label: 'Light',
                          icon: Icons.wb_sunny_rounded,
                          mode: ThemeMode.light,
                          isSelected: currentThemeMode == ThemeMode.light,
                          palette: palette,
                        ),
                        const SizedBox(width: 8),
                        _buildThemeOption(
                          context: context,
                          label: 'Dark',
                          icon: Icons.nightlight_round,
                          mode: ThemeMode.dark,
                          isSelected: currentThemeMode == ThemeMode.dark,
                          palette: palette,
                        ),
                        const SizedBox(width: 8),
                        _buildThemeOption(
                          context: context,
                          label: 'System',
                          icon: Icons.brightness_auto_rounded,
                          mode: ThemeMode.system,
                          isSelected: currentThemeMode == ThemeMode.system,
                          palette: palette,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Connected Platforms
              Text(
                'CONNECTED PLATFORMS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: palette.secondary,
                ),
              ),
              const SizedBox(height: 10),
              _buildConnectedPlatformRow(
                'Steam',
                'alex_steam_id',
                Icons.sports_esports_rounded,
                true,
                palette,
              ),
              _buildConnectedPlatformRow(
                'PlayStation Network',
                'AlexMercerPSN',
                Icons.gamepad_rounded,
                true,
                palette,
              ),
              _buildConnectedPlatformRow(
                'Xbox Live',
                'Not Connected',
                Icons.videogame_asset_rounded,
                false,
                palette,
              ),
              _buildConnectedPlatformRow(
                'Discord',
                'alex#0001',
                Icons.chat_rounded,
                true,
                palette,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required String label,
    required IconData icon,
    required ThemeMode mode,
    required bool isSelected,
    required AppPalette palette,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ThemeController.instance.setThemeMode(mode);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Switched theme to $label mode'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? palette.primaryFixed : palette.surfaceLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? palette.primary : palette.borderStroke,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? palette.primary : palette.secondary,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? palette.primary : palette.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, AppPalette palette) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: palette.onSurface,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: palette.secondary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildConnectedPlatformRow(
    String name,
    String handle,
    IconData icon,
    bool isConnected,
    AppPalette palette,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: palette.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: palette.borderStroke),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: isConnected ? const Color(0xFF38BDF8) : palette.secondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: palette.onSurface,
                  ),
                ),
                Text(
                  handle,
                  style: TextStyle(fontSize: 11.5, color: palette.secondary),
                ),
              ],
            ),
          ),
          Text(
            isConnected ? 'SYNCED' : 'LINK',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isConnected ? const Color(0xFF10B981) : palette.primary,
            ),
          ),
        ],
      ),
    );
  }
}
