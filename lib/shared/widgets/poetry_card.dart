import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/poem.dart';

/// 诗词卡片 — 首页列表/发现列表通用
class PoetryCard extends StatelessWidget {
  final Poem poem;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final String? heroTag;

  const PoetryCard({
    super.key,
    required this.poem,
    this.onTap,
    this.onFavorite,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final contentPreview = poem.content.length > 60
        ? '${poem.content.substring(0, 60)}…'
        : poem.content;

    final card = Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: AppSpacing.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题行
              Row(
                children: [
                  Expanded(
                    child: Text(
                      poem.title,
                      style: AppTypography.bodyMedium(context),
                    ),
                  ),
                  if (onFavorite != null)
                    IconButton(
                      onPressed: onFavorite,
                      icon: const Icon(
                        Icons.bookmark_outline,
                        size: 20,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),

              // 内容预览
              Text(
                contentPreview,
                style: AppTypography.captionRegular(context).copyWith(
                  color: AppColors.inkSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),

              // 作者 + 朝代
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceTertiary,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.buttonRadius),
                    ),
                    child: Text(
                      poem.dynasty.name,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.inkTertiary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    poem.author.name,
                    style: AppTypography.captionRegular(context).copyWith(
                      color: AppColors.inkTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (heroTag != null) {
      return Hero(tag: heroTag!, child: card);
    }
    return card;
  }
}
