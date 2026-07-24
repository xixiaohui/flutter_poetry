import 'dart:convert';

import 'package:isar_community/isar.dart';
import '../../core/constants/api_constants.dart';
import '../../core/database/app_database.dart';
import '../api/gateway_api_client.dart';
import '../models/api_models.dart';
import '../models/author.dart';
import '../models/dynasty.dart';
import '../models/poem.dart';
import '../models/paginated_response.dart';
import '../models/isar_models.dart';

/// 诗词数据服务 — API 聚合 + 缓存管理
final class PoemService {
  final GatewayApiClient _api = GatewayApiClient();
  final Isar _isar = AppDatabase.instance.isar;

  /// Convert flat ApiPoem (author=String?, dynasty=String?) to nested Poem (author=AuthorBrief, dynasty=Dynasty)
  Poem _apiPoemToPoem(ApiPoem p) => Poem(
        id: p.id.toString(),
        title: p.title,
        content: p.content,
        author: AuthorBrief(
          id: '',
          name: p.author ?? '',
          dynasty: Dynasty(id: '', name: p.dynasty ?? ''),
        ),
        dynasty: Dynasty(id: '', name: p.dynasty ?? ''),
        category: PoemCategory.misc,
      );

  /// 获取诗词列表 (API first, cache fallback)
  Future<PaginatedResponse<Poem>> getPoems({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
    String? dynasty,
    String? type,
    String? author,
  }) async {
    try {
      final result = await _api.getPoems(
        page: page,
        pageSize: pageSize,
        dynasty: dynasty,
        type: type,
        author: author,
      );

      final poems = result.data.map(_apiPoemToPoem).toList();

      // 异步缓存到 Isar (不阻塞返回)
      _cachePoems(poems);

      return PaginatedResponse(
        data: poems,
        total: result.total,
        page: result.page,
        pageSize: result.pageSize,
        hasMore: result.hasMore,
      );
    } on Exception {
      // API 失败，尝试从缓存读取
      return _getCachedPoems(page: page, pageSize: pageSize);
    }
  }

  /// 搜索诗词
  Future<PaginatedResponse<Poem>> searchPoems({
    required String query,
    String? type,
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    final result = await _api.search(
      q: query,
      type: type,
      page: page,
      pageSize: pageSize,
    );

    return PaginatedResponse(
      data: result.data.map(_apiPoemToPoem).toList(),
      total: result.total,
      page: result.page,
      pageSize: result.pageSize,
      hasMore: result.hasMore,
    );
  }

  /// 随机获取一首
  Future<Poem> getRandomPoem({
    String? author,
    String? type,
    String? dynasty,
    String? char,
  }) async {
    try {
      final apiPoem = await _api.getRandomPoem(
        author: author,
        type: type,
        dynasty: dynasty,
        char: char,
      );
      return _apiPoemToPoem(apiPoem);
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

  /// 获取单首诗词详情 (API-first, cache fallback)
  Future<Poem> getPoemById(int id) async {
    try {
      final apiPoem = await _api.getPoemById(id);
      final poem = _apiPoemToPoem(apiPoem);
      // Cache to PoemDetailCache
      _cacheDetail(poem);
      return poem;
    } on Exception {
      // Try cache fallback
      final cached = await _isar.poemDetailCaches
          .where()
          .poemIdEqualTo(id.toString())
          .findFirst();
      if (cached != null) {
        return Poem.fromJson(
            jsonDecode(cached.fullJson) as Map<String, dynamic>);
      }
      rethrow;
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
    String authorName, {
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final result = await _api.getPoems(
        author: authorName,
        page: page,
        pageSize: pageSize,
      );

      final poems = result.data.map(_apiPoemToPoem).toList();
      _cachePoems(poems);

      return PaginatedResponse(
        data: poems,
        total: result.total,
        page: result.page,
        pageSize: result.pageSize,
        hasMore: result.hasMore,
      );
    } on Exception {
      return _getCachedPoems(page: page, pageSize: pageSize);
    }
  }
}
