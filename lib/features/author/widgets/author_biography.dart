import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/section_header.dart';

/// 生平简介区域 — 若为空则隐藏
class AuthorBiography extends StatelessWidget {
  final String? biography;

  const AuthorBiography({super.key, required this.biography});

  @override
  Widget build(BuildContext context) {
    if (biography == null || biography!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '生平'),
        Padding(
          padding: AppSpacing.pagePadding,
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.maxReadingWidth),
            child: Text(
              biography!,
              style: AppTypography.bodyLarge(context),
            ),
          ),
        ),
      ],
    );
  }
}
