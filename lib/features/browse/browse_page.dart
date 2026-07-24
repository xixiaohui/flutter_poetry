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
import 'providers/browse_providers.dart';

/// 浏览页 — 按朝代/体裁分页展示诗词列表
class BrowsePage extends ConsumerStatefulWidget {
  final String? dynasty;
  final String? type;
  final String? title;

  const BrowsePage({
    super.key,
    this.dynasty,
    this.type,
    this.title,
  });

  @override
  ConsumerState<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends ConsumerState<BrowsePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref
          .read(browsePoemsProvider(
        dynasty: widget.dynasty,
        type: widget.type,
      ).notifier)
          .loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final poemsAsync = ref.watch(browsePoemsProvider(
      dynasty: widget.dynasty,
      type: widget.type,
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? widget.dynasty ?? widget.type ?? '浏览',
        ),
      ),
      body: poemsAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.only(top: AppSpacing.md),
          child: ListSkeleton(),
        ),
        error: (error, _) => _buildError(error),
        data: (poems) => RefreshIndicator(
          onRefresh: () => ref.refresh(
            browsePoemsProvider(
              dynasty: widget.dynasty,
              type: widget.type,
            ).future,
          ),
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(top: AppSpacing.md),
            itemCount: poems.length,
            itemBuilder: (context, index) {
              final poem = poems[index];
              return Padding(
                padding: AppSpacing.pagePadding.copyWith(
                  bottom: AppSpacing.sm,
                ),
                child: PoetryCard(
                  poem: _toPoem(poem),
                  onTap: () => context.push('/discover/poem/${poem.id}', extra: poem),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildError(Object error) {
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
              onPressed: () => ref.invalidate(browsePoemsProvider(
                dynasty: widget.dynasty,
                type: widget.type,
              )),
              icon: const Icon(Icons.refresh),
              label: const Text('重试'),
            ),
          ],
        ),
      ),
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
