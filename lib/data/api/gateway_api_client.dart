import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/api_models.dart';

/// Unified Poetry Gateway API client.
///
/// All Flutter network requests go through this single client.
/// DioClient.instance handles auth injection and response parsing automatically.
///
/// 27 endpoints organized by domain:
/// - Aggregation (7): getHome, getDiscover, getCategories, getRecommend,
///   getQuote, getSolarTerm, getConfig
/// - Poems (4): getPoems, getPoemById, getRandomPoem, search
/// - Authors (2): getAuthors, getAuthorById
/// - AI (3): analyzePoem, askQuestion, translatePoem (auth required)
/// - User (4): register, login, getProfile, updateProfile
/// - Favorites (4): getFavorites, addFavorite, removeFavorite, syncFavorites
/// - History (2): getHistory, recordReading
/// - Stats (1): getReadingStats
final class GatewayApiClient {
  final Dio _dio = DioClient.instance;
  String? _token;

  // ── JWT Management ──────────────────────────────────────────────

  /// Whether a JWT token is currently held in memory.
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;

  /// Load persisted token from SharedPreferences (call once at app start).
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(DioClient.tokenKey);
  }

  /// Persist token to SharedPreferences and hold in memory.
  Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(DioClient.tokenKey, token);
  }

  /// Remove token from memory and SharedPreferences.
  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(DioClient.tokenKey);
  }

  // ═══════════════════════════════════════════════════════════════
  // Aggregation (7)
  // ═══════════════════════════════════════════════════════════════

  /// GET /api/v1/home — featured poem + author + stats.
  Future<HomeData> getHome() async {
    final response = await _dio.get(ApiConstants.homeEndpoint);
    return HomeData.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/discover — recent poems + dynasties + types.
  Future<DiscoverData> getDiscover() async {
    final response = await _dio.get(ApiConstants.discoverEndpoint);
    return DiscoverData.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/categories — all dynasties + types, cached 1h.
  Future<Map<String, List<CategoryItem>>> getCategories() async {
    final response = await _dio.get(ApiConstants.categoriesEndpoint);
    final data = response.data as Map<String, dynamic>;
    return {
      'dynasties': (data['dynasties'] as List)
          .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      'types': (data['types'] as List)
          .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    };
  }

  /// GET /api/v1/recommend — recommended poems with reason.
  Future<RecommendData> getRecommend() async {
    final response = await _dio.get(ApiConstants.recommendEndpoint);
    return RecommendData.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/quote — daily quote, same all day (cached).
  Future<DailyQuote> getQuote() async {
    final response = await _dio.get(ApiConstants.quoteEndpoint);
    return DailyQuote.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/solar-term — seasonal poem recommendation.
  Future<SolarTermData> getSolarTerm() async {
    final response = await _dio.get(ApiConstants.solarTermEndpoint);
    return SolarTermData.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/config — version, banners, feature flags.
  Future<AppConfig> getConfig() async {
    final response = await _dio.get(ApiConstants.configEndpoint);
    return AppConfig.fromJson(response.data as Map<String, dynamic>);
  }

  // ═══════════════════════════════════════════════════════════════
  // Poems (4)
  // ═══════════════════════════════════════════════════════════════

  /// GET /api/v1/poems — paginated poem list with optional filters.
  Future<ApiPaginatedResponse<ApiPoem>> getPoems({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
    String? dynasty,
    String? type,
    String? author,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'pageSize': pageSize,
    };
    if (dynasty != null) queryParams['dynasty'] = dynasty;
    if (type != null) queryParams['type'] = type;
    if (author != null) queryParams['author'] = author;

    final response = await _dio.get(
      ApiConstants.poemsEndpoint,
      queryParameters: queryParams,
    );
    return ApiPaginatedResponse.fromJson(
      response.data as Map<String, dynamic>,
      ApiPoem.fromJson,
      dataKey: 'poems',
    );
  }

  /// GET /api/v1/poems/:id — single poem detail.
  Future<ApiPoem> getPoemById(int id) async {
    final response = await _dio.get(ApiConstants.poemDetailEndpoint(id));
    return ApiPoem.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/poems/random — random poem, supports feihualing.
  Future<ApiPoem> getRandomPoem({
    String? author,
    String? type,
    String? dynasty,
    String? char,
  }) async {
    final queryParams = <String, dynamic>{};
    if (author != null) queryParams['author'] = author;
    if (type != null) queryParams['type'] = type;
    if (dynasty != null) queryParams['dynasty'] = dynasty;
    if (char != null) queryParams['char'] = char;

    final response = await _dio.get(
      ApiConstants.poemsRandomEndpoint,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
    return ApiPoem.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/search — full-text search with optional type filter.
  Future<ApiPaginatedResponse<ApiPoem>> search({
    required String q,
    String? type,
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    final queryParams = <String, dynamic>{
      'q': q,
      'page': page,
      'pageSize': pageSize,
    };
    if (type != null) queryParams['type'] = type;

    final response = await _dio.get(
      ApiConstants.searchEndpoint,
      queryParameters: queryParams,
    );
    return ApiPaginatedResponse.fromJson(
      response.data as Map<String, dynamic>,
      ApiPoem.fromJson,
      dataKey: 'poems',
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Authors (2)
  // ═══════════════════════════════════════════════════════════════

  /// GET /api/v1/authors — paginated author list.
  Future<ApiPaginatedResponse<HomeAuthor>> getAuthors({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    final response = await _dio.get(
      ApiConstants.authorsEndpoint,
      queryParameters: {'page': page, 'pageSize': pageSize},
    );
    return ApiPaginatedResponse.fromJson(
      response.data as Map<String, dynamic>,
      HomeAuthor.fromJson,
      dataKey: 'authors',
    );
  }

  /// GET /api/v1/authors/:id — author detail.
  Future<HomeAuthor> getAuthorById(int id) async {
    final response = await _dio.get(ApiConstants.authorDetailEndpoint(id));
    return HomeAuthor.fromJson(response.data as Map<String, dynamic>);
  }

  // ═══════════════════════════════════════════════════════════════
  // AI (3, auth required)
  // ═══════════════════════════════════════════════════════════════

  /// POST /api/v1/ai/analyse — AI poem analysis.
  ///
  /// Requires auth. Rate limited to 5 requests/minute.
  Future<AIAnalysisData> analyzePoem({
    required String title,
    required String content,
    String? author,
    String? dynasty,
  }) async {
    final body = <String, dynamic>{
      'title': title,
      'content': content,
    };
    if (author != null) body['author'] = author;
    if (dynasty != null) body['dynasty'] = dynasty;

    final response =
        await _dio.post(ApiConstants.aiAnalyseEndpoint, data: body);
    return AIAnalysisData.fromJson(response.data as Map<String, dynamic>);
  }

  /// POST /api/v1/ai/ask — AI Q&A about poetry.
  ///
  /// Requires auth. Rate limited to 5 requests/minute.
  Future<AIAnswer> askQuestion({
    required String question,
    String? context,
  }) async {
    final body = <String, dynamic>{'question': question};
    if (context != null) body['context'] = context;

    final response = await _dio.post(ApiConstants.aiAskEndpoint, data: body);
    return AIAnswer.fromJson(response.data as Map<String, dynamic>);
  }

  /// POST /api/v1/ai/translate — AI poem translation (en/ja/ko).
  ///
  /// Requires auth. Rate limited to 5 requests/minute.
  Future<AITranslation> translatePoem({
    required String content,
    String targetLang = 'en',
  }) async {
    final response = await _dio.post(
      ApiConstants.aiTranslateEndpoint,
      data: {'content': content, 'targetLang': targetLang},
    );
    return AITranslation.fromJson(response.data as Map<String, dynamic>);
  }

  // ═══════════════════════════════════════════════════════════════
  // User (4)
  // ═══════════════════════════════════════════════════════════════

  /// POST /api/v1/user/register — register and auto-persist JWT token.
  Future<LoginData> register({
    required String email,
    required String password,
    String? name,
  }) async {
    final body = <String, dynamic>{
      'email': email,
      'password': password,
    };
    if (name != null) body['name'] = name;

    final response =
        await _dio.post(ApiConstants.userRegisterEndpoint, data: body);
    final loginData =
        LoginData.fromJson(response.data as Map<String, dynamic>);
    await setToken(loginData.token);
    return loginData;
  }

  /// POST /api/v1/user/login — login and auto-persist JWT token.
  Future<LoginData> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.userLoginEndpoint,
      data: {'email': email, 'password': password},
    );
    final loginData =
        LoginData.fromJson(response.data as Map<String, dynamic>);
    await setToken(loginData.token);
    return loginData;
  }

  /// GET /api/v1/user/profile — current user info.
  ///
  /// Requires auth.
  Future<UserData> getProfile() async {
    final response = await _dio.get(ApiConstants.userProfileEndpoint);
    return UserData.fromJson(response.data as Map<String, dynamic>);
  }

  /// PUT /api/v1/user/profile — update name / avatar.
  ///
  /// Requires auth.
  Future<UserData> updateProfile({String? name, String? avatar}) async {
    final body = <String, dynamic>{};
    if (name != null) body['name'] = name;
    if (avatar != null) body['avatar'] = avatar;

    final response =
        await _dio.put(ApiConstants.userProfileEndpoint, data: body);
    return UserData.fromJson(response.data as Map<String, dynamic>);
  }

  // ═══════════════════════════════════════════════════════════════
  // Favorites (4, auth required)
  // ═══════════════════════════════════════════════════════════════

  /// GET /api/v1/favorites — list favorites + total.
  ///
  /// Requires auth.
  Future<({List<FavoriteItem> favorites, int total})> getFavorites() async {
    final response = await _dio.get(ApiConstants.favoritesEndpoint);
    final data = response.data as Map<String, dynamic>;
    return (
      favorites: (data['favorites'] as List)
          .map((e) => FavoriteItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: data['total'] as int,
    );
  }

  /// POST /api/v1/favorites — add a poem to favorites.
  ///
  /// Requires auth. [poemId] is sent as string per API contract.
  Future<void> addFavorite({
    required int poemId,
    required String poemTitle,
    String? poemAuthor,
    String? poemDynasty,
  }) async {
    final body = <String, dynamic>{
      'poemId': poemId.toString(),
      'poemTitle': poemTitle,
    };
    if (poemAuthor != null) body['poemAuthor'] = poemAuthor;
    if (poemDynasty != null) body['poemDynasty'] = poemDynasty;

    await _dio.post(ApiConstants.favoritesEndpoint, data: body);
  }

  /// DELETE /api/v1/favorites/:poemId — remove a favorite.
  ///
  /// Requires auth.
  Future<void> removeFavorite(int poemId) async {
    await _dio.delete(ApiConstants.favoriteDeleteEndpoint(poemId));
  }

  /// GET /api/v1/favorites/sync — sync favorites for multi-device.
  ///
  /// Requires auth. Returns syncToken (latest updatedAt) for change detection.
  Future<({
    List<FavoriteItem> favorites,
    String syncToken,
    int total,
  })> syncFavorites() async {
    final response = await _dio.get(ApiConstants.favoritesSyncEndpoint);
    final data = response.data as Map<String, dynamic>;
    return (
      favorites: (data['favorites'] as List)
          .map((e) => FavoriteItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      syncToken: data['syncToken'] as String,
      total: data['total'] as int,
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // History (2, auth required)
  // ═══════════════════════════════════════════════════════════════

  /// GET /api/v1/history — reading history, last 50 records (reverse-chronological).
  ///
  /// Requires auth.
  Future<({List<HistoryItem> records, int total})> getHistory() async {
    final response = await _dio.get(ApiConstants.historyEndpoint);
    final data = response.data as Map<String, dynamic>;
    return (
      records: (data['records'] as List)
          .map((e) => HistoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: data['total'] as int,
    );
  }

  /// POST /api/v1/history — record a poem reading (creates new record each time).
  ///
  /// Requires auth. [poemId] is sent as string per API contract.
  Future<void> recordReading({
    required int poemId,
    required String poemTitle,
    String? poemAuthor,
    String? poemDynasty,
  }) async {
    final body = <String, dynamic>{
      'poemId': poemId.toString(),
      'poemTitle': poemTitle,
    };
    if (poemAuthor != null) body['poemAuthor'] = poemAuthor;
    if (poemDynasty != null) body['poemDynasty'] = poemDynasty;

    await _dio.post(ApiConstants.historyEndpoint, data: body);
  }

  // ═══════════════════════════════════════════════════════════════
  // Stats (1)
  // ═══════════════════════════════════════════════════════════════

  /// GET /api/v1/stats/reading — global reading stats dashboard.
  Future<ReadingStatsData> getReadingStats() async {
    final response = await _dio.get(ApiConstants.statsReadingEndpoint);
    return ReadingStatsData.fromJson(response.data as Map<String, dynamic>);
  }
}
