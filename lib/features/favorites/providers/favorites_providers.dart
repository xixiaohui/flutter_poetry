import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/api_models.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/favorites_repository.dart';
part 'favorites_providers.g.dart';

/// 收藏列表 — 先渲染空 UI，后台静默加载
@riverpod
class FavoritesListNotifier extends _$FavoritesListNotifier {
  @override
  List<FavoriteItem>? build() {
    Future.microtask(() => load());
    return null;
  }

  Future<void> load() async {
    try {
      final user = ref.read(authRepositoryProvider).valueOrNull;
      if (user == null) {
        debugPrint('[Favorites] 未登录，跳过加载');
        state = [];
        return;
      }
      debugPrint('[Favorites] 开始加载收藏列表...');
      final favState = ref.read(favoritesRepositoryProvider);
      final items = favState.valueOrNull ?? [];
      state = items;
      debugPrint('[Favorites] ✅ 加载成功 — ${items.length} 条收藏');
    } catch (e, st) {
      debugPrint('[Favorites] ❌ 加载失败: $e');
      debugPrint('[Favorites] 堆栈: $st');
      state = [];
    }
  }

  Future<void> refresh() async {
    state = null;
    await load();
  }
}
