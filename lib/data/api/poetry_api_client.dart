import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/author.dart';
import '../models/dynasty.dart';
import '../models/paginated_response.dart';
import '../models/poem.dart';
import 'search_type.dart';

/// 诗词 API 客户端 — REST 接口
final class PoetryApiClient {
  final Dio _dio = DioClient.poetry;

  /// 获取诗词列表
  ///
  /// [page] 页码 (从 1 开始)
  /// [pageSize] 每页数量
  /// [dynasty] 按朝代过滤
  /// [category] 按分类过滤
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

  /// 获取朝代列表
  Future<List<Dynasty>> getDynasties() async {
    final response = await _dio.get(ApiConstants.dynastiesEndpoint);

    final data = response.data;
    return (data as List)
        .map((json) => Dynasty.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// 获取单首诗词详情
  Future<Poem> getPoemById(String id) async {
    final response = await _dio.get('/api/v1/poems/$id');
    return Poem.fromJson(response.data as Map<String, dynamic>);
  }

  /// 获取作者详情
  Future<Author> getAuthorById(String id) async {
    final response = await _dio.get('/api/v1/authors/$id');
    return Author.fromJson(response.data as Map<String, dynamic>);
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
}
