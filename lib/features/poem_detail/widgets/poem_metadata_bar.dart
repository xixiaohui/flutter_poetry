import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/poem.dart';
import '../../../shared/widgets/author_chip.dart';
import '../../../shared/widgets/dynasty_badge.dart';

/// 诗词元信息栏 — 标题 + 作者 + 朝代 + 标签
class PoemMetadataBar extends StatelessWidget {
  final Poem poem;
  final String? heroTag;

  const PoemMetadataBar({super.key, required this.poem, this.heroTag});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleWidget = Text(
      poem.title,
      style: AppTypography.displayLarge(context),
      textAlign: TextAlign.center,
    );

    return Padding(
      padding: AppSpacing.pagePadding,
      child: Column(
        children: [
          // 标题 (支持 Hero 动画)
          if (heroTag != null)
            Hero(tag: heroTag!, child: titleWidget)
          else
            titleWidget,

          const SizedBox(height: AppSpacing.md),

          // 作者 + 朝代
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthorChip(
                name: poem.author.name,
                onTap: () =>
                    context.go('/home/author/${poem.author.id}'),
              ),
              const SizedBox(width: AppSpacing.sm),
              DynastyBadge(dynasty: poem.dynasty.name),
            ],
          ),

          // 分类标签
          if (poem.tags.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: poem.tags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkInkTertiary
                          : AppColors.inkTertiary,
                      width: 0.5,
                    ),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.buttonRadius),
                  ),
                  child: Text(
                    tag,
                    style: AppTypography.captionRegular(context).copyWith(
                      fontSize: 11,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}
