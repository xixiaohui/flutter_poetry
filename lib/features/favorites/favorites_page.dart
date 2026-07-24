import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/router/routes.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../shared/widgets/skeleton_loader.dart';

/// 收藏页 — 直接监听 auth + favorites，无中间 provider
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).valueOrNull;

    // 未登录
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('收藏')),
        body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.bookmark_outline, size: 64, color: AppColors.inkTertiary),
          const SizedBox(height: AppSpacing.md),
          Text('登录后查看收藏', style: TextStyle(color: AppColors.inkSecondary)),
          const SizedBox(height: AppSpacing.md),
          FilledButton(onPressed: () => context.push(AppRoutes.login), child: const Text('登录')),
        ])),
      );
    }

    // 已登录 — 直接 watch favoritesRepository
    final favsAsync = ref.watch(favoritesRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('收藏')),
      body: favsAsync.when(
        loading: () => ListView.builder(
          padding: const EdgeInsets.all(AppSpacing.md),
          itemCount: 5,
          itemBuilder: (_, __) => const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: SkeletonLoader(height: 72, borderRadius: 12),
          ),
        ),
        error: (e, _) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.inkTertiary),
          const SizedBox(height: AppSpacing.md),
          Text('加载失败', style: TextStyle(color: AppColors.inkSecondary)),
          const SizedBox(height: AppSpacing.md),
          FilledButton(onPressed: () => ref.invalidate(favoritesRepositoryProvider), child: const Text('重试')),
        ])),
        data: (favs) {
          if (favs.isEmpty) {
            return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.bookmark_outline, size: 56, color: AppColors.inkTertiary),
              const SizedBox(height: AppSpacing.md),
              const Text('还没有收藏诗词'),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(favoritesRepositoryProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: favs.length,
              itemBuilder: (context, index) {
                final fav = favs[index];
                return Dismissible(
                  key: Key(fav.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: AppSpacing.md),
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    ref.read(favoritesRepositoryProvider.notifier).removeFavorite(fav.poemId);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(fav.poemTitle, style: const TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: Text('${fav.poemAuthor ?? ''} · ${fav.poemDynasty ?? ''}'),
                      trailing: Text(fav.createdAt.substring(0, 10), style: Theme.of(context).textTheme.bodySmall),
                      onTap: () => context.push('/home/poem/${fav.poemId}'),
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
