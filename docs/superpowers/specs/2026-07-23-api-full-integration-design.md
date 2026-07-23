# Poetry Gateway API 全面接入 — 设计文档

> 日期: 2026-07-23 | 状态: 待审核

## 一、概述

将 api.md 中定义的 27 个 Poetry Gateway API 端点全部接入 Flutter 客户端（Android + iOS），补全 4 个占位 Tab 页面，构建完整的诗词阅读体验。

### 核心原则

1. Flutter 只调用 Poetry Gateway `/api/v1/*`，不直接访问 Chinese Poetry API / AI Provider / PostgreSQL
2. 所有业务逻辑保留在 Gateway 侧，Flutter 仅负责展示
3. 遵循现有架构：UI → Riverpod → Repository → Service → GatewayApiClient → Dio → Gateway
4. 新模型（api.md 格式）通过 Service 层转换后对接现有 UI 模型，最小化已有页面改动

---

## 二、数据层设计

### 2.1 API 常量更新

**文件**: `lib/core/constants/api_constants.dart`

```
baseUrl → https://www.chinesepoetry.space (生产环境)

新增端点常量:
  /api/v1/discover       — 发现页聚合
  /api/v1/categories     — 分类聚合
  /api/v1/recommend      — 推荐
  /api/v1/quote          — 每日一句
  /api/v1/solar-term     — 节气推荐
  /api/v1/config         — 客户端配置
  /api/v1/search         — 全文搜索 (替换现有 /poems/search)
  /api/v1/poems/random   — 随机诗词
  /api/v1/ai/analyse     — AI 赏析
  /api/v1/ai/ask         — AI 问答
  /api/v1/ai/translate   — AI 翻译
  /api/v1/user/register  — 注册
  /api/v1/user/login     — 登录
  /api/v1/user/profile   — 个人信息
  /api/v1/favorites      — 收藏 CRUD
  /api/v1/favorites/sync — 收藏同步
  /api/v1/history        — 阅读历史
  /api/v1/stats/reading  — 阅读统计
```

### 2.2 GatewayApiClient 重写

**文件**: `lib/data/api/gateway_api_client.dart`

按域组织 27 个方法，全部返回强类型 Future：

```
诗词域 (6):
  getPoems(page, pageSize, dynasty?, type?, author?)
  getPoemById(id)
  getRandomPoem(author?, type?, dynasty?, char?)
  searchPoems(q, type?, page, pageSize)

作者域 (3):
  getAuthors(page, pageSize)
  getAuthorById(id)

聚合域 (7):
  getHome()           → featuredPoem + featuredAuthor + stats
  getDiscover()       → recentPoems + dynasties + types
  getCategories()     → all dynasties + types
  getRecommend()      → poems[] + reason
  getQuote()          → content + author + source + date
  getSolarTerm()      → termName + description + poem + reason
  getConfig()         → version + banners + features

AI 域 (3, 🔒):
  analyzePoem(title, content, author?, dynasty?)
  askQuestion(question, context?)
  translatePoem(content, targetLang?)

用户域 (4):
  register(email, password, name?)  → token + user
  login(email, password)            → token + user
  getProfile()                      → user (🔒)
  updateProfile(name?, avatar?)     → user (🔒)

收藏域 (4, 🔒):
  getFavorites()          → favorites[] + total
  addFavorite(poemId, title, author?, dynasty?)
  removeFavorite(poemId)
  syncFavorites()         → favorites[] + syncToken + total

历史域 (2, 🔒):
  getHistory()            → records[] + total
  recordReading(poemId, title, author?, dynasty?)

统计域 (1):
  getReadingStats()       → totalReads + topPoems + topAuthors + readsByDay
```

**JWT 认证机制**：
- `GatewayApiClient` 持有 `String? _token`
- 提供 `setToken(String?)` / `clearToken()` 方法
- `_headers` getter 自动在有 token 时注入 `Authorization: Bearer <token>`
- `init()` 从 SharedPreferences 恢复 token
- login/register 成功后自动设置 token

### 2.3 Dio 客户端升级

