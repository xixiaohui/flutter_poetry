# Poetry Gateway API 全面接入 — 实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) to implement this plan task-by-task. Steps use checkbox syntax.

**Goal:** 将 api.md 定义的 27 个 Poetry Gateway API 端点全部接入 Flutter 客户端，补全所有占位页面。

**Architecture:** BFF — Flutter → Riverpod → Repository → Service → GatewayApiClient → Dio → Gateway。Service 层转换 API 扁平 JSON ↔ 现有 UI 嵌套模型。

**Tech Stack:** Flutter 3.44 + Dart 3.12 + Riverpod + GoRouter + Dio + Freezed + Isar

## Global Constraints

- Flutter 只能调用 `https://www.chinesepoetry.space/api/v1/*`
- API 参数使用 api.md 规范 (camelCase: `pageSize`, `targetLang`)
- 现有 UI 模型 (Poem/Author/Dynasty) 保持不变，Service 层做新旧格式转换
- AI 接口需认证且有 5次/分钟限流
- 收藏/历史采用服务端为主 + Isar 本地副本双写策略
- pubspec.yaml 不新增第三方依赖

---

## Phase 1: 数据基础层 (Tasks 1-9)

### Task 1: 更新 API 常量与端点配置

**Files:** Modify: `lib/core/constants/api_constants.dart`, `lib/data/api/search_type.dart`

**Actions:**
- [ ] 重写 `api_constants.dart`：baseUrl 改为 `https://www.chinesepoetry.space`，新增全部 27 端点路径常量
- [ ] 更新 `search_type.dart`：SearchType 枚举值改为 all/title/content/author，添加 `String get apiValue`
- [ ] 验证: `dart analyze lib/core/constants/ lib/data/api/search_type.dart`

**Details:** 完整代码见设计文档 2.1 节。关键：poemDetailEndpoint(int id), authorDetailEndpoint(int id), favoriteDeleteEndpoint(int poemId)。

---

### Task 2: 创建 API 响应数据模型

**Files:** Create: `lib/data/models/api_models.dart`

**Actions:**
- [ ] 创建文件，包含所有 api.md JSON 对应的 plain Dart 类（纯手动 fromJson，不用 Freezed）：
  - ApiPoem, HomeData, HomeAuthor, DiscoverData, CategoryItem
  - DailyQuote, SolarTermData, AppConfig, BannerItem, FeatureFlags, RecommendData
  - AIAnalysisData, AIAnswer, AITranslation
  - ReadingStatsData, TopStatItem, DailyCount
  - FavoriteItem, HistoryItem, LoginData, UserData
  - ApiPaginatedResponse<T>
- [ ] 验证: `dart analyze lib/data/models/api_models.dart`

**Details:** 完整代码见设计文档 2.4 节。每个类包含 const 构造函数 + `factory fromJson(Map<String, dynamic> json)`。

---

### Task 3: 升级 Dio 客户端

**Files:** Create: `lib/core/network/auth_event_bus.dart`, Modify: `lib/core/network/dio_client.dart`, Modify: `pubspec.yaml`

**Actions:**
- [ ] 在 pubspec.yaml 添加 `shared_preferences: ^2.3.5`
- [ ] 创建 `auth_event_bus.dart`：全局 Stream 单例用于广播 401 事件
- [ ] 重写 `dio_client.dart`：
  - AuthInterceptor: 每次请求从 SharedPreferences 读取 token 注入 Authorization header
  - ResponseParserInterceptor: 解析 `{success, data}` 统一响应格式，success=false 时 reject
  - ErrorInterceptor: 中文错误提示 + 401 时 fire AuthEventBus + 清除 token
- [ ] 验证: `dart analyze lib/core/network/`

**Details:** 完整代码见设计文档 Task 3。

---

### Task 4: 重写 GatewayApiClient

**Files:** Rewrite: `lib/data/api/gateway_api_client.dart`

