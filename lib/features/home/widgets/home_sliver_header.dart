import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// 首页可折叠 Header — 国风印章式
///
/// 展开：红色 "诗" 印章 + "诗境" + 副标题
/// 收起：小印章 + "诗境"
class HomeSliverHeader extends StatelessWidget {
  const HomeSliverHeader({super.key});

  static const double _expandedHeight = 140;
  static const double _logoExpanded = 56;
  static const double _logoCollapsed = 28;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: _expandedHeight,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      backgroundColor: bg,
      shadowColor: Colors.transparent,
      scrolledUnderElevation: 0.5,

      // 收起状态标题
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 小印章
          Container(
            width: _logoCollapsed,
            height: _logoCollapsed,
            decoration: BoxDecoration(
              color: AppColors.accentPrimary,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: const Text(
              '诗',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text('诗境', style: AppTypography.bodyMedium(context)),
        ],
      ),

      // 展开状态区域
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          // constraints.maxHeight: _expandedHeight → 0 (collapsing)
          final t = ((constraints.maxHeight - kToolbarHeight - MediaQuery.of(context).padding.top) /
                  (_expandedHeight - kToolbarHeight - MediaQuery.of(context).padding.top))
              .clamp(0.0, 1.0);

          return Opacity(
            opacity: t,
            child: Container(
              color: bg,
              padding: EdgeInsets.only(
                left: AppSpacing.pageHorizontal,
                right: AppSpacing.pageHorizontal,
                bottom: kToolbarHeight - AppSpacing.md,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 红色印章 Logo
                      Container(
                        width: _logoExpanded,
                        height: _logoExpanded,
                        decoration: BoxDecoration(
                          color: AppColors.accentPrimary,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentPrimary.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '诗',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Noto Serif SC',
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      // 标题 + 副标题
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '诗境',
                            style: AppTypography.displayLarge(context).copyWith(
                              fontSize: 30,
                              letterSpacing: 4,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '品读千年诗词之美',
                            style: AppTypography.captionRegular(context).copyWith(
                              color: isDark
                                  ? AppColors.darkInkTertiary
                                  : AppColors.inkTertiary,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