**文件**: `lib/core/network/dio_client.dart`

新增：
- `AuthInterceptor`: 请求前从 GatewayApiClient 读取 token 注入 header
- `AuthErrorInterceptor`: 收到 401 时触发 `AuthEventBus` 事件，UI 层监听跳转登录
- `ResponseInterceptor`: 自动解析统一响应格式 `{success, data}`，失败时 throw

### 2.4 API 数据模型（新增）

**文件**: `lib/data/models/api_responses.dart`

直接映射 api.md JSON 格式的 Freezed 模型：

```dart
// 对应 /api/v1/home 响应
class HomeData { featuredPoem, featuredAuthor, totalPoems, totalAuthors }

// 对应 /api/v1/discover 响应
class DiscoverData { recentPoems, dynasties, types }

// 对应 /api/v1/quote 响应
class DailyQuote { content, author, source, date }

// 对应 /api/v1/solar-term 响应
class SolarTermData { termName, termDescription, poem, reason }

// 对应 /api/v1/config 响应
class AppConfig { version, banners, features }

// 对应 /api/v1/recommend 响应
class RecommendData { poems, reason }

// 对应 /api/v1/ai/ask 响应
class AIAnswer { answer }

// 对应 /api/v1/ai/translate 响应
class AITranslation { translation, notes }

// 对应 /api/v1/ai/analyse 响应
class AIAnalysisData { background, appreciation, keywords, emotions }

// 对应 /api/v1/stats/reading 响应
class ReadingStatsData { totalReads, totalPoems, topPoems, topAuthors, readsByDay }

// 对应 /api/v1/favorites 响应
class FavoriteItem { id, poemId, poemTitle, poemAuthor, poemDynasty, createdAt }

// 对应 /api/v1/history 响应
class HistoryRecord { id, poemId, poemTitle, poemAuthor, poemDynasty, readAt }

// 对应 /api/v1/user/* 响应
class UserData { id, email, name, avatar, createdAt }

// API 诗词 (扁平结构，匹配 api.md)
class ApiPoem { id, title, content, author, dynasty, type }
```

### 2.5 Service 层（新增 + 更新）

所有 Service 使用 `GatewayApiClient()` 实例，负责数据转换。

```
新增:
  AuthService        — 登录/注册/Token 持久化
  DiscoverService    — 发现页数据
  FavoritesService   — 收藏 CRUD + 同步
  HistoryService     — 阅读记录 + 列表
  StatsService       — 阅读统计
  ConfigService      — 客户端配置（缓存 1h）

更新:
  AIService          — 补全 analyse/ask/translate 三个 AI 方法
  PoemService        — 对齐新的 API 参数名 (dynasty/type/author)
  AuthorService      — 对齐 API 响应格式
```

### 2.6 Repository 层（新增 + 更新）

```
新增:
  authRepositoryProvider      — AuthState: {unauthenticated, loading, authenticated(user)}
  discoverRepositoryProvider  — 发现数据
  favoritesRepositoryProvider — 收藏 CRUD + syncState
  historyRepositoryProvider   — 阅读历史
  statsRepositoryProvider     — 统计数据
  configRepositoryProvider    — 应用配置 + Banner

更新:
  poemRepositoryProvider      — 补充分页筛选参数
  aiRepositoryProvider        — 补全 analyse/ask/translate
```

---

## 三、路由设计

### 3.1 路由树

```
/splash                           → SplashPage (每日一句开屏)
/home (Shell Tab 1)               → HomePage
  /home/poem/:id                   → PoemDetailPage
  /home/author/:id                 → AuthorPage
  /home/stats                      → StatsPage (阅读统计看板)
/discover (Shell Tab 2)           → DiscoverPage
  /discover/browse                  → BrowsePage (按朝代/体裁浏览诗词列表)
  /discover/dynasty/:name          → BrowsePage(dynasty: name)
  /discover/type/:name             → BrowsePage(type: name)
  /discover/author/:id             → AuthorPage
  /discover/poem/:id               → PoemDetailPage
/search (Shell Tab 3)             → SearchPage
  /search/poem/:id                 → PoemDetailPage
  /search/author/:id               → AuthorPage
/favorites (Shell Tab 4)          → FavoritesPage
/settings (Shell Tab 5)           → SettingsPage
  /settings/profile               → ProfileEditPage
  /settings/font                   → FontSettingsPage
  /settings/theme                  → ThemeSettingsPage
/login                             → LoginPage (modal)
/ai-chat                           → AiChatPage (AI 问答)
```

