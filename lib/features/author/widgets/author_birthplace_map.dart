import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/section_header.dart';

/// 故里展示 — 若为空则隐藏，地图延后
class AuthorBirthplaceMap extends StatelessWidget {
  final String? birthplace;

  const AuthorBirthplaceMap({super.key, required this.birthplace});

  @override
  Widget build(BuildContext context) {
    if (birthplace == null || birthplace!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: '故里'),
        Padding(
          padding: AppSpacing.pagePadding,
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                birthplace!,
                style: AppTypography.bodyLarge(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
