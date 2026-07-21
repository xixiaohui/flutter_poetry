import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/skeleton_loader.dart';
import '../providers/poem_detail_providers.dart';

/// 控制 AI 赏析是否已触发 — 避免 build 时自动请求
final _analysisTriggeredProvider =
    StateProvider.family<bool, String>((ref, poemId) => false);

/// AI 赏析区域 — 懒触发 + 骨架加载 + 淡入结果
class AiAppreciationSection extends ConsumerWidget {
  final String poemId;

  const AiAppreciationSection({super.key, required this.poemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final triggered = ref.watch(_analysisTriggeredProvider(poemId));

    if (!triggered) {
      return _AiInitialView(poemId: poemId);
    }
    return _AiResultView(poemId: poemId);
  }
}

/// 初始状态 — 「生成 AI 赏析」按钮
class _AiInitialView extends ConsumerWidget {
  final String poemId;
  const _AiInitialView({required this.poemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context, isDark),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: TextButton.icon(
            onPressed: () {
              ref
                  .read(_analysisTriggeredProvider(poemId).notifier)
                  .state = true;
              ref.invalidate(aiAppreciationProvider(poemId));
            },
            icon: const Icon(Icons.auto_awesome, size: 18),
            label: const Text('生成 AI 赏析'),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

/// 结果状态 — 加载/内容/错误
class _AiResultView extends ConsumerWidget {
  final String poemId;
  const _AiResultView({required this.poemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appreciationAsync = ref.watch(aiAppreciationProvider(poemId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(context, isDark),
        const SizedBox(height: AppSpacing.sm),
        appreciationAsync.when(
          loading: () => _buildLoading(isDark),
          data: (text) => _buildContent(context, text, isDark),
          error: (error, _) => _buildError(
            context,
            ref,
            poemId,
            isDark,
            error.toString(),
          ),
        ),
      ],
    );
  }
}

// ── Shared helpers ──

Widget _buildHeader(BuildContext context, bool isDark) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    child: Row(
      children: [
        Icon(
          Icons.auto_awesome,
          size: 18,
          color: isDark ? AppColors.darkInkSecondary : AppColors.accentPrimary,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'AI 赏析',
          style: AppTypography.bodyMedium(context),
        ),
      ],
    ),
  );
}

Widget _buildLoading(bool isDark) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SkeletonLoader(width: 280, height: 14),
          SizedBox(height: AppSpacing.md),
          SkeletonLoader(width: 320, height: 14),
          SizedBox(height: AppSpacing.md),
          SkeletonLoader(width: 200, height: 14),
        ],
      ),
    ),
  );
}

Widget _buildContent(BuildContext context, String text, bool isDark) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeIn,
        builder: (context, opacity, child) {
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: Text(
          text,
          style: AppTypography.captionRegular(context).copyWith(
            height: 1.8,
            color: isDark ? AppColors.darkInkPrimary : AppColors.inkPrimary,
          ),
        ),
      ),
    ),
  );
}

Widget _buildError(
  BuildContext context,
  WidgetRef ref,
  String poemId,
  bool isDark,
  String message,
) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '赏析生成失败',
            style: AppTypography.captionRegular(context),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            message,
            style: AppTypography.captionRegular(context).copyWith(
              fontSize: 12,
              color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: () {
              ref.invalidate(aiAppreciationProvider(poemId));
            },
            child: const Text('重试'),
          ),
        ],
      ),
    ),
  );
}
