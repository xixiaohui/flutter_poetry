import 'package:isar_community/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/database/app_database.dart';
import '../api/search_type.dart';
import '../models/isar_models.dart';
import '../models/paginated_response.dart';
import '../models/poem.dart';
import '../services/poem_service.dart';

part 'poem_repository.g.dart';

/// 诗词 Repository — 业务逻辑 + 状态管理边界
@riverpod
PoemRepository poemRepository(poemRepositoryRef) => PoemRepository();

final class PoemRepository {
  final PoemService _service = PoemService();

  /// 获取诗词列表
  Future<PaginatedResponse<Poem>> getPoems({
    int page = 1,
    int pageSize = 20,
    String? dynasty,
    String? category,
  }) async {
    return _service.getPoems(
      page: page,
      pageSize: pageSize,
      dynasty: dynasty,
      category: category,
    );
  }

  /// 搜索诗词
  Future<PaginatedResponse<Poem>> searchPoems({
    required String query,
    SearchType type = SearchType.all,
    int page = 1,
  }) async {
    return _service.searchPoems(query: query, type: type, page: page);
  }

  /// 随机获取诗词
  Future<Poem> getRandomPoem({String? dynasty, String? category}) async {
    return _service.getRandomPoem(dynasty: dynasty, category: category);
  }

  /// 添加收藏
  Future<void> addFavorite(Poem poem) async {
    final isar = AppDatabase.instance.isar;
    final record = FavoriteRecord()
      ..poemId = poem.id
      ..title = poem.title
      ..authorName = poem.author.name
      ..contentSnippet = poem.content.length > 100
          ? '${poem.content.substring(0, 100)}…'
          : poem.content
      ..favoritedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.favoriteRecords.put(record);
    });
  }

  /// 移除收藏
  Future<void> removeFavorite(String poemId) async {
    final isar = AppDatabase.instance.isar;
    await isar.writeTxn(() async {
      await isar.favoriteRecords.where().poemIdEqualTo(poemId).deleteAll();
    });
  }

  /// 是否已收藏
  Future<bool> isFavorited(String poemId) async {
    final isar = AppDatabase.instance.isar;
    final record =
        await isar.favoriteRecords.where().poemIdEqualTo(poemId).findFirst();
    return record != null;
  }

  /// 获取收藏列表
  Future<List<FavoriteRecord>> getFavorites() async {
    final isar = AppDatabase.instance.isar;
    return isar.favoriteRecords.where().anyId().sortByFavoritedAtDesc().findAll();
  }

  /// 记录阅读
  Future<void> recordReading(Poem poem) async {
    final isar = AppDatabase.instance.isar;
    final existing =
        await isar.readingRecords.filter().poemIdEqualTo(poem.id).findFirst();

    await isar.writeTxn(() async {
      if (existing != null) {
        existing.readCount += 1;
        existing.readAt = DateTime.now();
        await isar.readingRecords.put(existing);
      } else {
        final record = ReadingRecord()
          ..poemId = poem.id
          ..title = poem.title
          ..authorName = poem.author.name
          ..readAt = DateTime.now()
          ..readCount = 1;
        await isar.readingRecords.put(record);
      }
    });
  }

  /// 获取最近阅读
  Future<List<ReadingRecord>> getRecentReads({int limit = 10}) async {
    final isar = AppDatabase.instance.isar;
    return isar.readingRecords.where().anyId().sortByReadAtDesc().limit(limit).findAll();
  }
}
