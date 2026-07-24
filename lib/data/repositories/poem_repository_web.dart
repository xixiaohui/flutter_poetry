/// Web 平台桩 — 无 Isar 本地存储，收藏/历史仅通过服务端 API
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/poem.dart';
import '../models/paginated_response.dart';
import '../models/isar_models.dart';
import '../services/poem_service.dart';
import '../services/favorites_service.dart';
import '../services/history_service.dart';

// Manually defined provider (matches the IO version's generated provider)
final poemRepositoryProvider = Provider<PoemRepository>((ref) => PoemRepository());

final class PoemRepository {
  final PoemService _service = PoemService();
  final FavoritesService _favService = FavoritesService();
  final HistoryService _histService = HistoryService();

  Future<PaginatedResponse<Poem>> getPoems({int page = 1, int pageSize = 20, String? dynasty, String? type}) async {
    return _service.getPoems(page: page, pageSize: pageSize, dynasty: dynasty, type: type);
  }

  Future<PaginatedResponse<Poem>> searchPoems({required String query, String? type, int page = 1}) async {
    return _service.searchPoems(query: query, type: type, page: page);
  }

  Future<Poem> getRandomPoem({String? dynasty, String? type}) async {
    return _service.getRandomPoem(dynasty: dynasty, type: type);
  }

  Future<Poem> getPoemById(int id) async {
    return _service.getPoemById(id);
  }

  Future<PaginatedResponse<Poem>> getPoemsByAuthor(String authorId, {int page = 1, int pageSize = 20}) async {
    return _service.getPoemsByAuthor(authorId, page: page, pageSize: pageSize);
  }

  // Web: 收藏走服务端
  Future<void> addFavorite(Poem poem) async {
    await _favService.addFavorite(poemId: int.parse(poem.id), poemTitle: poem.title, poemAuthor: poem.author.name, poemDynasty: poem.dynasty.name);
  }

  Future<void> removeFavorite(String poemId) async {
    await _favService.removeFavorite(int.parse(poemId));
  }

  Future<bool> isFavorited(String poemId) async => false; // Web 上简化，由 FavoritesRepository 管理

  Future<List<FavoriteRecord>> getFavorites() async => [];

  Future<void> recordReading(Poem poem) async {
    await _histService.recordReading(poemId: int.parse(poem.id), poemTitle: poem.title, poemAuthor: poem.author.name, poemDynasty: poem.dynasty.name);
  }

  Future<List<ReadingRecord>> getRecentReads({int limit = 10}) async => [];

  // 服务端收藏/历史委托
  Future<void> addServerFavorite({required int poemId, required String poemTitle, String? poemAuthor, String? poemDynasty}) async {
    await _favService.addFavorite(poemId: poemId, poemTitle: poemTitle, poemAuthor: poemAuthor, poemDynasty: poemDynasty);
  }

  Future<void> removeServerFavorite(int poemId) async {
    await _favService.removeFavorite(poemId);
  }

  Future<void> recordServerReading({required int poemId, required String poemTitle, String? poemAuthor, String? poemDynasty}) async {
    await _histService.recordReading(poemId: poemId, poemTitle: poemTitle, poemAuthor: poemAuthor, poemDynasty: poemDynasty);
  }
}
