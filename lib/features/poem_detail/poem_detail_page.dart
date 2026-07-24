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
import '../../data/repositories/poem_repository.dart';
import '../../shared/widgets/expandable_section.dart';
import '../../shared/widgets/skeleton_loader.dart';
import 'providers/poem_detail_providers.dart';
import 'widgets/poem_metadata_bar.dart';
import 'widgets/poem_content_view.dart';
import 'widgets/poem_action_bar.dart';
import 'widgets/ai_appreciation_section.dart';
import 'widgets/related_poems_section.dart';

/// 诗词详情页 — 核心阅读体验
///
/// [poemId] 为必传的诗词 ID，用于 API 加载详情。
/// [seed] 为可选的预加载数据——从列表页带入，API 失败时作为降级展示。
class PoemDetailPage extends ConsumerWidget {
  final String poemId;
  final dynamic seed;

  const PoemDetailPage({super.key, required this.poemId, this.seed});

  Poem? get _seedPoem {
    final s = seed;
    if (s == null) return null;
    if (s is Poem) return s;
    if (s is ApiPoem) {
      return Poem(
        id: s.id.toString(), title: s.title, content: s.content,
        author: AuthorBrief(id: '', name: s.author ?? '', dynasty: Dynasty(id: '', name: s.dynasty ?? '')),
        dynasty: Dynasty(id: '', name: s.dynasty ?? ''), category: PoemCategory.misc,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedPoem = _seedPoem;

    // 有 seed 直接展示，后台静默尝试 API
    if (seedPoem != null) {
      ref.watch(poemDetailProvider(poemId));
    }

    final detailAsync = ref.watch(poemDetailProvider(poemId));

    return detailAsync.when(
      loading: () {
        if (seedPoem != null) {
          _record(poem: seedPoem, ref: ref);
          return _DataView(poem: seedPoem);
        }
        return const _DetailSkeleton();
      },
      error: (error, _) {
        if (seedPoem != null) {
          _record(poem: seedPoem, ref: ref);
          return _DataView(poem: seedPoem);
        }
        return _ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(poemDetailProvider(poemId)),
        );
      },
      data: (poem) {
        _record(poem: poem, ref: ref);
        return _DataView(poem: poem);
      },
    );
  }

  void _record({required Poem poem, required WidgetRef ref}) {
    ref.read(poemRepositoryProvider).recordReading(poem);
    ref
        .read(poemRepositoryProvider)
        .recordServerReading(
          poemId: int.parse(poem.id),
          poemTitle: poem.title,
          poemAuthor: poem.author.name,
          poemDynasty: poem.dynasty.name,
        )
        .catchError((_) {});
  }
}

/// 数据视图 — Scaffold + SingleChildScrollView
class _DataView extends StatelessWidget {
  final dynamic poem;
  const _DataView({required this.poem});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkSurfacePrimary : AppColors.surfacePrimary;
    final ink = isDark ? AppColors.darkInkPrimary : AppColors.inkPrimary;
    final inkSec = isDark ? AppColors.darkInkSecondary : AppColors.inkSecondary;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: ink),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(poem.title,
            style: AppTypography.captionRegular(context).copyWith(color: inkSec)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.chat_outlined, size: 22, color: inkSec),
            tooltip: 'AI 问答',
            onPressed: () {
              context.pushNamed(
                'aiChat',
                extra: {'context': poem.content, 'title': poem.title},
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xl3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.md),
            PoemMetadataBar(poem: poem),
            const SizedBox(height: AppSpacing.lg),
            PoemContentView(content: poem.content),
            const SizedBox(height: AppSpacing.md),
            PoemActionBar(poem: poem),
            const SizedBox(height: AppSpacing.md),
            _SectionDivider(isDark: isDark),
            if (poem.translation != null)
              ExpandableSection(title: '译文', content: poem.translation!),
            if (poem.annotation != null)
              ExpandableSection(title: '注释', content: poem.annotation!),
            if (poem.appreciation != null)
              ExpandableSection(title: '赏析', content: poem.appreciation!),
            const SizedBox(height: AppSpacing.md),
            AiAppreciationSection(poemId: poem.id),
            const SizedBox(height: AppSpacing.md),
            RelatedPoemsSection(poemId: poem.id),
          ],
        ),
      ),
    );
  }
}

/// 详情页骨架屏
class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkSurfacePrimary : AppColors.surfacePrimary;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20,
              color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary),
          onPressed: null,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xl3),
        child: Column(children: [
          const SizedBox(height: AppSpacing.lg),
          _buildTitleSkeleton(),
          const SizedBox(height: AppSpacing.xl),
          _buildContentSkeleton(),
          const SizedBox(height: AppSpacing.xl),
          _buildActionsSkeleton(),
          const SizedBox(height: AppSpacing.lg),
          _SectionDivider(isDark: isDark),
          _buildAppreciationSkeleton(),
        ]),
      ),
    );
  }

  Widget _buildTitleSkeleton() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: AppSpacing.maxReadingWidth),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
        child: const Column(children: [
          SkeletonLoader(width: 200, height: 32, borderRadius: 8),
          SizedBox(height: AppSpacing.md),
          SkeletonLoader(width: 140, height: 18, borderRadius: 8),
        ]),
      ),
    );
  }

  Widget _buildContentSkeleton() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: AppSpacing.maxReadingWidth),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
        child: const Column(children: [
          SkeletonLoader(height: 16, borderRadius: 6),
          SizedBox(height: AppSpacing.md),
          SkeletonLoader(width: 280, height: 16, borderRadius: 6),
          SizedBox(height: AppSpacing.md),
          SkeletonLoader(height: 16, borderRadius: 6),
          SizedBox(height: AppSpacing.md),
          SkeletonLoader(width: 240, height: 16, borderRadius: 6),
        ]),
      ),
    );
  }

  Widget _buildActionsSkeleton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (_) => const SizedBox(
        width: 64,
        height: 44,
        child: SkeletonLoader(borderRadius: 12),
      )),
    );
  }

  Widget _buildAppreciationSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLoader(width: 100, height: 18, borderRadius: 6),
          SizedBox(height: AppSpacing.md),
          SkeletonLoader(height: 14, borderRadius: 6),
          SizedBox(height: AppSpacing.sm),
          SkeletonLoader(width: 200, height: 14, borderRadius: 6),
          SizedBox(height: AppSpacing.sm),
          SkeletonLoader(width: 160, height: 14, borderRadius: 6),
        ],
      ),
    );
  }
}

/// 错误视图
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkSurfacePrimary : AppColors.surfacePrimary;
    final ink = isDark ? AppColors.darkInkPrimary : AppColors.inkPrimary;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: ink),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.error_outline, size: 48,
                color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary),
            const SizedBox(height: AppSpacing.md),
            Text('加载失败', style: AppTypography.bodyMedium(context)),
            const SizedBox(height: AppSpacing.sm),
            Text(message,
                style: AppTypography.captionRegular(context).copyWith(
                    color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary),
                textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('重试'),
            ),
          ]),
        ),
      ),
    );
  }
}

/// 区域分割线
class _SectionDivider extends StatelessWidget {
  final bool isDark;
  const _SectionDivider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Divider(
        color: isDark ? AppColors.darkSurfaceTertiary : AppColors.surfaceTertiary,
        height: 1,
      ),
    );
  }
}