**Actions:**
- [ ] 重写整个文件，按域组织 27 个方法：
  - 聚合域 (7): getHome → HomeData, getDiscover → DiscoverData, getCategories, getRecommend, getQuote, getSolarTerm, getConfig
  - 诗词域 (4): getPoems({page, pageSize, dynasty, type, author}), getPoemById(int), getRandomPoem, search({q, type, page, pageSize})
  - 作者域 (2): getAuthors({page, pageSize}), getAuthorById(int)
  - AI域 (3): analyzePoem, askQuestion, translatePoem (均需认证)
  - 用户域 (4): register, login (自动 setToken), getProfile, updateProfile
  - 收藏域 (4): getFavorites, addFavorite, removeFavorite, syncFavorites
  - 历史域 (2): getHistory, recordReading
  - 统计域 (1): getReadingStats
- [ ] 添加 JWT 管理: `init()`, `setToken()`, `clearToken()`, `isLoggedIn`
- [ ] 验证: `dart analyze lib/data/api/gateway_api_client.dart`

**Details:** 完整代码见设计文档 Task 4。login/register 成功后自动调用 setToken 持久化 token。

---

### Task 5: 创建 AuthService + AuthRepository

**Files:** Create: `lib/data/services/auth_service.dart`, `lib/data/repositories/auth_repository.dart`

**Actions:**
- [ ] 创建 AuthService: login/register/logout/getProfile/updateProfile/init/isLoggedIn
- [ ] 创建 AuthRepository (@riverpod): build 时 init + 尝试 getProfile，提供 login/register/logout/updateProfile 方法
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`
- [ ] 验证生成 `auth_repository.g.dart` 无错误

---

### Task 6: 创建 Services 层 (5 个新 Service)

**Files:** Create:
- `lib/data/services/discover_service.dart`
- `lib/data/services/favorites_service.dart`
- `lib/data/services/history_service.dart`
- `lib/data/services/stats_service.dart`
- `lib/data/services/config_service.dart`

**Actions:**
- [ ] DiscoverService: getDiscover, getCategories, getRecommend, getPoems
- [ ] FavoritesService: CRUD + syncFavorites + startAutoSync(Timer.periodic 5分钟)/stopAutoSync
- [ ] HistoryService: getHistory, recordReading
- [ ] StatsService: getReadingStats
- [ ] ConfigService: getConfig (内存缓存 1 小时 TTL)
- [ ] 验证: `dart analyze lib/data/services/`

---

### Task 7: 创建 Repositories 层 (5 个新 Repository)

**Files:** Create:
- `lib/data/repositories/discover_repository.dart`
- `lib/data/repositories/favorites_repository.dart`
- `lib/data/repositories/history_repository.dart`
- `lib/data/repositories/stats_repository.dart`
- `lib/data/repositories/config_repository.dart`

**Actions:**
- [ ] discoverRepository: discoverDataProvider (Future), recommendProvider (Future)
- [ ] favoritesRepository: FavoritesRepository (@riverpod class) — build 检查登录状态，add/remove/invalidate
- [ ] historyRepository: HistoryRepository (@riverpod class) — build 检查登录状态
- [ ] statsRepository: readingStatsProvider (Future)
- [ ] configRepository: appConfigProvider (Future)
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`
- [ ] 验证 5 个 .g.dart 生成无错误

**Details:** 完整代码见设计文档 Task 7。

---

### Task 8: 更新 AI Service + Repository

**Files:** Modify: `lib/data/services/ai_service.dart`, `lib/data/repositories/ai_repository.dart`

**Actions:**
- [ ] ai_service: 改为返回 AIAnalysisData/AIAnswer/AITranslation，方法签名对齐新 GatewayApiClient
- [ ] ai_repository: analyzePoem(title, content, author?, dynasty?), askQuestion(question, context?), translatePoem(content, targetLang?)
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

### Task 9: 更新 PoemService + AuthorService + PoemRepository

**Files:** Modify: `lib/data/services/poem_service.dart`, `lib/data/services/author_service.dart`, `lib/data/repositories/poem_repository.dart`

**Actions:**
- [ ] poem_service: 添加 `_apiPoemToPoem(ApiPoem)` 转换方法；getPoems 参数 `category` → `type`；searchPoems 改用新 search 方法
- [ ] author_service: 添加 `_homeAuthorToAuthor(HomeAuthor)` 转换方法
- [ ] poem_repository: 新增 `addServerFavorite`, `removeServerFavorite`, `recordServerReading` 委托方法
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

