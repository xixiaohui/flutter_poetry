import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/api_models.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/favorites_repository.dart';
part 'favorites_providers.g.dart';

@riverpod
Future<List<FavoriteItem>> favoritesList(FavoritesListRef ref) async {
  final user = ref.watch(authRepositoryProvider).valueOrNull;
  if (user == null) return [];
  return ref.watch(favoritesRepositoryProvider.future);
}
