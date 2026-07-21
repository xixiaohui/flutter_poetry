import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/router/routes.dart';
import '../../../shared/widgets/poetry_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/skeleton_loader.dart';
import '../providers/poem_detail_providers.dart';

/// 相关诗词推荐区域
class RelatedPoemsSection extends ConsumerWidget {
  final String poemId;

  const RelatedPoemsSection({super.key, required this.poemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relatedAsync = ref.watch(relatedPoemsProvider(poemId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SectionHeader(title: '相关推荐'),
        relatedAsync.when(
          loading: () => const _LoadingList(),
          error: (_, __) => const SizedBox.shrink(),
          data: (poems) {
            if (poems.isEmpty) {
              return _buildEmpty(context, isDark);
            }
            return _buildList(context, poems);
          },
        ),
      ],
    );
  }

  Widget _buildEmpty(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      child: Center(
        child: Text(
          '暂无相关诗词',
          style: AppTypography.captionRegular(context).copyWith(
            color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List poems) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      itemCount: poems.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final poem = poems[index];
        return PoetryCard(
          poem: poem,
          heroTag: 'poem_${poem.id}',
          onTap: () {
            // Navigate to poem detail via root navigator
            Navigator.of(context, rootNavigator: true).pushNamed(
              AppRoutes.poemDetail.replaceAll(':id', poem.id),
            );
          },
        );
      },
    );
  }
}

/// 相关推荐加载骨架
class _LoadingList extends StatelessWidget {
  const _LoadingList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        children: List.generate(
          3,
          (_) => const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: PoetryCardSkeleton(),
          ),
        ),
      ),
    );
  }
}
