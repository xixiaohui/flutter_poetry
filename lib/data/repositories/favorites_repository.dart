import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_models.dart';
import '../services/favorites_service.dart';
import 'auth_repository.dart';

part 'favorites_repository.g.dart';

@riverpod
class FavoritesRepository extends _$FavoritesRepository {
  final FavoritesService _service = FavoritesService();

  @override
  Future<List<FavoriteItem>> build() async {
    final auth = ref.watch(authRepositoryProvider);
    if (!auth.hasValue || auth.value == null) return [];
    try {
      final result = await _service.getFavorites();
      return result.favorites;
    } catch (_) {
      return [];
    }
  }

  /// Add a poem to favorites (no-op if not logged in).
  Future<void> addFavorite({
    required int poemId,
    required String poemTitle,
    String? poemAuthor,
    String? poemDynasty,
  }) async {
    final auth = ref.read(authRepositoryProvider);
    if (auth.valueOrNull == null) return;
    await _service.addFavorite(
      poemId: poemId,
      poemTitle: poemTitle,
      poemAuthor: poemAuthor,
      poemDynasty: poemDynasty,
    );
    ref.invalidateSelf();
  }

  /// Remove a poem from favorites (no-op if not logged in).
  Future<void> removeFavorite(int poemId) async {
    final auth = ref.read(authRepositoryProvider);
    if (auth.valueOrNull == null) return;
    await _service.removeFavorite(poemId);
    ref.invalidateSelf();
  }

  /// Check if a poem is in the current favorites list.
  bool isFavorited(int poemId) {
    return state.valueOrNull?.any((f) => f.poemId == poemId) ?? false;
  }

  /// Start periodic background sync (every 5 minutes).
  void startAutoSync() {
    _service.startAutoSync(onSync: (favorites) {
      ref.invalidateSelf();
    });
  }

  /// Stop the periodic background sync timer.
  void stopAutoSync() {
    _service.stopAutoSync();
  }
}
