# Flutter Poetry V2.0 — Design Document

> 2026-07-21 | Status: Approved
>
> 目标：打造一款以 iOS 体验为核心、达到 App Store Today 推荐品质的现代中国古诗词应用。

---

## 1. Product Positioning

不是诗词查询工具，而是**沉浸式诗词阅读、收藏、分享、AI 赏析平台**。

### Core Principles

- iOS First — Human Interface Guidelines 优先
- Swift 风格动画体验（Flutter 实现）
- Material 3 + Cupertino 混合设计
- 120FPS 优先，零卡顿

### 8 Modules

| # | Module | Description |
|---|--------|-------------|
| 1 | Home | 推荐、每日一句、节气、最近阅读 |
| 2 | Discover | 分类浏览、朝代时间轴、飞花令、接龙 |
| 3 | Search | 全文/作者/标题/拼音搜索、历史、热门 |
| 4 | Detail | 正文、译文、注释、AI 赏析、AI 配图、相关推荐 |
| 5 | Author | 生平、代表作 Timeline、地图 |
| 6 | Favorites | 本地收藏 + 云同步接口预留 |
| 7 | Share | 1080×1920 海报生成与分享 |
| 8 | Settings | 字体、主题、通知、阅读模式 |

### V2.0 Features

- AI 赏析（DeepSeek）
- AI 配图（DeepSeek 生成国风插画）
- 每日一句（首页 Widget）
- 飞花令挑战
- 诗词接龙
- 节气 + 对应诗词
- 名句卡片（Instagram / 小红书风格）
- 诗词朗读（TTS）
- 长图海报分享
- 收藏夹同步（Supabase/Firebase 预留）
- 阅读统计（连续打卡、阅读时长）
- 地图模式（诗人与创作地点可视化）
- 朝代时间轴
- 离线数据库（Isar）

---

## 2. Architecture

### Layered Architecture

```
UI (Pages/Widgets)
    ↑ Riverpod (State)
Repository (Business Logic)
    ↑ Service (Data Processing)
API Client (Dio + GraphQL)
    ↑ HTTP
chinese-poetry-api / DeepSeek API
```

**Hard rule:** UI 层不直接访问网络。API → Service → Repository → Riverpod → UI。

### Folder Structure

```
lib/
├── main.dart
├── app.dart                          # MaterialApp.router + Theme
├── core/
│   ├── theme/                        # 国风色彩 + Apple 排版
│   ├── router/                       # go_router 配置
│   ├── network/                      # Dio 实例 + 拦截器
│   ├── database/                     # Isar 离线数据库
│   ├── constants/                    # 字符串/API路径
│   └── extensions/                   # BuildContext, String 等扩展
├── data/
│   ├── api/                          # API 客户端 (poetry_api, deepseek_api)
│   ├── models/                       # Freezed 数据模型
│   ├── repositories/                 # Repository 实现
│   └── services/                     # Service 层
├── features/
│   ├── home/                         # 首页
│   ├── discover/                     # 发现
│   ├── search/                       # 搜索
│   ├── detail/                       # 诗词详情
│   ├── author/                       # 作者页
│   ├── favorites/                    # 收藏
│   ├── share/                        # 海报生成
│   └── settings/                     # 设置
└── shared/
    ├── widgets/                      # 通用组件
    ├── animations/                   # 动画定义
    └── providers/                    # 共享 Riverpod Providers
```

### Code Constraints

- File ≤ 400 lines
- Widget ≤ 300 lines
- No `setState` — all Riverpod
- Strict layering
- Each module independently runnable after completion

---

## 3. Design System — Apple Framework + Chinese Aesthetic

### Color System

```
Ink (文本层级)
├── ink.primary         #1A1A1A  正文
├── ink.secondary       #666666  副文本
└── ink.tertiary        #999999  辅助信息

Xuan Paper / Surface (背景层级)
├── surface.primary     #FAFAF5  主页背景 (暖白宣纸色)
├── surface.secondary   #F5F0E8  卡片背景
└── surface.tertiary    #EDE8DC  分组背景

Vermillion / Accent (强调/动作)
├── accent.primary      #C9403A  主强调 (印章红)
├── accent.secondary    #8B4513  次强调 (檀木棕)
└── accent.gold         #B8860B  点缀金

Nature (辅助色)
├── nature.bamboo       #6B8E23  竹青
├── nature.teal         #5F9EA0  青瓷
└── nature.lavender     #9B8EC4  藕荷
```

### Typography (iOS-first)

```
Display
├── Noto Serif SC Bold    28/34  — 诗歌标题、大标题
├── Noto Serif SC Regular 20/28  — 诗词正文

Body
├── PingFang SC Regular   17/24  — 正文、译文
├── PingFang SC Medium    15/22  — 列表标题、按钮

Caption
├── PingFang SC Regular   13/18  — 标签、元信息
└── SF Mono Regular       12/16  — 拼音、代码
```

### Spacing (16pt grid)

```
xs   4pt
sm   8pt
md   16pt   ← 基准
lg   24pt
xl   32pt
2xl  48pt
3xl  64pt

Card corner radius: 20pt
Button corner radius: 12pt (capsule)
Max reading width: 680pt
```

### Glassmorphism

```
Blur.light    — 10px blur, 0.6 white opacity
Blur.medium   — 20px blur, 0.4 white opacity
Blur.heavy    — 30px blur, 0.2 white opacity
```

