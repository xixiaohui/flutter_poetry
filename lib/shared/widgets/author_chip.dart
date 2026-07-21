import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// 作者标签组件 — 可点击的作者名 + 可选副标题（朝代/字号）
class AuthorChip extends StatelessWidget {
  final String name;
  final String? subtitle;
  final VoidCallback? onTap;

  const AuthorChip({
    super.key,
    required this.name,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkSurfaceTertiary
                : AppColors.surfaceTertiary,
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          child: subtitle != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      style: AppTypography.bodyMedium(context).copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      subtitle!,
                      style: AppTypography.captionRegular(context).copyWith(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.darkInkTertiary
                            : AppColors.inkTertiary,
                      ),
                    ),
                  ],
                )
              : Text(
                  name,
                  style: AppTypography.bodyMedium(context).copyWith(
                    fontSize: 14,
                  ),
                ),
        ),
      ),
    );
  }
}
