# Gateway API 层重构 实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将 Flutter 端 API 层从直接访问 Chinese Poetry API + DeepSeek API，重构为统一通过 Poetry Gateway (`http://208.167.233.53:8080/api/v1`) 调用。

**Architecture:** 删除 3 个旧 API 客户端（PoetryApiClient、DeepSeekApiClient、PoetryGraphqlClient），新建 1 个统一 GatewayApiClient。DioClient 合并为单一 Dio 实例。Service 层替换 import。AiRepository 去 API Key 配置。Provider/UI 层零改动。

**Tech Stack:** Dart 3.12, Flutter 3.44, Dio, Riverpod, Isar

## Global Constraints

- 单一 Gateway base URL: `http://208.167.233.53:8080`
- 所有 API 路径以 `/api/v1/` 为前缀
- Provider 层和 UI 层不做任何改动
- 本地 Isar 缓存策略保持不变
- Gateway 响应 JSON 结构与原 Chinese Poetry API 保持一致
- AI 端点只需传 poemId，Gateway 负责查诗+调 AI
- 设计文档: `docs/superpowers/specs/2026-07-22-gateway-refactor-design.md`

---

### Task 1: 更新 API 常量

**Files:**
- Modify: `lib/core/constants/api_constants.dart`

**Interfaces:**
- Produces: `ApiConstants.gatewayBaseUrl`, `ApiConstants.homeEndpoint`, `ApiConstants.aiAnalyzeEndpoint`, `ApiConstants.aiIllustrationEndpoint`, `ApiConstants.favoritesEndpoint`, `ApiConstants.historyEndpoint`
- Removes: `poetryBaseUrl`, `deepseekBaseUrl`, `graphqlEndpoint`, `deepseekConnectTimeout`, `deepseekReceiveTimeout`

- [ ] **Step 1: 重写 api_constants.dart**

```dart
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
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/constants/api_constants.dart
git commit -m "refactor: update API constants for Poetry Gateway"
```

---

### Task 2: 重写 DioClient 为单一实例

**Files:**
- Modify: `lib/core/network/dio_client.dart`

**Interfaces:**
- Consumes: `ApiConstants.gatewayBaseUrl`, `ApiConstants.connectTimeout`, `ApiConstants.receiveTimeout` (from Task 1)
- Produces: `DioClient.instance` (single Dio)

- [ ] **Step 1: 重写 dio_client.dart**

```dart
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

/// Dio HTTP 客户端单例 — 统一指向 Poetry Gateway
final class DioClient {
  DioClient._();

  static final Dio _instance = _createDio();

  /// 共享 Dio 实例
  static Dio get instance => _instance;

  static Dio _createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.gatewayBaseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.addAll([
      LogInterceptor(),
      _ErrorInterceptor(),
    ]);

    return dio;
  }
}

/// 错误拦截器 — 统一错误处理
final class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          message: '网络连接超时，请检查网络后重试',
          error: err.error,
          stackTrace: err.stackTrace,
        );
      case DioExceptionType.connectionError:
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          message: '网络不可用，请检查网络连接',
          error: err.error,
          stackTrace: err.stackTrace,
        );
      default:
        break;
    }
    handler.next(err);
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add lib/core/network/dio_client.dart
git commit -m "refactor: merge DioClient into single instance for Gateway"
```

---

### Task 3: 创建 GatewayApiClient

**Files:**
- Create: `lib/data/api/gateway_api_client.dart`

**Interfaces:**
- Consumes: `DioClient.instance` (from Task 2), `ApiConstants.*` (from Task 1), all model classes (`Poem`, `Author`, `Dynasty`, `PaginatedResponse`), `SearchType`
- Produces: `GatewayApiClient` — final class with all endpoint methods organized by domain

- [ ] **Step 1: 创建 gateway_api_client.dart**

```dart
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
```

- [ ] **Step 2: Verify the file compiles**

```bash
cd e:\workspace\claw\flutter_poetry && dart analyze lib/data/api/gateway_api_client.dart 2>&1
```

Expected: No errors (may have unused import warnings for user-domain methods which is expected).

