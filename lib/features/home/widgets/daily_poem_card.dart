import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/api_models.dart';
import '../../../shared/widgets/dynasty_badge.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/skeleton_loader.dart';

/// 每日推荐诗词卡片
///
/// 展示精选诗词的标题、前两行内容、作者与朝代。
/// 点击跳转到诗词详情页。
/// 接收 [ApiPoem] 参数来自 real API；若为 null 则显示骨架屏。
class DailyPoemCard extends StatelessWidget {
  final ApiPoem? poem;

  const DailyPoemCard({super.key, this.poem});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: AppSpacing.pagePadding,
      child: _buildContent(context, isDark),
    );
  }

  Widget _buildContent(BuildContext context, bool isDark) {
    final p = poem;
    if (p == null) {
      return const PoetryCardSkeleton();
    }

    // 取内容的前两行
    final lines = p.content.split('\n');
    final previewLines = lines.take(2).join('\n');
    final displayContent = previewLines.length > 60
        ? '${previewLines.substring(0, 60)}...'
        : previewLines;

    final card = GlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Text(
            p.title,
            style: AppTypography.displayMedium(context),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),

          // 内容预览
          Text(
            displayContent,
            style: AppTypography.bodyLarge(context).copyWith(
              color: isDark
                  ? AppColors.darkInkSecondary
                  : AppColors.inkSecondary,
              height: 1.6,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm),

          // 作者 + 朝代
          Row(
            children: [
              if (p.dynasty != null && p.dynasty!.isNotEmpty)
                DynastyBadge(dynasty: p.dynasty!),
              if (p.author != null && p.author!.isNotEmpty) ...[
                const SizedBox(width: AppSpacing.sm),
                Text(
                  p.author!,
                  style: AppTypography.captionRegular(context).copyWith(
                    color: isDark
                        ? AppColors.darkInkTertiary
                        : AppColors.inkTertiary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.go('/home/poem/${p.id}'),
        child: Hero(
          tag: 'daily_poem',
          child: card,
        ),
      ),
    );
  }
}
