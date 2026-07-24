import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/api_models.dart';
import '../../../data/models/poem.dart';
import '../../../data/repositories/ai_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/favorites_repository.dart';

/// 操作栏 — 收藏 / 分享 / 复制 / 翻译
class PoemActionBar extends ConsumerWidget {
  final Poem poem;

  const PoemActionBar({super.key, required this.poem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? AppColors.darkInkSecondary : AppColors.inkSecondary;

    // Check server favorites state
    final favState = ref.watch(favoritesRepositoryProvider);
    final poemIdInt = int.parse(poem.id);
    final isFav = favState.valueOrNull?.any((f) => f.poemId == poemIdInt) ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 收藏按钮 (server-side)
          _ActionButton(
            icon: isFav ? Icons.bookmark : Icons.bookmark_outline,
            color: isFav ? AppColors.accentPrimary : iconColor,
            label: '收藏',
            onTap: () {
              HapticFeedback.mediumImpact();
              _handleFavorite(context, ref, poemIdInt);
            },
          ),

          // 翻译按钮
          _ActionButton(
            icon: Icons.translate_outlined,
            color: iconColor,
            label: '翻译',
            onTap: () {
              HapticFeedback.lightImpact();
              _showTranslationSheet(context, poem.content);
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

  /// Handle favorite toggle with auth check
  void _handleFavorite(BuildContext context, WidgetRef ref, int poemIdInt) {
    final auth = ref.read(authRepositoryProvider);
    if (auth.valueOrNull == null) {
      context.push(AppRoutes.login);
      return;
    }

    final favRepo = ref.read(favoritesRepositoryProvider.notifier);
    final isFav = favRepo.isFavorited(poemIdInt);

    if (isFav) {
      favRepo.removeFavorite(poemIdInt);
    } else {
      favRepo.addFavorite(
        poemId: poemIdInt,
        poemTitle: poem.title,
        poemAuthor: poem.author.name,
        poemDynasty: poem.dynasty.name,
      );
    }
  }

  /// Show AI translation bottom sheet
  void _showTranslationSheet(BuildContext context, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _TranslationSheet(content: content),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Translation Bottom Sheet
// ─────────────────────────────────────────────────────────────────

class _TranslationSheet extends ConsumerStatefulWidget {
  final String content;
  const _TranslationSheet({required this.content});

  @override
  ConsumerState<_TranslationSheet> createState() => _TranslationSheetState();
}

class _TranslationSheetState extends ConsumerState<_TranslationSheet> {
  String _targetLang = 'en';
  bool _isTranslating = false;
  AITranslation? _result;
  String? _error;

  static const _langOptions = [
    ('English', 'en'),
    ('日本語', 'ja'),
    ('한국어', 'ko'),
  ];

  Future<void> _translate() async {
    setState(() {
      _isTranslating = true;
      _error = null;
      _result = null;
    });

    try {
      final result = await ref.read(aiRepositoryProvider).translatePoem(
        content: widget.content,
        targetLang: _targetLang,
      );
      setState(() {
        _result = result;
        _isTranslating = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isTranslating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurfaceTertiary : AppColors.surfaceTertiary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Title
              Text(
                'AI 翻译',
                style: AppTypography.bodyLarge(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),

              // Language selection
              Text(
                '选择目标语言',
                style: AppTypography.captionRegular(context),
              ),
              const SizedBox(height: AppSpacing.sm),
              SegmentedButton<String>(
                segments: _langOptions
                    .map((o) => ButtonSegment<String>(
                          value: o.$2,
                          label: Text(o.$1),
                        ))
                    .toList(),
                selected: {_targetLang},
                onSelectionChanged: (sel) {
                  setState(() => _targetLang = sel.first);
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // Translate button
              FilledButton.icon(
                onPressed: _isTranslating ? null : _translate,
                icon: _isTranslating
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.translate, size: 18),
                label: Text(_isTranslating ? '翻译中...' : '翻译'),
              ),
              const SizedBox(height: AppSpacing.md),

              // Error
              if (_error != null) ...[
                Card(
                  color: isDark
                      ? AppColors.error.withValues(alpha: 0.15)
                      : AppColors.error.withValues(alpha: 0.08),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      _error!,
                      style: AppTypography.captionRegular(context).copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
              ],

              // Result
              if (_result != null) ...[
                const SizedBox(height: AppSpacing.sm),
                _buildResult(isDark),
              ],

              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResult(bool isDark) {
    final result = _result!;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Translation text
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '译文',
                    style: AppTypography.captionRegular(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    result.translation,
                    style: AppTypography.bodyMedium(context).copyWith(
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Notes
          if (result.notes.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '翻译说明',
                      style: AppTypography.captionRegular(context).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ...result.notes.map(
                      (note) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ',
                                style: AppTypography.captionRegular(context)),
                            Expanded(
                              child: Text(
                                note,
                                style: AppTypography.captionRegular(context)
                                    .copyWith(height: 1.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
