import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// 诗词正文展示 — 居中排版 + 传统竖线装饰
class PoemContentView extends StatelessWidget {
  final String content;

  const PoemContentView({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = (isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary)
        .withValues(alpha: 0.15);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppSpacing.maxReadingWidth,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 左侧竖线装饰
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: VerticalDivider(
                  color: dividerColor,
                  thickness: 1,
                  width: AppSpacing.xl,
                ),
              ),

              // 正文
              Expanded(
                child: Padding(
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
              ),

              // 右侧竖线装饰
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: VerticalDivider(
                  color: dividerColor,
                  thickness: 1,
                  width: AppSpacing.xl,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
