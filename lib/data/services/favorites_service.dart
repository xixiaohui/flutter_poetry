import 'dart:async';
import '../api/gateway_api_client.dart';
import '../models/api_models.dart';

final class FavoritesService {
  final GatewayApiClient _api = GatewayApiClient();

  Future<({List<FavoriteItem> favorites, int total})> getFavorites() => _api.getFavorites();
  Future<void> addFavorite({required int poemId, required String poemTitle, String? poemAuthor, String? poemDynasty}) =>
      _api.addFavorite(poemId: poemId, poemTitle: poemTitle, poemAuthor: poemAuthor, poemDynasty: poemDynasty);
  Future<void> removeFavorite(int poemId) => _api.removeFavorite(poemId);
  Future<({List<FavoriteItem> favorites, String syncToken, int total})> syncFavorites() => _api.syncFavorites();

  Timer? _syncTimer;
  void startAutoSync({required void Function(List<FavoriteItem>) onSync}) {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) async {
      try {
        final result = await syncFavorites();
        onSync(result.favorites);
      } catch (_) {}
    });
  }
  void stopAutoSync() => _syncTimer?.cancel();
}
