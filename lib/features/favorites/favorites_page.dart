import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/router/routes.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/favorites_repository.dart';
import 'providers/favorites_providers.dart';

/// 收藏页 — 显示已收藏的诗词，支持左滑删除。
///
/// 未登录时引导用户登录，已登录后从服务端同步收藏列表。
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authRepositoryProvider);
    final user = authAsync.valueOrNull;

    // ── 未登录 ──
    if (user == null) {
      // 有 token 但正在验证 → 轻量 loading
      final appBar = AppBar(title: const Text('收藏'));
      if (authAsync.isLoading) {
        return Scaffold(
          appBar: appBar,
          body: Column(
            children: [
              const SizedBox(height: AppSpacing.xl3),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: AppSpacing.md),
              Text('正在验证登录状态...',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(title: const Text('收藏')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.bookmark_outline,
                size: 64,
                color: AppColors.inkTertiary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                '登录后查看收藏',
                style: TextStyle(color: AppColors.inkSecondary),
              ),
              const SizedBox(height: AppSpacing.md),
              FilledButton(
                onPressed: () => context.push(AppRoutes.login),
                child: const Text('登录'),
              ),
            ],
          ),
        ),
      );
    }

    // ── 已登录 ──
    final favoritesAsync = ref.watch(favoritesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('收藏')),
      body: favoritesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text('加载失败: $error'),
        ),
        data: (favorites) {
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bookmark_outline,
                    size: 64,
                    color: AppColors.inkTertiary,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    '还没有收藏诗词',
                    style: TextStyle(color: AppColors.inkSecondary),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(favoritesListProvider.future),
            child: ListView.builder(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final fav = favorites[index];
                return Dismissible(
                  key: ValueKey(fav.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: AppColors.error,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    ref
                        .read(favoritesRepositoryProvider.notifier)
                        .removeFavorite(fav.poemId);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.pageHorizontal,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(
                        fav.poemTitle,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${fav.poemAuthor ?? ''} · ${fav.poemDynasty ?? ''}',
                      ),
                      trailing: Text(
                        fav.createdAt.substring(0, 10),
                        style: TextStyle(
                          color: AppColors.inkTertiary,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () => context.push(
                        AppRoutes.poemById(fav.poemId.toString()),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
