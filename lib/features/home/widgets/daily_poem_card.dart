import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/dynasty_badge.dart';
import '../../../shared/widgets/glass_container.dart';
import '../../../shared/widgets/skeleton_loader.dart';
import '../providers/home_providers.dart';

/// 每日推荐诗词卡片
///
/// 展示精选诗词的标题、前两行内容、作者与朝代。
/// 点击跳转到诗词详情页。
class DailyPoemCard extends ConsumerWidget {
  const DailyPoemCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dailyPoemAsync = ref.watch(dailyPoemProvider);

    return Padding(
      padding: AppSpacing.pagePadding,
      child: dailyPoemAsync.when(
        loading: () => const PoetryCardSkeleton(),
        error: (error, stack) => _ErrorState(
          error: error.toString(),
          onRetry: () => ref.invalidate(dailyPoemProvider),
        ),
        data: (poem) {
          // 取内容的前两行
          final lines = poem.content.split('\n');
          final previewLines = lines.take(2).join('\n');
          final displayContent = previewLines.length > 60
              ? '${previewLines.substring(0, 60)}…'
              : previewLines;

          final card = GlassContainer(
            borderRadius: 20,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题
                Text(
                  poem.title,
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
                    DynastyBadge(dynasty: poem.dynasty.name),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      poem.author.name,
                      style: AppTypography.captionRegular(context).copyWith(
                        color: isDark
                            ? AppColors.darkInkTertiary
                            : AppColors.inkTertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => context.go('/home/poem/${poem.id}'),
              child: Hero(
                tag: 'daily_poem',
                child: card,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// 错误状态 — 轻量错误提示 + 重试
class _ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              size: 18,
              color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                '加载失败，请重试',
                style: AppTypography.captionRegular(context).copyWith(
                  color: isDark
                      ? AppColors.darkInkTertiary
                      : AppColors.inkTertiary,
                ),
              ),
            ),
            GestureDetector(
              onTap: onRetry,
              child: Text(
                '重试',
                style: AppTypography.captionRegular(context).copyWith(
                  color: AppColors.accentPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
