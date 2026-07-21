import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

/// 首页可折叠大标题 SliverAppBar
///
/// 展开时显示大字标题和副标题；收起时只显示标题文字。
class HomeSliverHeader extends StatelessWidget {
  const HomeSliverHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 120,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shadowColor: Colors.transparent,
      title: Text(
        '诗词',
        style: AppTypography.bodyMedium(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: EdgeInsets.zero,
        background: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 40,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '诗词',
                style: AppTypography.displayLarge(context).copyWith(
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '每日一诗，品味经典',
                style: AppTypography.captionRegular(context).copyWith(
                  color: isDark
                      ? AppColors.darkInkTertiary
                      : AppColors.inkTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