## Phase 2: 认证 + 路由 (Tasks 10-11)

### Task 10: 创建认证 UI (LoginPage)

**Files:** Create: `lib/features/auth/login_page.dart`, `lib/features/auth/providers/auth_providers.dart`

**Actions:**
- [ ] auth_providers: `isLoggedInProvider` (watch authRepository)
- [ ] login_page: Scaffold + TabBar(登录/注册) + Form(邮箱+密码+昵称) + FilledButton
  - 登录成功 → authRepo.login() → context.pop()
  - 注册成功 → authRepo.register() → context.pop()
  - 国风配色 (AppColors.accentPrimary 红色印章 Logo)
  - loading 状态显示 CircularProgressIndicator
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

### Task 11: 更新路由系统

**Files:** Modify: `lib/core/router/routes.dart`, `lib/core/router/app_router.dart`

**Actions:**
- [ ] routes.dart: 新增 login, aiChat, stats, discoverBrowse, discoverDynasty, discoverType, discoverPoem, searchAuthor, settingsProfile 路由常量
- [ ] app_router.dart:
  - 替换所有 `_PlaceholderPage` 为真实页面 import
  - 新增 /login (rootNavigatorKey, 全屏 modal)
  - 新增 /ai-chat (带 extra: {context, title})
  - 新增 /home/stats
  - 新增 /discover/browse, /discover/dynasty/:name, /discover/type/:name, /discover/author/:id, /discover/poem/:id
  - 新增 /search/author/:id
  - 保留 _PlaceholderPage 仅用于字体/主题设置子页

---

## Phase 3: UI 页面建设 (Tasks 12-18)

### Task 12: 创建发现页 (DiscoverPage)

**Files:** Create: `lib/features/discover/discover_page.dart`, `lib/features/discover/providers/discover_providers.dart`

**Actions:**
- [ ] discover_providers: `discoverPageDataProvider` → 调用 DiscoverService.getDiscover()
- [ ] discover_page: Scaffold + ListView
  - 体裁分类: Wrap<ActionChip> — 五言绝句/七言律诗/词/曲... 带图标
  - 朝代索引: Wrap<ActionChip> — 唐/宋/元/明/清...
  - 近期诗词: 前5条 PoetryCard
  - loading 骨架屏, error 重试按钮
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

### Task 13: 创建浏览页 (BrowsePage)

**Files:** Create: `lib/features/browse/browse_page.dart`, `lib/features/browse/providers/browse_providers.dart`

**Actions:**
- [ ] browse_providers: BrowsePoems (@riverpod class) — 接收 dynasty?/type? 参数，支持 loadMore()
- [ ] browse_page: Scaffold + RefreshIndicator + ListView.builder
  - AppBar 标题 = dynasty/type 名
  - 每项 PoetryCard，点击进入诗词详情
  - ScrollController 滚动到 80% 时 loadMore
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

### Task 14: 创建搜索页 (SearchPage)

**Files:** Create: `lib/features/search/search_page.dart`, `lib/features/search/providers/search_providers.dart`

**Actions:**
- [ ] search_providers: SearchResults (@riverpod class) — 接收 query/type，支持 loadMore
- [ ] search_page: Scaffold + Column
  - 搜索框 TextField + 搜索按钮
  - FilterChip 行: 全部/标题/内容/作者
  - Expanded → Consumer → 结果列表 (PoetryCard) 或空状态
  - 空状态: 水墨风 Icon + "请输入关键词搜索诗词"
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

### Task 15: 创建收藏页 (FavoritesPage)

**Files:** Create: `lib/features/favorites/favorites_page.dart`, `lib/features/favorites/providers/favorites_providers.dart`

