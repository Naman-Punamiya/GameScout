import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final Widget? trailing;

  const AppSearchBar({
    super.key,
    this.controller,
    this.hintText = 'Search by gamer tag, Steam ID...',
    this.onChanged,
    this.onClear,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    Widget searchField = Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: palette.cardBg,
        borderRadius: AppRadius.roundedLg,
        border: Border.all(color: palette.borderStroke),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: palette.secondary, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 13,
                color: palette.onSurface,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 12.5,
                  color: palette.secondary.withValues(alpha: 0.75),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (controller != null && controller!.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                controller?.clear();
                onClear?.call();
              },
              child: Icon(
                Icons.close_rounded,
                size: 16,
                color: palette.secondary,
              ),
            ),
        ],
      ),
    );

    if (trailing == null) {
      return searchField;
    }

    return Row(
      children: [
        Expanded(child: searchField),
        const SizedBox(width: AppSpacing.sm),
        trailing!,
      ],
    );
  }
}