### iOS Experience Points

- Custom NavigationBar with large title collapsing
- Hero transitions
- Shared Axis transitions
- Interactive Pop Gesture
- Haptic Feedback
- Context Menu (long press)
- Swipe Actions
- Blur / Vibrancy backgrounds
- SF Symbols style icons
- Dynamic Island / Live Activity (reserved)
- Dark mode fine-tuned

### Animations

- Page transitions, Hero, Fade, Scale, Parallax, Sliver, Skeleton Loading
- **Forbidden:** default `CircularProgressIndicator`

---

## 4. Tech Stack

| Layer | Choice |
|-------|--------|
| Framework | Flutter (Stable) |
| State | Riverpod |
| Router | go_router |
| HTTP | Dio |
| Models | Freezed (code generation) |
| Database | Isar (offline) |
| Theme | FlexColorScheme + dynamic_color |
| Animation | flutter_animate |
| Fonts | google_fonts (Noto Serif SC, PingFang SC) |
| Share | share_plus + screenshot |
| Splash | flutter_native_splash |
| Icons | flutter_launcher_icons |

---

## 5. Data Models (Freezed)

### Core Entities

```dart
Poem {
  id, title, content, translation?, annotation?,
  appreciation?, aiAppreciation?, aiImageUrl?,
  author: AuthorBrief, dynasty: Dynasty,
  category: PoemCategory, tags?, pinyin?
}

Author {
  id, name, courtesyName?, pseudonym?,
  dynasty: Dynasty, biography?, birthplace?,
  latitude?, longitude?, masterpieces?, portraitUrl?
}

Dynasty { id, name, startYear?, endYear? }

SolarTerm { name, date, description?, relatedPoems? }

PoemCategory enum {
  landscape, farewell, frontier, pastoral,
  nostalgic, romantic, philosophical, political, seasonal, misc
}
```

### API Clients

```dart
PoetryApiClient {
  getPoems(page, pageSize, dynasty?, category?)       // REST
  searchPoems(query, type)                             // REST
  getRandomPoem(dynasty?, category?)                   // REST
  getAuthors(page, pageSize)                           // REST
  getDynasties()                                       // REST
  getStatistics()                                      // GraphQL
  getPoemsByDynasty(dynastyId)                         // GraphQL
}

DeepSeekApiClient {
  analyzePoem(poem)          // AI 赏析
  generateIllustration(poem) // AI 配图 prompt
}
```

### Offline Strategy (Isar)

```
First launch → download base poetry data → store in Isar
Subsequent launches → API first (incremental) → Isar fallback
Offline → pure Isar mode
```

---

## 6. Navigation (go_router)

```
/                              → ShellRoute (Bottom TabBar)
├── /home                      → Home
│   ├── /poem/:id              → Poem Detail (Hero push)
│   ├── /author/:id            → Author Page (Hero push)
│   └── /daily-poem            → Daily Poem full screen
├── /discover                  → Discover
│   ├── /discover/category/:id → Category browse
│   ├── /discover/dynasty/:id  → Dynasty timeline
│   ├── /discover/fly-flower   → Flying Flower game
│   └── /discover/chain        → Poem chain game
├── /search                    → Search
│   └── /poem/:id              → (reuses detail page)
├── /favorites                 → Favorites
└── /settings                  → Settings
    ├── /settings/font         → Font settings
    └── /settings/theme        → Theme settings

Standalone routes (outside TabBar)
├── /splash                    → Splash
├── /share/:poemId             → Share poster
└── /map                       → Poet map
```

---

## 7. Development Phases

### Phase 1: Foundation
- Flutter project init + dependencies
- Design system (Theme/Colors/Typography/Spacing)
- Core utils (Dio/Isar/Router)
- All Freezed data models
- API Clients (REST + GraphQL)
- Shared widget library (Skeleton/Blur/PoetryCard)
- Splash page + ShellRoute skeleton

### Phase 2: Home + Detail + Author
- Home page (recommendations/daily poem/solar terms/recent reads)
- Poem detail page (content/translation/annotation/appreciation)
- Author page (biography/masterpieces/map)
- AI appreciation integration

### Phase 3: Search + Discover + Favorites
- Search (full-text/author/title/pinyin)
- Discover (categories/dynasties/flying flower/chain)
- Favorites (local + cloud sync reserve)

### Phase 4: Share + AI Image + Advanced
- Poster generation & share
- AI illustration (DeepSeek)
- Reading statistics
- TTS reading
- Notifications

### Phase 5: Polish + Release
- 120FPS optimization
- Complete offline database
- Dark mode fine-tuning
- App Store assets
- Release

---

## 8. External Dependencies

| Service | Purpose | Endpoint |
|---------|---------|----------|
| chinese-poetry-api | Poetry data | `https://poetry.palemoky.com` |
| DeepSeek API | AI appreciation & illustration | TBD (configurable) |

---

## 9. Self-Review Checklist

- [x] No TBD/TODO placeholders in core design
- [x] Architecture ↔ Feature mapping consistent
- [x] Scope properly decomposed into 5 phases
- [x] Color/type/spacing tokens are explicit (implementable)
- [x] Data models cover all features
- [x] Router tree covers all pages
- [x] Tech stack matches Prompt requirements
- [x] Code constraints enforceable (400/300 line limits)
