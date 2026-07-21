import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/dynasty.dart';
import '../../../shared/widgets/section_header.dart';

/// 年代时间轴 — 朝代时段 + 近似生卒年
class AuthorTimeline extends StatelessWidget {
  final Dynasty dynasty;

  const AuthorTimeline({super.key, required this.dynasty});

  @override
  Widget build(BuildContext context) {
    final dynastyMidpoint =
        (dynasty.startYear != null && dynasty.endYear != null)
            ? (dynasty.startYear! + dynasty.endYear!) ~/ 2
            : null;
    final estimatedBirth = dynastyMidpoint;
    final estimatedDeath =
        dynastyMidpoint != null ? dynastyMidpoint + 60 : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '年代'),
        // 朝代节点
        _TimelineRow(
          isFirst: true,
          isLast: estimatedBirth == null,
          isAccent: true,
          leading: dynasty.name,
          trailing: dynasty.startYear != null && dynasty.endYear != null
              ? '$dynasty.startYear年 — $dynasty.endYear年'
              : null,
        ),
        // 生卒估算节点
        if (estimatedBirth != null && estimatedDeath != null)
          _TimelineRow(
            isFirst: false,
            isLast: true,
            isAccent: false,
            leading: '生卒',
            trailing: '约 $estimatedBirth年 — $estimatedDeath年',
          ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isAccent;
  final String leading;
  final String? trailing;

  const _TimelineRow({
    required this.isFirst,
    required this.isLast,
    required this.isAccent,
    required this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lineColor = isDark
        ? AppColors.darkSurfaceTertiary
        : AppColors.surfaceTertiary;
    final dotColor = isAccent
        ? AppColors.accentPrimary
        : AppColors.accentPrimary.withValues(alpha: 0.5);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 时间轴指示器列
            SizedBox(
              width: 24,
              child: Column(
                children: [
                  if (!isFirst)
                    Expanded(child: Container(width: 2, color: lineColor)),
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Expanded(child: Container(width: 2, color: lineColor)),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            // 内容
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(leading, style: AppTypography.bodyMedium(context)),
                    if (trailing != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        trailing!,
                        style: AppTypography.captionRegular(context),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