### 3.2 认证路由守卫

- `/login` 为全屏 modal 路由（`parentNavigatorKey: rootNavigatorKey`）
- 需要认证的操作（收藏、AI 功能、历史记录）：若未登录则 `context.push('/login')`，登录成功后自动 pop
- Dio 401 拦截器触发全局 `AuthEventBus`，显示 SnackBar + 清除本地 token + 跳转登录

---

## 四、UI 页面设计

### 4.1 开屏页 (SplashPage) — 改造

- 加载 `/api/v1/quote` 每日一句
- 显示："诗句" + "—— 作者《出处》"
- 保留现有动画（红色印章 Logo + 渐入）
- 2 秒后跳转首页

### 4.2 首页 (HomePage) — 增强

**数据来源**：并行请求 4 个 API
```dart
Future.wait([
  api.getHome(),        // featuredPoem + featuredAuthor + totalPoems/ Authors
  api.getSolarTerm(),   // 节气推荐
  api.getConfig(),      // Banner + 功能开关
  api.getReadingStats(),// 热门排行 + 7日统计
])
```

**Sliver 布局**（保留现有结构，增强内容）：
1. 可折叠大标题（保留）
2. **Banner 轮播** — 来自 config.banners，`cached_network_image` + PageView
3. **数据摘要行** — `385,000 首诗词 · 14,000 位作者`（来自 home.totalPoems/totalAuthors）
4. 每日诗词卡片（保留，接入 `/home` featuredPoem）
5. 节气横幅（保留，接入 `/solar-term` 真实数据）
6. 最近阅读（保留）
7. **热门排行** — 来自 stats.topPoems，横向滚动排行榜
8. 推荐列表（保留）

### 4.3 发现页 (DiscoverPage) — 新建

**数据来源**: `GET /api/v1/discover`

**布局**（GridView）：
- **近期诗词**横滑卡片行
- **体裁分类** — 网格：五言绝句、七言律诗、宋词、元曲... 卡片带图标
- **朝代时间线** — 竖排时间线样式：先秦→汉→魏晋→唐→宋→元→明→清
- **飞花令入口** — 装饰性卡片，点击进入随机诗词页（调用 `/poems/random?char=`）
- 每个分类卡片点击进入 [BrowsePage] 带对应筛选参数

### 4.4 搜索页 (SearchPage) — 新建

**数据来源**: `GET /api/v1/search?q=&type=&page=`

**布局**：
- 搜索框（Autocomplete 风格，带搜索历史）
- 类型筛选 Chips：全部 / 标题 / 内容 / 作者
- 结果列表（PoetryCard + 分页加载）
- 空状态：水墨风插画 + "请输入关键词搜索诗词"
- 搜索结果高亮关键词

### 4.5 收藏页 (FavoritesPage) — 新建

**数据来源**: `GET /api/v1/favorites`（登录后）

**布局**：
- 未登录：空状态引导登录
- 已登录：ListView 收藏列表，每项含诗词标题、作者、朝代、收藏时间
- 左滑删除（`Dismissible`）→ 调用 `DELETE /api/v1/favorites/:poemId`
- 下拉刷新 → 重新拉取收藏列表
- 后台定时同步（5 分钟间隔调用 `/favorites/sync`）

### 4.6 诗词详情页 — 增强

**现有功能保留**：标题、诗词正文、元数据栏、操作栏、译文/注释/赏析折叠区

