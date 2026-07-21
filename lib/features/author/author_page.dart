import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/widgets/skeleton_loader.dart';
import 'providers/author_providers.dart';
import 'widgets/author_biography.dart';
import 'widgets/author_birthplace_map.dart';
import 'widgets/author_header.dart';
import 'widgets/author_masterpieces.dart';
import 'widgets/author_timeline.dart';

/// 作者详情页 — parallax 头部 + 生平 + 代表作 + 年代 + 故里
class AuthorPage extends ConsumerWidget {
  final String authorId;

  const AuthorPage({super.key, required this.authorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAuthor = ref.watch(authorDetailProvider(authorId));

    return asyncAuthor.when(
      loading: () => const _AuthorSkeleton(),
      error: (error, _) => _AuthorErrorView(
        message: error.toString(),
        onRetry: () => ref.invalidate(authorDetailProvider(authorId)),
      ),
      data: (author) => Scaffold(
        body: CustomScrollView(
          slivers: [
            // 1. 视差头部
            AuthorHeader(author: author),

            // 2. 生平简介
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.lg),
                child: AuthorBiography(biography: author.biography),
              ),
            ),

            // 3. 代表作品
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xl),
                child: AuthorMasterpieces(authorId: authorId),
              ),
            ),

            // 4. 年代时间轴
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xl),
                child: AuthorTimeline(dynasty: author.dynasty),
              ),
            ),

            // 5. 故里
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xl),
                child: AuthorBirthplaceMap(birthplace: author.birthplace),
              ),
            ),

            // 底部留白
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.xl3),
            ),
          ],
        ),
      ),
    );
  }
}

/// 错误状态 — 居中错误信息 + 重试按钮
class _AuthorErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _AuthorErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline,
                  size: 48, color: AppColors.error),
              const SizedBox(height: AppSpacing.md),
              Text('加载失败', style: AppTypography.bodyLarge(context)),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                style: AppTypography.captionRegular(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 页面加载骨架屏
class _AuthorSkeleton extends StatelessWidget {
  const _AuthorSkeleton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 头部骨架
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: AppColors.surfaceSecondary),
            ),
          ),

          // 生平骨架
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.lg,
                left: AppSpacing.pageHorizontal,
                right: AppSpacing.pageHorizontal,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(width: 80, height: 20),
                  SizedBox(height: AppSpacing.md),
                  SkeletonLoader(height: 14),
                  SizedBox(height: AppSpacing.sm),
                  SkeletonLoader(height: 14),
                  SizedBox(height: AppSpacing.sm),
                  SkeletonLoader(width: 200, height: 14),
                ],
              ),
            ),
          ),

          // 代表作骨架
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.xl,
                left: AppSpacing.pageHorizontal,
                right: AppSpacing.pageHorizontal,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(width: 100, height: 20),
                  SizedBox(height: AppSpacing.md),
                  PoetryCardSkeleton(),
                  PoetryCardSkeleton(),
                  PoetryCardSkeleton(),
                ],
              ),
            ),
          ),

          // 年代骨架
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.xl,
                left: AppSpacing.pageHorizontal,
                right: AppSpacing.pageHorizontal,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(width: 60, height: 20),
                  SizedBox(height: AppSpacing.md),
                  SkeletonLoader(height: 40),
                ],
              ),
            ),
          ),

          // 故里骨架
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.xl,
                left: AppSpacing.pageHorizontal,
                right: AppSpacing.pageHorizontal,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(width: 60, height: 20),
                  SizedBox(height: AppSpacing.md),
                  SkeletonLoader(width: 120, height: 20),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: AppSpacing.xl3),
          ),
        ],
      ),
    );
  }
}
