# Flutter Poetry — Gateway API 层重构设计

**日期：** 2026-07-22
**状态：** 待审核

---

## 一、背景

根据 [架构.md](../../../架构.md) 的 BFF 架构要求，Flutter App 不能直接访问 Chinese Poetry API、AI Provider 或任何第三方后端。所有请求必须经过 Poetry Gateway（`http://208.167.233.53:8080/api/v1`）。

当前 Flutter 项目的分层（UI → Riverpod Provider → Repository → Service → API Client）是合理的，但 API 层存在以下违规：

| 违规项 | 当前行为 | 要求 |
|--------|---------|------|
| `DioClient` | 两个 Dio 实例，分别指向 `poetry.palemoky.com` 和 `api.deepseek.com` | 单一 Dio 指向 Poetry Gateway |
| `PoetryApiClient` | 直接调 Chinese Poetry REST API | 通过 Gateway 中转 |
| `PoetryGraphqlClient` | 直接调 Chinese Poetry GraphQL | Gateway 负责聚合 |
| `DeepSeekApiClient` | 直接调 DeepSeek `/v1/chat/completions` | 通过 Gateway `/api/v1/ai/*` |

---

## 二、设计目标

1. Flutter 端**只**调用 Poetry Gateway（`http://208.167.233.53:8080/api/v1`）
2. 删除所有直接访问第三方 API 的代码
3. 上层（Service / Repository / Provider / UI）改动最小化
4. 保留本地 Isar 缓存能力（离线 fallback）

---

## 三、目标架构

```
UI (features/*/pages + widgets)
  ↓ watch
Riverpod Provider (features/*/providers/)
  ↓ call
Repository (data/repositories/)         ← 业务逻辑边界
  ↓ call
Service (data/services/)                ← 缓存管理 (Isar)
  ↓ call
GatewayApiClient (data/api/)            ← 统一 Gateway 客户端
  ↓
DioClient (core/network/)              ← 单一 Dio 实例
  ↓
Poetry Gateway (http://208.167.233.53:8080)
  ↓
Chinese Poetry API / AI Service / User Service
```

---

## 四、改动详情

### 4.1 `core/constants/api_constants.dart` — 修改

- 删除 `poetryBaseUrl`、`deepseekBaseUrl` 两个独立 base URL
- 新增 `gatewayBaseUrl = 'http://208.167.233.53:8080'`
- 新增 Gateway 专属端点：`/api/v1/home`、`/api/v1/ai/analyze`、`/api/v1/ai/illustration`、`/api/v1/favorites`、`/api/v1/history`
- 删除 `graphqlEndpoint`
- 删除 `deepseekConnectTimeout`、`deepseekReceiveTimeout`（AI 超时由 Gateway 端控制，Flutter 端使用统一超时）
- 保留现有 REST 端点常量（`poemsEndpoint`、`authorsEndpoint` 等，路径与 Gateway 一致）

### 4.2 `core/network/dio_client.dart` — 重写

- 合并 `_poetryDio` + `_deepseekDio` → 单一 `_instance`
- baseUrl 指向 `ApiConstants.gatewayBaseUrl`
- 统一超时（connect 10s, receive 15s）— AI 请求的更长超时由 Gateway 端处理
- 保留 `LogInterceptor` 和 `_ErrorInterceptor`
- 对外暴露 `DioClient.instance`

### 4.3 新建 `data/api/gateway_api_client.dart`

替代 3 个旧客户端，方法按域组织：

**诗词域：**
- `getPoems(page, pageSize, dynasty?, category?)` → `GET /api/v1/poems`
- `getPoemById(id)` → `GET /api/v1/poems/{id}`
- `searchPoems(query, type, page, pageSize)` → `GET /api/v1/poems/search`
- `getRandomPoem(dynasty?, category?)` → `GET /api/v1/poems/random`
- `getPoemsByAuthor(authorId, page, pageSize)` → `GET /api/v1/poems?author={id}`

**作者域：**
- `getAuthors(page, pageSize)` → `GET /api/v1/authors`
- `getAuthorById(id)` → `GET /api/v1/authors/{id}`
- `getDynasties()` → `GET /api/v1/dynasties`

**首页域（聚合）：**
- `getHome()` → `GET /api/v1/home`