- [ ] **Step 3: Commit**

```bash
git add lib/data/api/gateway_api_client.dart
git commit -m "feat: add unified GatewayApiClient replacing 3 old clients"
```

---

### Task 4: 更新 PoemService

**Files:**
- Modify: `lib/data/services/poem_service.dart`

**Interfaces:**
- Consumes: `GatewayApiClient` (from Task 3)
- Produces: `PoemService` — unchanged public API, internal client reference changed

- [ ] **Step 1: 修改 poem_service.dart**

Change the import and field:

```dart
// OLD import:
import '../api/poetry_api_client.dart';
// NEW import:
import '../api/gateway_api_client.dart';
```

```dart
// OLD field:
final PoetryApiClient _api = PoetryApiClient();
// NEW field:
final GatewayApiClient _api = GatewayApiClient();
```

All other code remains identical — method signatures, caching logic, everything.

- [ ] **Step 2: Verify compilation**

```bash
cd e:\workspace\claw\flutter_poetry && dart analyze lib/data/services/poem_service.dart 2>&1
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add lib/data/services/poem_service.dart
git commit -m "refactor: switch PoemService from PoetryApiClient to GatewayApiClient"
```

---

### Task 5: 更新 AuthorService

**Files:**
- Modify: `lib/data/services/author_service.dart`

**Interfaces:**
- Consumes: `GatewayApiClient` (from Task 3)
- Produces: `AuthorService` — unchanged public API

- [ ] **Step 1: 修改 author_service.dart**

```dart
// OLD import:
import '../api/poetry_api_client.dart';
// NEW import:
import '../api/gateway_api_client.dart';
```

```dart
// OLD field:
final PoetryApiClient _api = PoetryApiClient();
// NEW field:
final GatewayApiClient _api = GatewayApiClient();
```

All other code remains identical.

- [ ] **Step 2: Verify compilation**

```bash
cd e:\workspace\claw\flutter_poetry && dart analyze lib/data/services/author_service.dart 2>&1
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add lib/data/services/author_service.dart
git commit -m "refactor: switch AuthorService from PoetryApiClient to GatewayApiClient"
```

---

### Task 6: 更新 AiService

**Files:**
- Modify: `lib/data/services/ai_service.dart`

**Interfaces:**
- Consumes: `GatewayApiClient` (from Task 3)
- Produces: `AIService` — changed internal, public methods keep same signatures but delegate to Gateway (poemId-based)

- [ ] **Step 1: 重写 ai_service.dart**

```dart
import '../api/gateway_api_client.dart';
import '../models/poem.dart';

/// AI 服务 — 通过 Poetry Gateway 调用 AI
final class AIService {
  final GatewayApiClient _client = GatewayApiClient();

  /// AI 赏析
  ///
  /// 签名保持接收 [Poem] 以兼容上层，内部提取 poemId 调用 Gateway。
  Future<String> analyze(Poem poem) async {
    return _client.analyzePoem(poem.id);
  }

  /// AI 配图 prompt
  ///
  /// 签名保持接收 [Poem] 以兼容上层，内部提取 poemId 调用 Gateway。
  Future<String> generateIllustrationPrompt(Poem poem) async {
    return _client.generateIllustration(poem.id);
  }
}
```

Note: `configure()` 方法和 `setApiKey()` 调用已删除 — API Key 现在由 Gateway 统一管理。

- [ ] **Step 2: Verify compilation**

```bash
cd e:\workspace\claw\flutter_poetry && dart analyze lib/data/services/ai_service.dart 2>&1
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add lib/data/services/ai_service.dart
git commit -m "refactor: switch AiService to GatewayApiClient, remove direct DeepSeek access"
```

---

### Task 7: 更新 AiRepository — 删除 configure()

**Files:**
- Modify: `lib/data/repositories/ai_repository.dart`
- Modify (auto): `lib/data/repositories/ai_repository.g.dart` — regenerated by build_runner in Task 10

**Interfaces:**
- Consumes: `AIService` (from Task 6)
- Produces: `AiRepository` — `configure()` removed, `analyzePoem(Poem)` and `generateIllustration(Poem)` unchanged

