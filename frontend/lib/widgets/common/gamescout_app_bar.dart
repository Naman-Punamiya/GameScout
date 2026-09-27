import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

class GameScoutAppBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final VoidCallback? onProfileTap;

  const GameScoutAppBar({
    super.key,
    this.title = 'GameScout',
    this.showBackButton = false,
    this.onBack,
    this.actions,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: palette.cardBg.withValues(alpha: 0.95),
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
          // Left Title & Logo / Back Button
          Row(
            children: [
              if (showBackButton) ...[
                IconButton(
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: palette.onSurface,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              Container(
                width: showBackButton ? 26 : 32,
                height: showBackButton ? 26 : 32,
                decoration: BoxDecoration(
                  color: palette.primaryFixed,
                  borderRadius: showBackButton
                      ? AppRadius.roundedSm
                      : AppRadius.roundedMd,
                ),
                child: Center(
                  child: Icon(
                    Icons.local_fire_department_rounded,
                    color: palette.primary,
                    size: showBackButton ? 16 : 20,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm + 2),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: showBackButton ? 17 : 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                  color: palette.onSurface,
                ),
              ),
            ],
          ),

          // Right Actions
          Row(
            children:
                actions ??
                [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_rounded,
                      size: 22,
                      color: palette.secondary,
                    ),
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      size: 22,
                      color: palette.secondary,
                    ),
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  GestureDetector(
                    onTap: onProfileTap,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: palette.primaryDark,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
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
