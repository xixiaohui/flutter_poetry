import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/api_models.dart';

/// 当前节气横幅
///
/// 展示当前二十四节气名称、描述，使用竹青/青瓷色调。
/// 接收 [SolarTermData] 来自 real API，若为 null 则隐藏。
class SolarTermBanner extends StatelessWidget {
  final SolarTermData? data;

  const SolarTermBanner({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final term = data;
    if (term == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: AppSpacing.pagePadding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    AppColors.bamboo.withValues(alpha: 0.15),
                    AppColors.celadon.withValues(alpha: 0.1),
                  ]
                : [
                    AppColors.bamboo.withValues(alpha: 0.08),
                    AppColors.celadon.withValues(alpha: 0.06),
                  ],
          ),
          border: Border.all(
            color: isDark
                ? AppColors.bamboo.withValues(alpha: 0.2)
                : AppColors.bamboo.withValues(alpha: 0.15),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            // 左侧装饰线
            Container(
              width: 3,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.bamboo.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            // 正文区域
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '今日${term.termName}',
                    style: AppTypography.bodyLarge(context).copyWith(
                      color: isDark
                          ? AppColors.darkInkPrimary
                          : AppColors.inkPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    term.termDescription,
                    style: AppTypography.captionRegular(context).copyWith(
                      color: isDark
                          ? AppColors.darkInkSecondary
                          : AppColors.inkSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (term.reason.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      term.reason,
                      style: AppTypography.captionRegular(context).copyWith(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.darkInkTertiary
                            : AppColors.inkTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // 右侧装饰线
            Container(
              width: 3,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.celadon.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
