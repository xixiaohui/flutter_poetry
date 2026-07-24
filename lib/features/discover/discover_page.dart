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

/// 发现页 — UI 立即渲染，数据到达后自动替换
class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(discoverPageDataNotifierProvider);

    // state 为 null 说明还没加载过 → 触发加载
    if (data == null) {
      // scheduleMicrotask 确保 build 先完成再触发
      Future.microtask(() => ref.read(discoverPageDataNotifierProvider.notifier).load());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('发现')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(discoverPageDataNotifierProvider.notifier).load(),
        child: ListView(
          padding: const EdgeInsets.only(top: AppSpacing.md),
          children: [
            _sectionTitle(context, '诗词体裁'),
            const SizedBox(height: AppSpacing.sm),
            data == null ? _chipSkeletons(6) : _typeChips(context, data.types),

            const SizedBox(height: AppSpacing.lg),

            _sectionTitle(context, '朝代索引'),
            const SizedBox(height: AppSpacing.sm),
            data == null ? _chipSkeletons(4) : _dynastyChips(context, data.dynasties),

            const SizedBox(height: AppSpacing.lg),

            _sectionTitle(context, '近期诗词'),
            const SizedBox(height: AppSpacing.sm),
            data == null ? _poemSkeletons(3) : _poemList(context, data.recentPoems),

            const SizedBox(height: AppSpacing.xl2),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) => Padding(
    padding: AppSpacing.pagePadding,
    child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
  );

  Widget _chipSkeletons(int count) => Padding(
    padding: AppSpacing.pagePadding,
    child: Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm,
      children: List.generate(count, (_) => SizedBox(width: 80, height: 32,
          child: SkeletonLoader(width: 80, height: 32, borderRadius: 16)))),
  );

  Widget _poemSkeletons(int count) => Padding(
    padding: AppSpacing.pagePadding,
    child: Column(children: List.generate(count,
        (_) => const Padding(padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: SkeletonLoader(height: 80, borderRadius: 12)))),
  );

  Widget _typeChips(BuildContext context, List<CategoryItem> types) {
    if (types.isEmpty) return _emptyHint(context, '暂无体裁数据');
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm,
        children: types.map((t) => ActionChip(
          avatar: Icon(_typeIcon(t.name), size: 18), label: Text(t.name),
          onPressed: () => context.push('/discover/type/${Uri.encodeComponent(t.name)}'),
        )).toList()),
    );
  }

  Widget _dynastyChips(BuildContext context, List<CategoryItem> dynasties) {
    if (dynasties.isEmpty) return _emptyHint(context, '暂无朝代数据');
    return Padding(
      padding: AppSpacing.pagePadding,
      child: Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm,
        children: dynasties.map((d) => ActionChip(
          avatar: const Icon(Icons.menu_book, size: 18), label: Text(d.name),
          onPressed: () => context.push('/discover/dynasty/${Uri.encodeComponent(d.name)}'),
        )).toList()),
    );
  }

  Widget _poemList(BuildContext context, List<ApiPoem> poems) {
    if (poems.isEmpty) return _emptyHint(context, '暂无诗词数据');
    return Column(
      children: poems.take(5).map((p) => Padding(
        padding: AppSpacing.pagePadding.copyWith(bottom: AppSpacing.sm),
        child: PoetryCard(poem: _toPoem(p),
            onTap: () => context.push('/discover/poem/${p.id}')),
      )).toList(),
    );
  }

  Widget _emptyHint(BuildContext context, String text) => Padding(
    padding: AppSpacing.pagePadding,
    child: Text(text, style: AppTypography.captionRegular(context).copyWith(color: AppColors.inkTertiary)),
  );
}

Poem _toPoem(ApiPoem p) => Poem(
  id: p.id.toString(), title: p.title, content: p.content,
  author: AuthorBrief(id: '', name: p.author ?? '', dynasty: Dynasty(id: '', name: p.dynasty ?? '')),
  dynasty: Dynasty(id: '', name: p.dynasty ?? ''), category: PoemCategory.misc,
);

IconData _typeIcon(String name) {
  if (name.contains('绝句') || name.contains('律诗')) return Icons.straighten;
  if (name.contains('词')) return Icons.queue_music;
  if (name.contains('曲')) return Icons.theater_comedy;
  return Icons.auto_stories;
}