- [ ] **Step 1: 修改 ai_repository.dart**

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/poem.dart';
import '../services/ai_service.dart';

part 'ai_repository.g.dart';

@riverpod
AiRepository aiRepository(aiRepositoryRef) => AiRepository();

final class AiRepository {
  final AIService _service = AIService();

  /// AI 赏析诗词
  Future<String> analyzePoem(Poem poem) async {
    return _service.analyze(poem);
  }

  /// 生成配图 prompt
  Future<String> generateIllustration(Poem poem) async {
    return _service.generateIllustrationPrompt(poem);
  }
}
```

Changes:
- Removed `configure({required String apiKey})` method entirely
- Removed `_service.configure(apiKey: apiKey)` call
- `analyzePoem` and `generateIllustration` signatures unchanged

- [ ] **Step 2: Verify compilation**

```bash
cd e:\workspace\claw\flutter_poetry && dart analyze lib/data/repositories/ai_repository.dart 2>&1
```

Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add lib/data/repositories/ai_repository.dart
git commit -m "refactor: remove configure() from AiRepository — API key now managed by Gateway"
```

---

### Task 8: 清理 main.dart

**Files:**
- Modify: `lib/main.dart`

**Interfaces:**
- Produces: Clean entry point without DeepSeek API key references

- [ ] **Step 1: 修改 main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDatabase.instance.init();

  runApp(
    const ProviderScope(
      child: PoetryApp(),
    ),
  );
}
```

Change: Removed the `// TODO: await AiRepository.configure(apiKey: ...)` comment.

- [ ] **Step 2: Commit**

```bash
git add lib/main.dart
git commit -m "chore: remove DeepSeek API key TODO from main.dart"
```

---

### Task 9: 删除旧 API 客户端文件

**Files:**
- Delete: `lib/data/api/poetry_api_client.dart`
- Delete: `lib/data/api/poetry_graphql_client.dart`
- Delete: `lib/data/api/deepseek_api_client.dart`

- [ ] **Step 1: 删除文件**

```bash
cd e:\workspace\claw\flutter_poetry
rm lib/data/api/poetry_api_client.dart
rm lib/data/api/poetry_graphql_client.dart
rm lib/data/api/deepseek_api_client.dart
```

- [ ] **Step 2: 验证全项目分析通过**

```bash
cd e:\workspace\claw\flutter_poetry && dart analyze lib/ 2>&1
```

Expected: No errors. All references to deleted files have been replaced in Tasks 4-8.

- [ ] **Step 3: Commit**

```bash
git add lib/data/api/poetry_api_client.dart lib/data/api/poetry_graphql_client.dart lib/data/api/deepseek_api_client.dart
git commit -m "refactor: remove old API clients (PoetryApi, PoetryGraphql, DeepSeek)"
```

---

### Task 10: 重新生成构建代码

**Files:**
- Regenerate: `lib/data/repositories/ai_repository.g.dart`

- [ ] **Step 1: 运行 build_runner**

```bash
cd e:\workspace\claw\flutter_poetry && dart run build_runner build --delete-conflicting-outputs 2>&1
```

Expected: Build succeeds, `ai_repository.g.dart` regenerated without the `configure` method.

- [ ] **Step 2: Commit**

```bash
git add lib/data/repositories/ai_repository.g.dart
git commit -m "chore: regenerate build files after AiRepository changes"
```

---

### Task 11: 最终验证

- [ ] **Step 1: 全项目静态分析**

```bash
cd e:\workspace\claw\flutter_poetry && dart analyze lib/ 2>&1
```

Expected: `No issues found!`

- [ ] **Step 2: 运行测试**

```bash
cd e:\workspace\claw\flutter_poetry && flutter test 2>&1
```

Expected: All tests pass.

- [ ] **Step 3: 确认文件结构**

```bash
cd e:\workspace\claw\flutter_poetry && ls lib/data/api/
```

Expected output:
```
gateway_api_client.dart
search_type.dart
```

- [ ] **Step 4: 最终提交**

```bash
git add -A
git commit -m "chore: final verification — all analysis and tests passing"
```
