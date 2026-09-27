import 'package:flutter/material.dart';

class AppColors {
  // Legacy / Default Dark Theme Palette
  static const Color canvasBase = Color(0xFF0A0C14);
  static const Color surface1 = Color(0xFF101321);
  static const Color surface2 = Color(0xFF171B30);
  static const Color surface3 = Color(0xFF1E233D);
  static const Color surfaceElevated = Color(0xFF282A32);

  static const Color borderStroke = Color(0xFF1F243D);
  static const Color borderHighlight = Color(0x1AFFFFFF);

  static const Color primary = Color(0xFFF4512C);
  static const Color primaryDark = Color(0xFFB12400);
  static const Color primaryLight = Color(0xFFFF7A59);
  static const Color primaryFixed = Color(0xFFFFF0EB);
  static const Color primaryGlow = Color(0x40F4512C);

  static const Color secondary = Color(0xFF38BDF8);
  static const Color secondaryDark = Color(0xFF2563EB);
  static const Color secondaryFixed = Color(0xFFC4E7FF);

  static const Color actionLike = Color(0xFF10B981);
  static const Color actionLikeGlow = Color(0x3810B981);
  static const Color actionPass = Color(0xFFEF4444);
  static const Color actionPassGlow = Color(0x33EF4444);
  static const Color actionBookmark = Color(0xFFF59E0B);
  static const Color actionBookmarkGlow = Color(0x38F59E0B);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textDisabled = Color(0xFF475569);

  static const Gradient primaryButtonGradient = LinearGradient(
    colors: [Color(0xFFF4512C), Color(0xFFB12400)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient cardOverlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0x990A0C14), Color(0xF00A0C14)],
    stops: [0.4, 0.75, 1.0],
  );

  // Dynamic Theme-Aware Palette Provider
  static AppPalette of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? AppPalette.dark : AppPalette.light;
  }
}

class AppPalette {
  final bool isDark;
  final Color bgSurface;
  final Color cardBg;
  final Color surfaceLow;
  final Color surfaceContainer;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color borderStroke;
  final Color onSurface;
  final Color secondary;
  final Color primary;
  final Color primaryDark;
  final Color primaryFixed;
  final Color navBg;

  const AppPalette({
    required this.isDark,
    required this.bgSurface,
    required this.cardBg,
    required this.surfaceLow,
    required this.surfaceContainer,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.borderStroke,
    required this.onSurface,
    required this.secondary,
    required this.primary,
    required this.primaryDark,
    required this.primaryFixed,
    required this.navBg,
  });

  static const AppPalette light = AppPalette(
    isDark: false,
    bgSurface: Color(0xFFF9F9FA),
    cardBg: Color(0xFFFFFFFF),
    surfaceLow: Color(0xFFF3F3F4),
    surfaceContainer: Color(0xFFEEEEEF),
    secondaryContainer: Color(0xFFEEDFDB),
    onSecondaryContainer: Color(0xFF6D625E),
    borderStroke: Color(0xFFE4E6E7),
    onSurface: Color(0xFF1A1C1D),
    secondary: Color(0xFF665C59),
    primary: Color(0xFFF4512C),
    primaryDark: Color(0xFFB12400),
    primaryFixed: Color(0xFFFFF0EB),
    navBg: Color(0xF2FFFFFF),
  );

  static const AppPalette dark = AppPalette(
    isDark: true,
    bgSurface: Color(0xFF0A0C14),
    cardBg: Color(0xFF171B30),
    surfaceLow: Color(0xFF101321),
    surfaceContainer: Color(0xFF1E233D),
    secondaryContainer: Color(0xFF262024),
    onSecondaryContainer: Color(0xFFE4BEB6),
    borderStroke: Color(0xFF1F243D),
    onSurface: Color(0xFFF8FAFC),
    secondary: Color(0xFF94A3B8),
    primary: Color(0xFFF4512C),
    primaryDark: Color(0xFFB12400),
    primaryFixed: Color(0x33F4512C),
    navBg: Color(0xE6101321),
  );
}
