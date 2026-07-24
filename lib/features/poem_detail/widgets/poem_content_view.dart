import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// 诗词正文展示 — 居中排版 + 传统竖线装饰
///
/// 使用 Container border 代替 IntrinsicHeight+Row+VerticalDivider
/// 避免长文本时 IntrinsicHeight 的布局截断问题。
class PoemContentView extends StatelessWidget {
  final String content;

  const PoemContentView({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = (isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary)
        .withValues(alpha: 0.15);

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: AppSpacing.maxReadingWidth),
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: borderColor, width: 1),
            right: BorderSide(color: borderColor, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xl,
          horizontal: AppSpacing.md,
        ),
        child: SelectableText(
          content,
          style: AppTypography.displayMedium(context).copyWith(
            height: 2.0,
            letterSpacing: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