**新增功能**：
- **AI 赏析** — 接入 `POST /api/v1/ai/analyse`（返回 background + appreciation + keywords + emotions，结构化展示）
- **AI 翻译按钮** — 底部 Sheet 选择语言（英/日/韩），调用 `POST /api/v1/ai/translate`
- **AI 问答入口** — AppBar 右侧按钮，跳转 [AiChatPage] 并预填 context = 当前诗词
- **记录阅读** — 进入详情页自动 `POST /api/v1/history`（需登录）
- **收藏按钮** — 操作栏中，调用 `POST/DELETE /api/v1/favorites`（需登录），未登录跳转登录

### 4.7 作者页 — 增强

**数据来源**: `GET /api/v1/authors/:id` + `GET /api/v1/poems?author=`

**布局**（保留现有并增强）：
- 作者头部（姓名、朝代、字/号、生卒年）
- 简介（来自 API description）
- 代表作品列表（来自 API + poems 筛选）
- 作品总数统计

### 4.8 AI 问答页 (AiChatPage) — 新建

**数据来源**: `POST /api/v1/ai/ask`

**布局**：
- 聊天式 UI（用户问题气泡 + AI 回答气泡）
- 底部输入框
- 可选的"关联诗词"上下文标签
- 限流提示（5 次/分钟）
- 需登录

### 4.9 阅读统计页 (StatsPage) — 新建

**数据来源**: `GET /api/v1/stats/reading`

**布局**：
- 总阅读量 / 覆盖诗词数 大数字卡片
- 热门诗词 Top 10 排行列表（数字徽章 1-10）
- 热门作者排行（横向条形图风格）
- 近 7 日阅读量折线趋势图（手绘 SVG 或 flutter_animate 简单柱状图）
- 中国传统配色

### 4.10 设置页 (SettingsPage) — 新建

**布局**（分组 ListTile）：
- **用户区**：头像 + 昵称 + 邮箱，点击编辑（调用 `PUT /api/v1/user/profile`）
  - 未登录显示"登录/注册"入口
- **阅读**：字体设置、主题切换（保持现有）
- **数据**：阅读统计入口、收藏同步状态
- **关于**：版本号（来自 config）、API 状态
- **登出按钮**（登录后可见）

### 4.11 登录/注册页 (LoginPage) — 新建

**布局**：
- 水墨风格背景
- 邮箱 + 密码输入框
- 登录 / 注册 Tab 切换
- 注册时可选填昵称
- 登录成功后自动 pop 返回
- 错误提示 SnackBar

### 4.12 浏览页 (BrowsePage) — 新建

**数据来源**: `GET /api/v1/poems?dynasty=&type=&page=`

**布局**：
- AppBar 标题 = 朝代名/体裁名
- PoetryCard 列表
- 上拉加载更多
- 下拉刷新

---

## 五、认证流程图

```
用户操作 (收藏/AI/历史)
       │
       ▼
  检查 isLoggedIn?
       │
   ┌───┴───┐
   │       │
  Yes     No
   │       │
   ▼       ▼
执行操作  push /login
           │
           ▼
      用户登录/注册
           │
           ▼
      获取 JWT Token
           │
      ┌────┴────┐
      ▼         ▼
  SharedPrefs  GatewayApiClient
  持久化       setToken()
      │
      ▼
  pop 回前一页
      │
      ▼
  自动重试操作
```

---

## 六、离线策略

| 数据类型 | 在线 | 离线 |
|----------|------|------|
| 诗词内容 | API | Isar 缓存 (PoemCache) |
| 作者信息 | API | Isar 缓存 |
| 收藏列表 | API (主) | Isar (本地副本) |
| 阅读历史 | API (主) | Isar (本地副本) |
| 用户信息 | API | SharedPreferences |
| 配置/Banner | API | SharedPreferences (带 TTL) |
| 每日一句 | API | 当日缓存 |
| AI 功能 | API only | 不可用提示 |
| 统计数据 | API | 上次缓存展示 |

---

## 七、依赖变更

pubspec.yaml 需新增：
```yaml
shared_preferences: ^2.3.4   # Token 持久化 (已有但未声明，补上)
```

现有依赖满足需求，无需额外添加。图表用纯 Flutter CustomPaint 实现，不引入第三方图表库。

---

## 八、文件变化总览

