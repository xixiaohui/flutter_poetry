import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../data/models/poem.dart';
import '../providers/poem_detail_providers.dart';

/// 操作栏 — 收藏 / 分享 / 复制
class PoemActionBar extends ConsumerWidget {
  final Poem poem;

  const PoemActionBar({super.key, required this.poem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteAsync = ref.watch(poemFavoriteProvider(poem.id));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? AppColors.darkInkSecondary : AppColors.inkSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 收藏按钮
          _ActionButton(
            icon: favoriteAsync.when(
              data: (isFav) =>
                  isFav ? Icons.bookmark : Icons.bookmark_outline,
              loading: () => Icons.bookmark_outline,
              error: (_, __) => Icons.bookmark_outline,
            ),
            color: favoriteAsync.when(
              data: (isFav) =>
                  isFav ? AppColors.accentPrimary : iconColor,
              loading: () => iconColor,
              error: (_, __) => iconColor,
            ),
            label: '收藏',
            onTap: () {
              HapticFeedback.mediumImpact();
              ref.read(poemFavoriteProvider(poem.id).notifier).toggle(poem);
            },
          ),

          // 分享按钮 (占位)
          _ActionButton(
            icon: Icons.share_outlined,
            color: iconColor,
            label: '分享',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('分享功能即将上线')),
              );
            },
          ),

          // 复制按钮
          _ActionButton(
            icon: Icons.copy_outlined,
            color: iconColor,
            label: '复制',
            onTap: () {
              Clipboard.setData(ClipboardData(text: poem.content));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('已复制')),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// 单个操作按钮 (图标在上，文字在下)
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: AppSpacing.xs),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