**Actions:**
- [ ] favorites_providers: favoritesListProvider (watch authRepository + favoritesRepository)
- [ ] favorites_page:
  - 未登录 → 居中引导:"登录后查看收藏" + FilledButton 跳转 /login
  - 已登录 + loading → CircularProgressIndicator
  - 已登录 + empty → "还没有收藏诗词"
  - 已登录 + data → RefreshIndicator + ListView.builder
  - 每项 Dismissible (endToStart) 删除
  - 每项 ListTile: 标题/作者朝代/收藏日期，点击跳转详情
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

### Task 16: 创建设置页 (SettingsPage)

**Files:** Create: `lib/features/settings/settings_page.dart`

**Actions:**
- [ ] settings_page (单文件，无复杂 Provider):
  - 账户区: 用户头像+昵称+邮箱 (已登录) / "登录/注册" 入口 (未登录) / 退出登录按钮 (红色+确认弹窗)
  - 阅读区: 字体设置 + 主题设置 (跳转占位页)
  - 数据区: 阅读统计入口 (跳转 /home/stats)
  - 关于区: 版本号 (来自 appConfigProvider)
  - 使用 ListView + _SectionHeader 分组标题 (accentPrimary 色)
- [ ] 验证: `dart analyze lib/features/settings/`

---

### Task 17: 创建 AI 问答页 (AiChatPage)

**Files:** Create: `lib/features/ai/ai_chat_page.dart`, `lib/features/ai/providers/ai_providers.dart`

**Actions:**
- [ ] ai_providers: AiChat (@riverpod class) — _messages 列表，send(question, context?) 调用 AiService.askQuestion
- [ ] ai_chat_page:
  - AppBar 标题 "AI 诗词问答" (+ 关联诗词名)
  - 未登录 → 居中提示 + 返回按钮
  - 关联上下文标签 (来自 poemDetail 跳转时传入)
  - ListView.builder 消息气泡: 用户右对齐(红色), AI 左对齐(灰色)
  - 底部输入框 + 发送按钮
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

### Task 18: 创建阅读统计页 (StatsPage)

**Files:** Create: `lib/features/stats/stats_page.dart`

**Actions:**
- [ ] stats_page (单文件，直接调用 readingStatsProvider):
  - 两个总览卡片 Row: 总阅读量 (accentPrimary) / 覆盖诗词数 (celadon)
  - 热门诗词 Top 10: ListTile + CircleAvatar 排名徽章 (前3金色)
  - 热门作者排行: ListTile 列表
  - 近7日趋势: CustomPaint 柱状图 (_BarChart widget)
- [ ] 验证: `dart analyze lib/features/stats/`

---

## Phase 4: 现有页面增强 + 最终集成 (Tasks 19-23)

### Task 19: 增强首页 — 接入真实 API

**Files:** Modify: `lib/features/home/providers/home_providers.dart`, `lib/features/home/home_page.dart`, `lib/features/home/widgets/solar_term_banner.dart`, `lib/features/home/widgets/daily_poem_card.dart`

**Actions:**
- [ ] home_providers: homePageDataProvider → `Future.wait([getHome, getSolarTerm, getConfig, getReadingStats])`
- [ ] home_page: 用 homePageDataProvider 替代现有独立 providers
  - 在 HomeSliverHeader 和 DailyPoemCard 之间插入:
    - Banner 轮播 (PageView + cached_network_image, 来自 config.banners)
    - 数据摘要行 (Text: "{totalPoems} 首诗词 · {totalAuthors} 位作者")
  - 在 RecentReadsShelf 之后插入热门排行横滑列表 (stats.topPoems)
- [ ] solar_term_banner: 接收 SolarTermData 参数替代硬编码
- [ ] daily_poem_card: 接收 ApiPoem 参数替代硬编码
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

### Task 20: 增强诗词详情页

**Files:** Modify: `lib/features/poem_detail/poem_detail_page.dart`, `lib/features/poem_detail/providers/poem_detail_providers.dart`, `lib/features/poem_detail/widgets/poem_action_bar.dart`, `lib/features/poem_detail/widgets/ai_appreciation_section.dart`

**Actions:**
- [ ] poem_detail_providers: 新增 `aiTranslationProvider` (Future, 接收 content + targetLang)
- [ ] poem_detail_page:
  - AppBar 右侧添加 AI 问答按钮 → push /ai-chat (extra: context + title)
  - data 分支中: `ref.read(poemRepositoryProvider).recordServerReading(...)`
  - 新增翻译按钮 → showModalBottomSheet 选择语言 (英/日/韩) → 调用 API → 显示结果
