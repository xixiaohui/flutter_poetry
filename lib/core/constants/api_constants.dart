/// API 端点及配置常量
abstract final class ApiConstants {
  /// Poetry Gateway 基础 URL
  static const String gatewayBaseUrl = 'http://208.167.233.53:8080';

  // ── REST 端点 ──
  static const String poemsEndpoint = '/api/v1/poems';
  static const String poemsSearchEndpoint = '/api/v1/poems/search';
  static const String poemsRandomEndpoint = '/api/v1/poems/random';
  static const String authorsEndpoint = '/api/v1/authors';
  static const String dynastiesEndpoint = '/api/v1/dynasties';

  // ── 聚合端点 ──
  static const String homeEndpoint = '/api/v1/home';

  // ── AI 端点 ──
  static const String aiAnalyzeEndpoint = '/api/v1/ai/analyze';
  static const String aiIllustrationEndpoint = '/api/v1/ai/illustration';

  // ── 用户端点（预留） ──
  static const String favoritesEndpoint = '/api/v1/favorites';
  static const String historyEndpoint = '/api/v1/history';

  // ── 超时配置 ──
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // ── 详情端点 ──
  static String poemDetailEndpoint(String id) => '/api/v1/poems/$id';
  static String authorDetailEndpoint(String id) => '/api/v1/authors/$id';

  // ── 分页默认值 ──
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
