import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/router/routes.dart';
import '../../data/repositories/auth_repository.dart';
import '../../shared/widgets/skeleton_loader.dart';
import 'providers/favorites_providers.dart';

/// 收藏页 — 先渲染 UI 骨架，后台静默加载数据
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).valueOrNull;

    // ── 未登录 ──
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('收藏')),
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.bookmark_outline, size: 64, color: AppColors.inkTertiary),
            const SizedBox(height: AppSpacing.md),
            Text('登录后查看收藏', style: TextStyle(color: AppColors.inkSecondary)),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: () => context.push(AppRoutes.login),
              child: const Text('登录'),
            ),
          ]),
        ),
      );
    }

    // ── 已登录 ──
    final items = ref.watch(favoritesListNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('收藏')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(favoritesListNotifierProvider.notifier).refresh(),
        child: ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: items == null
              ? 5 // skeleton count
              : (items.isEmpty ? 1 : items.length),
          itemBuilder: (context, index) {
            // Loading skeleton
            if (items == null) {
              return const Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.sm),
                child: SkeletonLoader(height: 72, borderRadius: 12),
              );
            }

            // Empty state
            if (items.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xl3),
                  child: Column(children: [
                    Icon(Icons.bookmark_outline, size: 56, color: AppColors.inkTertiary),
                    const SizedBox(height: AppSpacing.md),
                    const Text('还没有收藏诗词'),
                  ]),
                ),
              );
            }

            // Data items
            final fav = items[index];
            return Dismissible(
              key: Key(fav.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: AppSpacing.md),
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                ref.read(favoritesListNotifierProvider.notifier).refresh();
              },
              child: Card(
                child: ListTile(
                  title: Text(fav.poemTitle,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text('${fav.poemAuthor ?? ''} · ${fav.poemDynasty ?? ''}'),
                  trailing: Text(fav.createdAt.substring(0, 10),
                      style: Theme.of(context).textTheme.bodySmall),
                  onTap: () => context.push('/home/poem/${fav.poemId}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