```
新增文件 (~25):
  lib/data/models/api_responses.dart
  lib/data/models/api_responses.freezed.dart
  lib/data/models/api_responses.g.dart
  lib/data/services/auth_service.dart
  lib/data/services/discover_service.dart
  lib/data/services/favorites_service.dart
  lib/data/services/history_service.dart
  lib/data/services/stats_service.dart
  lib/data/services/config_service.dart
  lib/data/repositories/auth_repository.dart (+ .g.dart)
  lib/data/repositories/discover_repository.dart (+ .g.dart)
  lib/data/repositories/favorites_repository.dart (+ .g.dart)
  lib/data/repositories/history_repository.dart (+ .g.dart)
  lib/data/repositories/stats_repository.dart (+ .g.dart)
  lib/data/repositories/config_repository.dart (+ .g.dart)
  lib/features/discover/discover_page.dart
  lib/features/discover/providers/discover_providers.dart (+ .g.dart)
  lib/features/search/search_page.dart
  lib/features/search/providers/search_providers.dart (+ .g.dart)
  lib/features/favorites/favorites_page.dart
  lib/features/favorites/providers/favorites_providers.dart (+ .g.dart)
  lib/features/settings/settings_page.dart
  lib/features/settings/providers/settings_providers.dart (+ .g.dart)
  lib/features/auth/login_page.dart
  lib/features/auth/providers/auth_providers.dart (+ .g.dart)
  lib/features/stats/stats_page.dart
  lib/features/stats/providers/stats_providers.dart (+ .g.dart)
  lib/features/ai/ai_chat_page.dart
  lib/features/ai/providers/ai_providers.dart (+ .g.dart)
  lib/features/browse/browse_page.dart
  lib/features/browse/providers/browse_providers.dart (+ .g.dart)
  lib/features/settings/profile_edit_page.dart

修改文件 (~15):
  lib/core/constants/api_constants.dart          — 更新 baseUrl + 补全端点
  lib/core/network/dio_client.dart               — Auth 拦截器 + 401 处理
  lib/core/router/app_router.dart                 — 替换占位页 + 新增路由
  lib/core/router/routes.dart                     — 新增路由常量
  lib/data/api/gateway_api_client.dart            — 重写 (27 端点)
  lib/data/services/ai_service.dart               — 补全 analyse/ask/translate
  lib/data/services/poem_service.dart             — 对齐 API 参数
  lib/data/services/author_service.dart           — 对齐 API 格式
  lib/data/repositories/ai_repository.dart        — 补全方法
  lib/data/repositories/poem_repository.dart      — 收藏/历史对接服务端
  lib/data/repositories/author_repository.dart    — 对齐
  lib/features/splash/splash_page.dart            — 接入每日一句
  lib/features/home/home_page.dart                — 接入 /home /config /stats
  lib/features/home/providers/home_providers.dart — 新数据源
  lib/features/poem_detail/poem_detail_page.dart  — 翻译/问答/服务端收藏
  lib/features/poem_detail/providers/poem_detail_providers.dart — 新 AI 方法

删除文件: 无
```

---

## 九、测试策略

- **数据层单元测试**: 每个 Service 的核心方法 mock Dio 验证
- **Provider 测试**: Riverpod provider 的状态转换验证
- **Widget 测试**: 关键页面（登录、搜索、收藏）的交互行为
- **集成测试**: 开屏→首页→详情→收藏 完整用户流程

---

## 十、风险与注意事项

1. **API 兼容性**: 现有代码中的 Poem model（嵌套结构）与 api.md 扁平结构不一致 → Service 层做转换，不改 UI model
2. **API baseUrl 切换**: 从 `http://208.167.233.53:8080` 切到 `https://www.chinesepoetry.space` — 需验证 HTTPS 证书、CORS
3. **AI 限流**: 5次/分钟，UI 需展示剩余次数或冷却倒计时
4. **Isar 兼容**: 现有缓存模型依赖旧 Poem 结构 → 新 API 模型与 Isar 缓存解耦
5. **Freezed 代码生成**: 大量新模型需要 `build_runner` 重新生成，确保一次生成通过
