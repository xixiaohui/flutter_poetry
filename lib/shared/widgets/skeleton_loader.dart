import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// 骨架屏加载组件 — 替代 CircularProgressIndicator
/// 遵循设计规范：禁止使用默认 CircularProgressIndicator
class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceTertiary,
      highlightColor: isDark
          ? AppColors.darkSurfaceTertiary
          : AppColors.surfacePrimary,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// 诗词卡片骨架屏
class PoetryCardSkeleton extends StatelessWidget {
  const PoetryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonLoader(width: 120, height: 20),
            const SizedBox(height: AppSpacing.md),
            const SkeletonLoader(height: 14),
            const SizedBox(height: AppSpacing.sm),
            const SkeletonLoader(height: 14),
            const SizedBox(height: AppSpacing.sm),
            const SkeletonLoader(width: 200, height: 14),
            const SizedBox(height: AppSpacing.md),
            const SkeletonLoader(width: 80, height: 12),
          ],
        ),
      ),
    );
  }
}

/// 列表骨架屏 — N 个卡片骨架
class ListSkeleton extends StatelessWidget {
  final int itemCount;
  const ListSkeleton({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (_) => const Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.sm),
          child: PoetryCardSkeleton(),
        ),
      ),
    );
  }
}
