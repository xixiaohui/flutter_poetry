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

/// 发现页 — 先渲染 UI 骨架，后台静默加载数据
class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(discoverPageDataNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('发现')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(discoverPageDataNotifierProvider.notifier).refresh(),
        child: ListView(
          padding: const EdgeInsets.only(top: AppSpacing.md),
          children: [
            // ── 体裁分类 ──
            _sectionTitle(context, '诗词体裁'),
            const SizedBox(height: AppSpacing.sm),
            data == null ? _chipSkeletons(6) : _typeChips(context, data.types),

            const SizedBox(height: AppSpacing.lg),

            // ── 朝代索引 ──
            _sectionTitle(context, '朝代索引'),
            const SizedBox(height: AppSpacing.sm),
            data == null ? _chipSkeletons(4) : _dynastyChips(context, data.dynasties),

            const SizedBox(height: AppSpacing.lg),

            // ── 近期诗词 ──
            _sectionTitle(context, '近期诗词'),
            const SizedBox(height: AppSpacing.sm),
            data == null ? _poemSkeletons(3) : _poemList(context, data.recentPoems),

            const SizedBox(height: AppSpacing.xl2),
          ],
        ),
      ),
    );
  }

  // ── Section title ──

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  // ── Skeletons (shown immediately while loading) ──

  Widget _chipSkeletons(int count) {
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: List.generate(
          count,
          (_) => SizedBox(
            width: 80, height: 32,
            child: SkeletonLoader(width: 80, height: 32, borderRadius: 16),
          ),
        ),
      ),
    );
  }

  Widget _poemSkeletons(int count) {
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        children: List.generate(
          count,
          (_) => const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: SkeletonLoader(height: 80, borderRadius: 12),
          ),
        ),
      ),
    );
  }

  // ── Content (shown after data loads) ──

  Widget _typeChips(BuildContext context, List<CategoryItem> types) {
    if (types.isEmpty) {
      return Padding(
        padding: AppSpacing.pagePadding,
        child: Text('暂无体裁数据',
            style: AppTypography.captionRegular(context)
                .copyWith(color: AppColors.inkTertiary)),
      );
    }
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: types.map((type) {
          return ActionChip(
            avatar: Icon(_typeIcon(type.name), size: 18),
            label: Text(type.name),
            onPressed: () => context.push(
              '/discover/type/${Uri.encodeComponent(type.name)}',
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _dynastyChips(BuildContext context, List<CategoryItem> dynasties) {
    if (dynasties.isEmpty) {
      return Padding(
        padding: AppSpacing.pagePadding,
        child: Text('暂无朝代数据',
            style: AppTypography.captionRegular(context)
                .copyWith(color: AppColors.inkTertiary)),
      );
    }
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: dynasties.map((dynasty) {
          return ActionChip(
            avatar: const Icon(Icons.menu_book, size: 18),
            label: Text(dynasty.name),
            onPressed: () => context.push(
              '/discover/dynasty/${Uri.encodeComponent(dynasty.name)}',
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _poemList(BuildContext context, List<ApiPoem> poems) {
    if (poems.isEmpty) {
      return Padding(
        padding: AppSpacing.pagePadding,
        child: Text('暂无诗词数据',
            style: AppTypography.captionRegular(context)
                .copyWith(color: AppColors.inkTertiary)),
      );
    }
    return Column(
      children: poems
          .take(5)
          .map((poem) => Padding(
                padding: AppSpacing.pagePadding
                    .copyWith(bottom: AppSpacing.sm),
                child: PoetryCard(
                  poem: _toPoem(poem),
                  onTap: () => context.push(
                      '/discover/poem/${poem.id}', extra: poem),
                ),
              ))
          .toList(),
    );
  }
}

// ── Helpers ──

Poem _toPoem(ApiPoem p) {
  return Poem(
    id: p.id.toString(),
    title: p.title,
    content: p.content,
    author: AuthorBrief(
        id: '', name: p.author ?? '', dynasty: Dynasty(id: '', name: p.dynasty ?? '')),
    dynasty: Dynasty(id: '', name: p.dynasty ?? ''),
    category: PoemCategory.misc,
  );
}

IconData _typeIcon(String name) {
  if (name.contains('绝句') || name.contains('律诗')) return Icons.straighten;
  if (name.contains('词')) return Icons.queue_music;
  if (name.contains('曲')) return Icons.theater_comedy;
  return Icons.auto_stories;
}
