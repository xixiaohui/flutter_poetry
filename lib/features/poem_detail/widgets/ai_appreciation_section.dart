import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/api_models.dart';
import '../../../shared/widgets/skeleton_loader.dart';
import '../providers/poem_detail_providers.dart';

/// 控制 AI 赏析是否已触发 — 避免 build 时自动请求
final _analysisTriggeredProvider =
    StateProvider.family<bool, String>((ref, poemId) => false);

/// 情感颜色映射 — 不同情感使用不同色调
const _emotionColors = [
  Color(0xFFE53935), // 热烈 (红)
  Color(0xFFFF7043), // 激昂 (橙)
  Color(0xFFFFA726), // 温暖 (暖橙)
  Color(0xFF66BB6A), // 平和 (绿)
  Color(0xFF26A69A), // 淡雅 (青)
  Color(0xFF42A5F5), // 忧伤 (蓝)
  Color(0xFFAB47BC), // 深沉 (紫)
  Color(0xFF8D6E63), // 怀旧 (棕)
];

/// AI 赏析区域 — 懒触发 + 骨架加载 + 结构化展示
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

/// 结果状态 — 加载 / 结构化内容 / 错误
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
          data: (data) => _buildStructuredContent(context, data, isDark),
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

// ── Structured content display ──

Widget _buildStructuredContent(BuildContext context, AIAnalysisData data, bool isDark) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 600),
    curve: Curves.easeIn,
    builder: (context, opacity, child) {
      return Opacity(opacity: opacity, child: child);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Background
        if (data.background.isNotEmpty) ...[
          _buildSectionCard(context, '创作背景', data.background, isDark, Icons.history_edu_outlined),
          const SizedBox(height: AppSpacing.md),
        ],

        // Appreciation
        if (data.appreciation.isNotEmpty) ...[
          _buildSectionCard(context, '赏析', data.appreciation, isDark, Icons.auto_awesome),
          const SizedBox(height: AppSpacing.md),
        ],

        // Keywords as Wrap chips
        if (data.keywords.isNotEmpty) ...[
          _buildChipSection(
            context,
            '关键词',
            data.keywords,
            isDark,
            (keyword, i) {
              final chipColor = AppColors.accentPrimary.withValues(alpha: 0.10);
              return Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                backgroundColor: isDark
                    ? AppColors.accentPrimary.withValues(alpha: 0.15)
                    : chipColor,
                side: BorderSide(
                  color: isDark
                      ? AppColors.accentPrimary.withValues(alpha: 0.3)
                      : AppColors.accentPrimary.withValues(alpha: 0.2),
                ),
                label: Text(
                  keyword,
                  style: AppTypography.captionRegular(context).copyWith(
                    color: isDark ? AppColors.darkInkPrimary : AppColors.accentPrimary,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Emotions as Wrap chips with emotion-themed colors
        if (data.emotions.isNotEmpty) ...[
          _buildChipSection(
            context,
            '情感',
            data.emotions,
            isDark,
            (emotion, i) {
              final baseColor = _emotionColors[i % _emotionColors.length];
              return Chip(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                backgroundColor: isDark
                    ? baseColor.withValues(alpha: 0.15)
                    : baseColor.withValues(alpha: 0.10),
                side: BorderSide(
                  color: isDark
                      ? baseColor.withValues(alpha: 0.3)
                      : baseColor.withValues(alpha: 0.2),
                ),
                label: Text(
                  emotion,
                  style: AppTypography.captionRegular(context).copyWith(
                    color: isDark ? baseColor.withValues(alpha: 0.9) : baseColor,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ],
      ],
    ),
  );
}

/// Section card with title + body text
Widget _buildSectionCard(
  BuildContext context,
  String title,
  String body,
  bool isDark,
  IconData icon,
) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: isDark ? AppColors.darkInkSecondary : AppColors.accentPrimary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.captionRegular(context).copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            body,
            style: AppTypography.captionRegular(context).copyWith(
              height: 1.8,
              color: isDark ? AppColors.darkInkPrimary : AppColors.inkPrimary,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Chips section with label + Wrap chips
Widget _buildChipSection(
  BuildContext context,
  String label,
  List<String> items,
  bool isDark,
  Widget Function(String item, int index) chipBuilder,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.captionRegular(context).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                for (var i = 0; i < items.length; i++) chipBuilder(items[i], i),
              ],
            ),
          ],
        ),
      ),
    ),
  );
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
