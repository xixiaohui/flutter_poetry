/// API 端点及配置常量
abstract final class ApiConstants {
  /// Poetry Gateway 基础 URL (生产环境)
  static const String baseUrl = 'https://www.chinesepoetry.space';

  // ── 聚合端点 ──
  static const String homeEndpoint = '/api/v1/home';
  static const String discoverEndpoint = '/api/v1/discover';
  static const String categoriesEndpoint = '/api/v1/categories';
  static const String recommendEndpoint = '/api/v1/recommend';
  static const String quoteEndpoint = '/api/v1/quote';
  static const String solarTermEndpoint = '/api/v1/solar-term';
  static const String configEndpoint = '/api/v1/config';

  // ── 诗词端点 ──
  static const String poemsEndpoint = '/api/v1/poems';
  static const String poemsRandomEndpoint = '/api/v1/poems/random';

  // ── 作者端点 ──
  static const String authorsEndpoint = '/api/v1/authors';

  // ── 搜索端点 ──
  static const String searchEndpoint = '/api/v1/search';

  // ── AI 端点 (需认证, 限流 5次/分钟) ──
  static const String aiAnalyseEndpoint = '/api/v1/ai/analyse';
  static const String aiAskEndpoint = '/api/v1/ai/ask';
  static const String aiTranslateEndpoint = '/api/v1/ai/translate';

  // ── 用户端点 ──
  static const String userRegisterEndpoint = '/api/v1/user/register';
  static const String userLoginEndpoint = '/api/v1/user/login';
  static const String userProfileEndpoint = '/api/v1/user/profile';

  // ── 收藏端点 (需认证) ──
  static const String favoritesEndpoint = '/api/v1/favorites';
  static const String favoritesSyncEndpoint = '/api/v1/favorites/sync';

  // ── 历史端点 (需认证) ──
  static const String historyEndpoint = '/api/v1/history';

  // ── 统计端点 ──
  static const String statsReadingEndpoint = '/api/v1/stats/reading';

  // ── 超时配置 ──
  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // ── 参数化端点 ──
  static String poemDetailEndpoint(int id) => '/api/v1/poems/$id';
  static String authorDetailEndpoint(int id) => '/api/v1/authors/$id';
  static String favoriteDeleteEndpoint(int poemId) =>
      '/api/v1/favorites/$poemId';

  // ── 分页默认值 ──
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