**AI 域：**
- `analyzePoem(poemId)` → `POST /api/v1/ai/analyze`
- `generateIllustration(poemId)` → `POST /api/v1/ai/illustration`

**用户域（预留，本期不实现 UI）：**
- `getFavorites()` → `GET /api/v1/favorites`
- `addFavorite(poemId)` → `POST /api/v1/favorites`
- `removeFavorite(poemId)` → `DELETE /api/v1/favorites/{id}`
- `getHistory()` → `GET /api/v1/history`

### 4.4 删除文件（3 个）

- `data/api/poetry_api_client.dart`
- `data/api/poetry_graphql_client.dart`
- `data/api/deepseek_api_client.dart`

### 4.5 Service 层改动（3 个文件）

| 文件 | 改动 |
|------|------|
| `data/services/poem_service.dart` | `PoetryApiClient` → `GatewayApiClient`，缓存逻辑不变 |
| `data/services/author_service.dart` | `PoetryApiClient` → `GatewayApiClient`，逻辑不变 |
| `data/services/ai_service.dart` | `DeepSeekApiClient` → `GatewayApiClient`，调用 `analyzePoem(poemId)` 和 `generateIllustration(poemId)` |

### 4.6 Repository 层改动（1 个文件）

| 文件 | 改动 |
|------|------|
| `data/repositories/ai_repository.dart` | 删除 `configure(apiKey:)` 方法，API Key 由 Gateway 管理 |

其他 Repository 文件不变——它们只依赖 Service，不感知 API 层。

### 4.7 Provider 层 & UI 层 — 零改动

所有 Provider 只依赖 Repository，所有 UI 只 watch Provider。API 层重构对这两层完全透明。

---

## 五、不影响的功能

| 功能 | 说明 |
|------|------|
| 本地收藏（Isar `FavoriteRecord`） | 继续本地存储，`isSynced` 字段保留为将来 Gateway 同步预留 |
| 阅读记录（Isar `ReadingRecord`） | 不变 |
| 诗词缓存（Isar `PoemCache` / `PoemDetailCache`） | API-first + Isar fallback 策略不变 |
| 主题 / 路由 / 动画 / 分享 | 完全不涉及 |
| 生成代码（`.freezed.dart` / `.g.dart`） | 模型不变，无需重新生成 |

---

## 六、改动汇总

| 层 | 文件 | 操作 |
|------|------|------|
| API 常量 | `core/constants/api_constants.dart` | 修改 |
| Dio 客户端 | `core/network/dio_client.dart` | 重写 |
| API 客户端 | `data/api/poetry_api_client.dart` | **删除** |
| API 客户端 | `data/api/poetry_graphql_client.dart` | **删除** |
| API 客户端 | `data/api/deepseek_api_client.dart` | **删除** |
| API 客户端 | `data/api/gateway_api_client.dart` | **新建** |
| Service | `data/services/poem_service.dart` | 修改 import |
| Service | `data/services/author_service.dart` | 修改 import |
| Service | `data/services/ai_service.dart` | 修改 import + 调用签名 |
| Repository | `data/repositories/ai_repository.dart` | 删除 `configure()` |
| 入口 | `lib/main.dart` | 清理注释 |
| Provider | 全部 7 个文件 | 不变 |
| UI | 全部 20+ 个文件 | 不变 |
| 模型 | 全部 6 个 dart 文件 | 不变 |
| 生成代码 | 全部 29 个文件 | 不变 |
| **总计** | **~11 个手写文件** | **删 3 / 建 1 / 改 6 / 不变其余** |

---

## 七、风险与约束

1. **Gateway 端点兼容性** — 假设 Gateway 的响应 JSON 结构与原 Chinese Poetry API 一致。如果有差异，只需调整 `GatewayApiClient` 中的 JSON 解析，不影响上层。
2. **AI 接口格式** — Gateway 的 `/api/v1/ai/analyze` 返回格式可能与原 DeepSeek 直接返回不同（原返回完整 chat completion，Gateway 可能直接返回赏析文本）。调整在 `AiService` 中处理。
3. **性能** — 多加一层 Gateway 会增加网络延迟。Gateway 端应有缓存策略（Redis）来抵消。
4. **离线** — Isar 缓存提供离线 fallback，即使 Gateway 不可达，用户仍可浏览已缓存内容。
