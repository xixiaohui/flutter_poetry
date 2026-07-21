import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/author.dart';
import '../../../shared/widgets/dynasty_badge.dart';

/// 作者页视差头部 — SliverAppBar + 画像背景 + 渐变遮罩
class AuthorHeader extends StatelessWidget {
  final Author author;

  const AuthorHeader({super.key, required this.author});

  String? get _subtitleText {
    final parts = <String>[];
    if (author.courtesyName != null && author.courtesyName!.isNotEmpty) {
      parts.add('字 ${author.courtesyName}');
    }
    if (author.pseudonym != null && author.pseudonym!.isNotEmpty) {
      parts.add('号 ${author.pseudonym}');
    }
    parts.add(author.dynasty.name);
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasPortrait =
        author.portraitUrl != null && author.portraitUrl!.isNotEmpty;

    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor:
          isDark ? AppColors.darkSurfacePrimary : AppColors.surfacePrimary,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: Text(
          author.name,
          style: AppTypography.bodyMedium(context),
          overflow: TextOverflow.ellipsis,
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            // 背景 — 画像 或 纯色
            if (hasPortrait)
              CachedNetworkImage(
                imageUrl: author.portraitUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: AppColors.surfaceSecondary),
                errorWidget: (context, url, error) =>
                    Container(color: AppColors.surfaceSecondary),
              )
            else
              Container(color: AppColors.surfaceSecondary),

            // 渐变遮罩（画像上有，纯色背景上轻量）
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: hasPortrait
                        ? [
                            Colors.transparent,
                            (isDark
                                    ? AppColors.darkSurfacePrimary
                                    : AppColors.surfacePrimary)
                                .withValues(alpha: 0.85),
                          ]
                        : [
                            Colors.transparent,
                            (isDark
                                    ? AppColors.darkSurfacePrimary
                                    : AppColors.surfacePrimary)
                                .withValues(alpha: 0.4),
                          ],
                  ),
                ),
              ),
            ),

            // 展开区域内容
            Positioned(
              left: 16,
              right: 16,
              bottom: 48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    author.name,
                    style: AppTypography.displayLarge(context).copyWith(
                      color: isDark
                          ? AppColors.darkInkPrimary
                          : AppColors.inkPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _subtitleText ?? '',
                    style: AppTypography.captionRegular(context).copyWith(
                      color: isDark
                          ? AppColors.darkInkSecondary
                          : AppColors.inkSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  DynastyBadge(dynasty: author.dynasty.name),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
