import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/api_models.dart';
import '../../data/models/author.dart';
import '../../data/models/dynasty.dart';
import '../../data/models/poem.dart';
import '../../shared/widgets/poetry_card.dart';
import '../../shared/widgets/skeleton_loader.dart';
import 'providers/discover_providers.dart';

/// 发现页 — 体裁分类、朝代索引、近期诗词
class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageData = ref.watch(discoverPageDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('发现')),
      body: pageData.when(
        loading: _buildLoading,
        error: (error, stack) => _buildError(context, error, ref),
        data: (data) => _buildContent(context, data),
      ),
    );
  }

  Widget _buildLoading() {
    return ListView(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      children: [
        // Section 1 skeleton: 体裁分类
        Padding(
          padding: AppSpacing.pagePadding,
          child: SkeletonLoader(width: 100, height: 20),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: AppSpacing.pagePadding,
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: List.generate(
              6,
              (_) => SizedBox(
                width: 80,
                height: 32,
                child: SkeletonLoader(
                  width: 80,
                  height: 32,
                  borderRadius: 16,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Section 2 skeleton: 朝代索引
        Padding(
          padding: AppSpacing.pagePadding,
          child: SkeletonLoader(width: 100, height: 20),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: AppSpacing.pagePadding,
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: List.generate(
              4,
              (_) => SizedBox(
                width: 60,
                height: 32,
                child: SkeletonLoader(
                  width: 60,
                  height: 32,
                  borderRadius: 16,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // Section 3 skeleton: 近期诗词
        Padding(
          padding: AppSpacing.pagePadding,
          child: SkeletonLoader(width: 100, height: 20),
        ),
        const SizedBox(height: AppSpacing.sm),
        const Padding(
          padding: AppSpacing.pagePadding,
          child: ListSkeleton(itemCount: 3),
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context, Object error, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: AppSpacing.md),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium(context).copyWith(
                color: AppColors.inkSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () => ref.invalidate(discoverPageDataProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DiscoverData data) {
    return ListView(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      children: [
        // ── Section 1: 体裁分类 ──
        Padding(
          padding: AppSpacing.pagePadding,
          child: Text(
            '诗词体裁',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: AppSpacing.pagePadding,
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: data.types.map((type) {
              return ActionChip(
                avatar: Icon(_typeIcon(type.name), size: 18),
                label: Text(type.name),
                onPressed: () => context.push(
                  '/discover/type/${Uri.encodeComponent(type.name)}',
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // ── Section 2: 朝代索引 ──
        Padding(
          padding: AppSpacing.pagePadding,
          child: Text(
            '朝代索引',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: AppSpacing.pagePadding,
          child: Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: data.dynasties.map((dynasty) {
              return ActionChip(
                avatar: const Icon(Icons.menu_book, size: 18),
                label: Text(dynasty.name),
                onPressed: () => context.push(
                  '/discover/dynasty/${Uri.encodeComponent(dynasty.name)}',
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: AppSpacing.lg),

        // ── Section 3: 近期诗词 ──
        Padding(
          padding: AppSpacing.pagePadding,
          child: Text(
            '近期诗词',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ...data.recentPoems.take(5).map(
              (poem) => Padding(
                padding: AppSpacing.pagePadding.copyWith(
                  bottom: AppSpacing.sm,
                ),
                child: PoetryCard(
                  poem: _toPoem(poem),
                  onTap: () => context.push('/discover/poem/${poem.id}', extra: poem),
                ),
              ),
            ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

/// Map ApiPoem (API flat structure) to Poem (UI model with nested objects).
Poem _toPoem(ApiPoem p) {
  return Poem(
    id: p.id.toString(),
    title: p.title,
    content: p.content,
    author: AuthorBrief(
      id: '',
      name: p.author ?? '',
      dynasty: Dynasty(id: '', name: p.dynasty ?? ''),
    ),
    dynasty: Dynasty(id: '', name: p.dynasty ?? ''),
    category: PoemCategory.misc,
  );
}

/// Pick an appropriate icon for a poetic form (体裁).
IconData _typeIcon(String name) {
  if (name.contains('绝句') || name.contains('律诗')) {
    return Icons.straighten;
  }
  if (name.contains('词')) {
    return Icons.queue_music;
  }
  if (name.contains('曲')) {
    return Icons.theater_comedy;
  }
  return Icons.auto_stories;
}
