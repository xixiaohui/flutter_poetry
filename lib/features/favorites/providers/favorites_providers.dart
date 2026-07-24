import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/api_models.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/favorites_repository.dart';
part 'favorites_providers.g.dart';

@riverpod
class FavoritesListNotifier extends _$FavoritesListNotifier {
  @override
  List<FavoriteItem>? build() => null;

  Future<void> load() async {
    try {
      final user = ref.read(authRepositoryProvider).valueOrNull;
      if (user == null) {
        debugPrint('[Favorites] 未登录，跳过');
        state = [];
        return;
      }
      debugPrint('[Favorites] 开始加载...');
      ref.read(favoritesRepositoryProvider.notifier);
      final favs = ref.read(favoritesRepositoryProvider).valueOrNull ?? [];
      state = favs;
      debugPrint('[Favorites] ✅ ${favs.length} 条');
    } catch (e, st) {
      debugPrint('[Favorites] ❌ $e\n$st');
      state = [];
    }
  }
}
