import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/skeleton_loader.dart';
import '../providers/home_providers.dart';

/// 最近阅读横滑书架
///
/// 水平滚动展示最近阅读过的诗词，支持空状态和加载骨架。
class RecentReadsShelf extends ConsumerWidget {
  const RecentReadsShelf({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final recentReadsAsync = ref.watch(recentReadsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '最近阅读'),
        const SizedBox(height: AppSpacing.sm),
        recentReadsAsync.when(
          data: (reads) {
            if (reads.isEmpty) {
              return _EmptyState(isDark: isDark);
            }
            return SizedBox(
              height: 96,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pageHorizontal,
                ),
                itemCount: reads.length,
                itemBuilder: (context, index) {
                  final record = reads[index];
                  final timeStr = _formatTime(record.readAt);

                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.buttonRadius),
                        onTap: () =>
                            context.go('/home/poem/${record.poemId}'),
                        child: Container(
                          width: 160,
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurfaceSecondary
                                : AppColors.surfaceSecondary,
                            borderRadius: BorderRadius.circular(
                                AppSpacing.buttonRadius),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                record.title,
                                style: AppTypography.bodyMedium(context)
                                    .copyWith(fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                record.authorName,
                                style: AppTypography.captionRegular(context)
                                    .copyWith(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppColors.darkInkTertiary
                                      : AppColors.inkTertiary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Text(
                                timeStr,
                                style:
                                    AppTypography.captionRegular(context).copyWith(
                                  fontSize: 10,
                                  color: isDark
                                      ? AppColors.darkInkTertiary
                                      : AppColors.inkTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => SizedBox(
            height: 96,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHorizontal,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: SkeletonLoader(
                    width: 160,
                    height: 88,
                    borderRadius: AppSpacing.buttonRadius,
                  ),
                );
              },
            ),
          ),
          error: (error, stack) => SizedBox(
            height: 40,
            child: Center(
              child: Text(
                '加载失败',
                style: AppTypography.captionRegular(context).copyWith(
                  color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 格式化阅读时间
String _formatTime(DateTime time) {
  final now = DateTime.now();
  final diff = now.difference(time);
  if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
  if (diff.inHours < 24) return '${diff.inHours}小时前';
  if (diff.inDays < 7) return '${diff.inDays}天前';
  return '${time.month}/${time.day}';
}

/// 空状态组件
class _EmptyState extends StatelessWidget {
  final bool isDark;

  const _EmptyState({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 22,
              color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '暂无阅读记录',
              style: AppTypography.captionRegular(context).copyWith(
                color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
