import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/poem.dart';

/// 诗词 API GraphQL 客户端 — 用于复杂聚合查询
final class PoetryGraphqlClient {
  final Dio _dio = DioClient.poetry;

  /// 获取统计数据 (总诗词数、总作者数、按朝代分布)
  Future<Map<String, dynamic>> getStatistics() async {
    const query = '''
      query {
        statistics {
          totalPoems
          totalAuthors
          poemsByDynasty {
            dynasty { name }
            count
          }
        }
      }
    ''';

    final response = await _dio.post(
      ApiConstants.graphqlEndpoint,
      data: {'query': query},
    );

    _checkGraphQlErrors(response.data);

    return response.data['data']['statistics'] as Map<String, dynamic>;
  }

  /// 按朝代获取诗词
  Future<List<Poem>> getPoemsByDynasty(String dynastyId) async {
    final query = '''
      query(\$dynastyId: ID!) {
        poemsByDynasty(dynastyId: \$dynastyId) {
          edges {
            node {
              id title content translation
              author { id name dynasty { id name } }
              dynasty { id name }
              category
            }
          }
        }
      }
    ''';

    final response = await _dio.post(
      ApiConstants.graphqlEndpoint,
      data: {
        'query': query,
        'variables': {'dynastyId': dynastyId},
      },
    );

    _checkGraphQlErrors(response.data);

    final edges =
        response.data['data']['poemsByDynasty']['edges'] as List;
    return edges
        .map((edge) =>
            Poem.fromJson(edge['node'] as Map<String, dynamic>))
        .toList();
  }

  /// 检查 GraphQL 响应中是否存在 errors
  void _checkGraphQlErrors(Map<String, dynamic> data) {
    if (data['errors'] != null) {
      final errors = data['errors'] as List;
      final message = errors.map((e) => e['message']).join('; ');
      throw Exception('GraphQL error: $message');
    }
  }
}
