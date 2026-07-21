import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/poetry_card.dart';
import '../../../shared/widgets/skeleton_loader.dart';
import '../providers/home_providers.dart';

/// 推荐诗词 SliverList — 由父级 [CustomScrollView] 驱动滚动
///
/// 使用 [homeRecommendationsProvider] 获取分页诗词列表。
/// 无限滚动由父级 [HomePage] 的 [ScrollController] 监听处理。
class RecommendationsGrid extends ConsumerWidget {
  const RecommendationsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationsAsync = ref.watch(homeRecommendationsProvider);

    return recommendationsAsync.when(
      loading: () => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.pageHorizontal,
          ),
          child: const ListSkeleton(itemCount: 3),
        ),
      ),
      error: (error, stack) => SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Text(
              '加载失败',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
      data: (poems) {
        final hasMore = poems.length >= 20;

        if (poems.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  '暂无推荐诗词',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index >= poems.length) {
                // 加载更多指示器
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Center(
                    child: SkeletonLoader(width: 120, height: 14),
                  ),
                );
              }

              final poem = poems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.pageHorizontal,
                  vertical: AppSpacing.xs,
                ),
                child: PoetryCard(
                  poem: poem,
                  heroTag: 'poem_${poem.id}',
                  onTap: () => context.go('/home/poem/${poem.id}'),
                ),
              );
            },
            childCount: poems.length + (hasMore ? 1 : 0),
          ),
        );
      },
    );
  }
}
