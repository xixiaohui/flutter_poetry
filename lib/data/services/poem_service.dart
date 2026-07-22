import 'dart:convert';

import 'package:isar_community/isar.dart';
import '../../core/constants/api_constants.dart';
import '../../core/database/app_database.dart';
import '../api/gateway_api_client.dart';
import '../api/search_type.dart';
import '../models/author.dart';
import '../models/dynasty.dart';
import '../models/poem.dart';
import '../models/paginated_response.dart';
import '../models/isar_models.dart';

/// 诗词数据服务 — API 聚合 + 缓存管理
final class PoemService {
  final GatewayApiClient _api = GatewayApiClient();
  final Isar _isar = AppDatabase.instance.isar;

  /// 获取诗词列表 (API first, cache fallback)
  Future<PaginatedResponse<Poem>> getPoems({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
    String? dynasty,
    String? category,
  }) async {
    try {
      final result = await _api.getPoems(
        page: page,
        pageSize: pageSize,
        dynasty: dynasty,
        category: category,
      );

      // 异步缓存到 Isar (不阻塞返回)
      _cachePoems(result.data);

      return result;
    } on Exception {
      // API 失败，尝试从缓存读取
      return _getCachedPoems(page: page, pageSize: pageSize);
    }
  }

  /// 搜索诗词
  Future<PaginatedResponse<Poem>> searchPoems({
    required String query,
    SearchType type = SearchType.all,
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    return _api.searchPoems(
      query: query,
      type: type,
      page: page,
      pageSize: pageSize,
    );
  }

  /// 随机获取一首
  Future<Poem> getRandomPoem({String? dynasty, String? category}) async {
    try {
      return await _api.getRandomPoem(dynasty: dynasty, category: category);
    } on Exception {
      // 从缓存中随机取一首
      final count = await _isar.poemCaches.count();
      if (count == 0) rethrow;
      final randomIndex = DateTime.now().millisecondsSinceEpoch % count;
      final cache =
          await _isar.poemCaches.where().offset(randomIndex).findFirst();
      if (cache == null) rethrow;
      return Poem(
        id: cache.poemId,
        title: cache.title,
        content: cache.content,
        author: AuthorBrief(
          id: '',
          name: cache.authorName,
          dynasty: Dynasty(id: '', name: cache.dynastyName),
        ),
        dynasty: Dynasty(id: '', name: cache.dynastyName),
        category: PoemCategory.misc,
      );
    }
  }

  /// 缓存诗词到 Isar
  Future<void> _cachePoems(List<Poem> poems) async {
    final caches = poems.map((p) {
      final cache = PoemCache()
        ..poemId = p.id
        ..title = p.title
        ..authorName = p.author.name
        ..dynastyName = p.dynasty.name
        ..content = p.content
        ..category = p.category.name
        ..contentSnippet = p.content.length > 100
            ? '${p.content.substring(0, 100)}…'
            : p.content
        ..cachedAt = DateTime.now();
      return cache;
    }).toList();

    await _isar.writeTxn(() async {
      await _isar.poemCaches.putAll(caches);
    });
  }

  /// 从缓存读取诗词列表
  Future<PaginatedResponse<Poem>> _getCachedPoems({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    final offset = (page - 1) * pageSize;
    final caches = await _isar.poemCaches
        .where()
        .offset(offset)
        .limit(pageSize)
        .findAll();
    final total = await _isar.poemCaches.count();

    return PaginatedResponse(
      data: caches.map((c) => Poem(
            id: c.poemId,
            title: c.title,
            content: c.content,
            author: AuthorBrief(
              id: '',
              name: c.authorName,
              dynasty: Dynasty(id: '', name: c.dynastyName),
            ),
            dynasty: Dynasty(id: '', name: c.dynastyName),
            category: PoemCategory.values.firstWhere(
              (e) => e.name == c.category,
              orElse: () => PoemCategory.misc,
            ),
          )).toList(),
      total: total,
      page: page,
      pageSize: pageSize,
      hasMore: offset + pageSize < total,
    );
  }

  /// 获取单首诗词详情 (API-first, cache fallback)
  Future<Poem> getPoemById(String id) async {
    try {
      final poem = await _api.getPoemById(id);
      // Cache to PoemDetailCache
      _cacheDetail(poem);
      return poem;
    } on Exception {
      // Try cache fallback
      final cached =
          await _isar.poemDetailCaches.where().poemIdEqualTo(id).findFirst();
      if (cached != null) {
        return Poem.fromJson(
            jsonDecode(cached.fullJson) as Map<String, dynamic>);
      }
      rethrow;
    }
  }

  Future<void> _cacheDetail(Poem poem) async {
    final cache = PoemDetailCache()
      ..poemId = poem.id
      ..fullJson = jsonEncode(poem.toJson())
      ..cachedAt = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.poemDetailCaches.put(cache);
    });
  }

  /// 按作者获取诗词
  Future<PaginatedResponse<Poem>> getPoemsByAuthor(
    String authorId, {
    int page = 1,
    int pageSize = 20,
  }) async {
    return _api.getPoemsByAuthor(authorId, page: page, pageSize: pageSize);
  }
}
