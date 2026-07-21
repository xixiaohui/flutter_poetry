/// API 端点及配置常量
abstract final class ApiConstants {
  /// chinese-poetry-api 基础 URL
  static const String poetryBaseUrl = 'https://poetry.palemoky.com';

  /// DeepSeek API 基础 URL
  static const String deepseekBaseUrl = 'https://api.deepseek.com';

  // ── REST 端点 ──
  static const String poemsEndpoint = '/api/v1/poems';
  static const String poemsSearchEndpoint = '/api/v1/poems/search';
  static const String poemsRandomEndpoint = '/api/v1/poems/random';
  static const String authorsEndpoint = '/api/v1/authors';
  static const String dynastiesEndpoint = '/api/v1/dynasties';

  // ── GraphQL 端点 ──
  static const String graphqlEndpoint = '/graphql';

  // ── 超时配置 ──
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // ── 分页默认值 ──
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
