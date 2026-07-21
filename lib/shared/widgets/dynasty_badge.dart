import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// 朝代徽章组件 — 小型朝代标签
class DynastyBadge extends StatelessWidget {
  final String dynasty;
  final double fontSize;

  const DynastyBadge({
    super.key,
    required this.dynasty,
    this.fontSize = 11,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
      ),
      child: Text(
        dynasty,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: isDark ? AppColors.darkInkSecondary : AppColors.accentPrimary,
        ),
      ),
    );
  }
}
