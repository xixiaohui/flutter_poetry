import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/author.dart';
import '../models/dynasty.dart';
import '../models/paginated_response.dart';
import '../models/poem.dart';
import 'search_type.dart';

/// 统一 Poetry Gateway API 客户端
///
/// 所有 Flutter 网络请求的唯一出口，按域组织方法：
/// - 诗词域: getPoems, getPoemById, searchPoems, getRandomPoem, getPoemsByAuthor
/// - 作者域: getAuthors, getAuthorById, getDynasties
/// - 首页域: getHome
/// - AI 域:   analyzePoem, generateIllustration
/// - 用户域: getFavorites, addFavorite, removeFavorite, getHistory（预留）
final class GatewayApiClient {
  final Dio _dio = DioClient.instance;

  // ═══════════════════════════════════════════════════════════════
  // 诗词域
  // ═══════════════════════════════════════════════════════════════

  /// 获取诗词列表
  Future<PaginatedResponse<Poem>> getPoems({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
    String? dynasty,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
    };
    if (dynasty != null) queryParams['dynasty'] = dynasty;
    if (category != null) queryParams['category'] = category;

    final response = await _dio.get(
      ApiConstants.poemsEndpoint,
      queryParameters: queryParams,
    );

    final data = response.data;
    return PaginatedResponse(
      data: (data['data'] as List)
          .map((json) => Poem.fromJson(json as Map<String, dynamic>))
          .toList(),
      total: data['total'] as int,
      page: data['page'] as int,
      pageSize: data['page_size'] as int,
      hasMore: (data['page'] as int) * (data['page_size'] as int) <
          (data['total'] as int),
    );
  }

  /// 搜索诗词
  Future<PaginatedResponse<Poem>> searchPoems({
    required String query,
    SearchType type = SearchType.all,
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    final response = await _dio.get(
      ApiConstants.poemsSearchEndpoint,
      queryParameters: {
        'q': query,
        'type': type.apiValue,
        'page': page,
        'page_size': pageSize,
      },
    );

    final data = response.data;
    return PaginatedResponse(
      data: (data['data'] as List)
          .map((json) => Poem.fromJson(json as Map<String, dynamic>))
          .toList(),
      total: data['total'] as int,
      page: data['page'] as int,
      pageSize: data['page_size'] as int,
      hasMore: (data['page'] as int) * (data['page_size'] as int) <
          (data['total'] as int),
    );
  }

  /// 随机获取一首诗词
  Future<Poem> getRandomPoem({
    String? dynasty,
    String? category,
  }) async {
    final queryParams = <String, dynamic>{};
    if (dynasty != null) queryParams['dynasty'] = dynasty;
    if (category != null) queryParams['category'] = category;

    final response = await _dio.get(
      ApiConstants.poemsRandomEndpoint,
      queryParameters: queryParams,
    );

    return Poem.fromJson(response.data as Map<String, dynamic>);
  }

  /// 获取单首诗词详情
  Future<Poem> getPoemById(String id) async {
    final response = await _dio.get(ApiConstants.poemDetailEndpoint(id));
    return Poem.fromJson(response.data as Map<String, dynamic>);
  }

  /// 按作者获取诗词
  Future<PaginatedResponse<Poem>> getPoemsByAuthor(
    String authorId, {
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    final response = await _dio.get(
      ApiConstants.poemsEndpoint,
      queryParameters: {
        'author': authorId,
        'page': page,
        'page_size': pageSize,
      },
    );
    final data = response.data;
    return PaginatedResponse(
      data: (data['data'] as List)
          .map((json) => Poem.fromJson(json as Map<String, dynamic>))
          .toList(),
      total: data['total'] as int,
      page: data['page'] as int,
      pageSize: data['page_size'] as int,
      hasMore: (data['page'] as int) * (data['page_size'] as int) <
          (data['total'] as int),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // 作者域
  // ═══════════════════════════════════════════════════════════════

  /// 获取作者列表
  Future<PaginatedResponse<Author>> getAuthors({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    final response = await _dio.get(
      ApiConstants.authorsEndpoint,
      queryParameters: {'page': page, 'page_size': pageSize},
    );

    final data = response.data;
    return PaginatedResponse(
      data: (data['data'] as List)
          .map((json) => Author.fromJson(json as Map<String, dynamic>))
          .toList(),
      total: data['total'] as int,
      page: data['page'] as int,
      pageSize: data['page_size'] as int,
      hasMore: (data['page'] as int) * (data['page_size'] as int) <
          (data['total'] as int),
    );
  }

  /// 获取作者详情
  Future<Author> getAuthorById(String id) async {
    final response = await _dio.get(ApiConstants.authorDetailEndpoint(id));
    return Author.fromJson(response.data as Map<String, dynamic>);
  }

  /// 获取朝代列表
  Future<List<Dynasty>> getDynasties() async {
    final response = await _dio.get(ApiConstants.dynastiesEndpoint);

    final data = response.data;
    return (data as List)
        .map((json) => Dynasty.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // ═══════════════════════════════════════════════════════════════
  // 首页域（聚合）
  // ═══════════════════════════════════════════════════════════════

  /// 获取首页聚合数据
  Future<Map<String, dynamic>> getHome() async {
    final response = await _dio.get(ApiConstants.homeEndpoint);
    return response.data as Map<String, dynamic>;
  }

  // ═══════════════════════════════════════════════════════════════
  // AI 域
  // ═══════════════════════════════════════════════════════════════

  /// AI 赏析诗词
  ///
  /// [poemId] 诗词 ID，Gateway 负责查诗+调 AI
  Future<String> analyzePoem(String poemId) async {
    final response = await _dio.post(
      ApiConstants.aiAnalyzeEndpoint,
      data: {'poem_id': poemId},
    );
    // Gateway 返回 { "analysis": "..." } 或直接返回赏析文本
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return data['analysis'] as String? ?? data['content'] as String? ?? '';
    }
    return data as String;
  }

  /// AI 生成配图描述
  ///
  /// [poemId] 诗词 ID，Gateway 负责查诗+生成
  Future<String> generateIllustration(String poemId) async {
    final response = await _dio.post(
      ApiConstants.aiIllustrationEndpoint,
      data: {'poem_id': poemId},
    );
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return data['prompt'] as String? ?? data['content'] as String? ?? '';
    }
    return data as String;
  }

  // ═══════════════════════════════════════════════════════════════
  // 用户域（预留 — 本期不接 UI）
  // ═══════════════════════════════════════════════════════════════

  /// 获取收藏列表
  Future<Map<String, dynamic>> getFavorites() async {
    final response = await _dio.get(ApiConstants.favoritesEndpoint);
    return response.data as Map<String, dynamic>;
  }

  /// 添加收藏
  Future<void> addFavorite(String poemId) async {
    await _dio.post(
      ApiConstants.favoritesEndpoint,
      data: {'poem_id': poemId},
    );
  }

  /// 移除收藏
  Future<void> removeFavorite(String poemId) async {
    await _dio.delete('${ApiConstants.favoritesEndpoint}/$poemId');
  }

  /// 获取阅读历史
  Future<Map<String, dynamic>> getHistory() async {
    final response = await _dio.get(ApiConstants.historyEndpoint);
    return response.data as Map<String, dynamic>;
  }
}