- [ ] poem_action_bar: 收藏按钮改为服务端优先 (检查登录 → API add/remove → invalidate)
- [ ] ai_appreciation_section: 改为新 AIAnalysisData 格式 (background + appreciation + keywords + emotions 结构化展示)
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs`

---

### Task 21: 更新开屏页 — 每日一句

**Files:** Modify: `lib/features/splash/splash_page.dart`

**Actions:**
- [ ] initState 中调用 `GatewayApiClient().getQuote()`
- [ ] 在现有 Logo + "诗词" + "沉浸式古诗词阅读" 之间插入每日一句:
  - Text(quote.content, displayMedium)
  - Text("—— {author}《{source}》", captionRegular)
- [ ] 延长跳转时间到 3 秒 (给每日一句加载留时间)
- [ ] 验证: `dart analyze lib/features/splash/`

---

### Task 22: 最终集成 — main.dart + 401 监听

**Files:** Modify: `lib/main.dart`, `lib/app.dart`

**Actions:**
- [ ] main.dart: 添加 `await GatewayApiClient().init()` 在 runApp 之前
- [ ] app.dart: PoetryApp 改为 ConsumerStatefulWidget
  - initState 中监听 `AuthEventBus.instance.onUnauthorized` → 显示 SnackBar + push /login
  - 添加 import for AuthEventBus
- [ ] 验证: `dart analyze lib/main.dart lib/app.dart`

---

### Task 23: 全量编译验证 + 修复

**Actions:**
- [ ] 运行 `dart run build_runner build --delete-conflicting-outputs` — 确保所有 .g.dart 生成成功
- [ ] 运行 `dart analyze lib/` — 修复所有编译错误
- [ ] 核对 27 端点覆盖: 逐一检查 GatewayApiClient 中的方法
- [ ] 运行 `flutter build apk --debug` — 验证 Android 构建通过
- [ ] Git 提交: `git add -A && git commit -m "feat: fully integrate Poetry Gateway API (27 endpoints)"`

---

## API 端点覆盖核对表

| # | 方法 | 路径 | Client 方法 |
|---|------|------|-------------|
| 1 | GET | /api/v1/home | getHome() |
| 2 | GET | /api/v1/discover | getDiscover() |
| 3 | GET | /api/v1/categories | getCategories() |
| 4 | GET | /api/v1/recommend | getRecommend() |
| 5 | GET | /api/v1/quote | getQuote() |
| 6 | GET | /api/v1/solar-term | getSolarTerm() |
| 7 | GET | /api/v1/config | getConfig() |
| 8 | GET | /api/v1/poems | getPoems() |
| 9 | GET | /api/v1/poems/:id | getPoemById() |
| 10 | GET | /api/v1/poems/random | getRandomPoem() |
| 11 | GET | /api/v1/authors | getAuthors() |
| 12 | GET | /api/v1/authors/:id | getAuthorById() |
| 13 | GET | /api/v1/search | search() |
| 14 | POST | /api/v1/ai/analyse | analyzePoem() |
| 15 | POST | /api/v1/ai/ask | askQuestion() |
| 16 | POST | /api/v1/ai/translate | translatePoem() |
| 17 | POST | /api/v1/user/register | register() |
| 18 | POST | /api/v1/user/login | login() |
| 19 | GET | /api/v1/user/profile | getProfile() |
| 20 | PUT | /api/v1/user/profile | updateProfile() |
| 21 | GET | /api/v1/favorites | getFavorites() |
| 22 | POST | /api/v1/favorites | addFavorite() |
| 23 | DELETE | /api/v1/favorites/:poemId | removeFavorite() |
| 24 | GET | /api/v1/favorites/sync | syncFavorites() |
| 25 | GET | /api/v1/history | getHistory() |
| 26 | POST | /api/v1/history | recordReading() |
| 27 | GET | /api/v1/stats/reading | getReadingStats() |
