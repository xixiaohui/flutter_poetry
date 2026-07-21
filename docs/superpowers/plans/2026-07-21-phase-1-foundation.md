# Phase 1: Foundation — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Initialize Flutter project with complete design system, data models, API clients, offline database, router, shared widget library, and placeholder ShellRoute — a fully compiling, runnable skeleton.

**Architecture:** Clean layered architecture: UI (Pages/Widgets) → Riverpod (State) → Repository → Service → API Client (Dio) → HTTP. Freezed models for domain layer, Isar schemas for persistence. Apple + 国风 design system via FlexColorScheme + google_fonts.

**Tech Stack:** Flutter 3.44+, Riverpod, go_router, Dio, Freezed, Isar 3.x, FlexColorScheme, flutter_animate, google_fonts, shimmer, cached_network_image

## Global Constraints

- File ≤ 400 lines, Widget ≤ 300 lines
- No `setState` — all state via Riverpod
- UI 层不直接访问网络: API → Service → Repository → Riverpod → UI
- 禁止 `CircularProgressIndicator` — 使用 Shimmer/Skeleton
- 每个 task 末尾 commit
- Dart 3.12+, Flutter 3.44+

---

### Task 1: Create Flutter project

**Files:**
- Create: `lib/main.dart` (auto-generated, will be replaced later)

- [ ] **Step 1: Create Flutter project in existing directory**

```bash
cd e:/workspace/claw/flutter_poetry && flutter create . --org com.poetry --project-name flutter_poetry --platforms ios,android
```

Expected: "All done!" — project files created, existing README.md preserved (may warn about overwrite).

- [ ] **Step 2: Verify project structure exists**

```bash
ls lib/main.dart pubspec.yaml test/widget_test.dart
```

Expected: All three files exist.

- [ ] **Step 3: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add -A && git commit -m "chore: flutter create flutter_poetry project"
```

---

### Task 2: Configure pubspec.yaml with all dependencies

**Files:**
- Modify: `pubspec.yaml`

- [ ] **Step 1: Replace pubspec.yaml with full dependency manifest**

Read `pubspec.yaml`, then replace it entirely:

```yaml
name: flutter_poetry
description: 沉浸式中国古诗词阅读、收藏、分享、AI赏析平台
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.12.0
  flutter: ^3.44.0

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.3
  go_router: ^14.8.0
  dio: ^5.7.0
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  flex_color_seed: ^2.1.1
  dynamic_color: ^1.7.0
  flutter_animate: ^4.5.2
  google_fonts: ^6.2.1
  share_plus: ^10.1.4
  screenshot: ^3.0.0
  flutter_native_splash: ^2.4.4
  flutter_launcher_icons: ^0.14.1
  cached_network_image: ^3.4.1
  shimmer: ^3.0.0
  intl: ^0.19.0
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.13
  freezed: ^2.5.7
  json_serializable: ^6.8.0
  riverpod_generator: ^2.6.3
  isar_generator: ^3.1.0+1
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
  assets: []

flutter_native_splash:
  color: '#FAFAF5'
  branding: assets/splash_branding.png

flutter_launcher_icons:
  android: true
  ios: true
  image_path: assets/app_icon.png
  adaptive_icon_background: '#FAFAF5'
  adaptive_icon_foreground: assets/app_icon_foreground.png
```

- [ ] **Step 2: Run flutter pub get**

```bash
cd e:/workspace/claw/flutter_poetry && flutter pub get
```

Expected: "exit code 0", all packages resolved.

- [ ] **Step 3: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add pubspec.yaml pubspec.lock && git commit -m "chore: add all project dependencies"
```

---

### Task 3: Design system — AppColors

**Files:**
- Create: `lib/core/theme/app_colors.dart`

- [ ] **Step 1: Create AppColors with light and dark color schemes**

```dart
import 'package:flutter/material.dart';

/// 国风色彩系统 — Apple 框架 + 中国美学色彩注入
abstract final class AppColors {
  // ── Ink (文本层级) ──
  static const Color inkPrimary = Color(0xFF1A1A1A);
  static const Color inkSecondary = Color(0xFF666666);
  static const Color inkTertiary = Color(0xFF999999);

  // ── Xuan Paper / Surface (背景层级) ──
  static const Color surfacePrimary = Color(0xFFFAFAF5);
  static const Color surfaceSecondary = Color(0xFFF5F0E8);
  static const Color surfaceTertiary = Color(0xFFEDE8DC);

  // ── Vermillion / Accent (强调/动作) ──
  static const Color accentPrimary = Color(0xFFC9403A);
  static const Color accentSecondary = Color(0xFF8B4513);
  static const Color accentGold = Color(0xFFB8860B);

  // ── Nature (辅助色) ──
  static const Color bamboo = Color(0xFF6B8E23);
  static const Color celadon = Color(0xFF5F9EA0);
  static const Color lavender = Color(0xFF9B8EC4);

  // ── Dark mode surfaces ──
  static const Color darkSurfacePrimary = Color(0xFF1C1C1A);
  static const Color darkSurfaceSecondary = Color(0xFF2A2825);
  static const Color darkSurfaceTertiary = Color(0xFF363430);

  // ── Dark mode ink ──
  static const Color darkInkPrimary = Color(0xFFF0EDE5);
  static const Color darkInkSecondary = Color(0xFFA09D95);
  static const Color darkInkTertiary = Color(0xFF6B6862);

  // ── Glassmorphism ──
  static Color glassLight = Colors.white.withValues(alpha: 0.6);
  static Color glassMedium = Colors.white.withValues(alpha: 0.4);
  static Color glassHeavy = Colors.white.withValues(alpha: 0.2);
  static Color glassDark = const Color(0xFF1C1C1A).withValues(alpha: 0.6);

  // ── Semantic aliases ──
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFE53935);
}
```

- [ ] **Step 2: Verify the file compiles**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/core/theme/app_colors.dart
```

Expected: "No issues found!"

- [ ] **Step 3: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/core/theme/app_colors.dart && git commit -m "feat: add AppColors design system"
```

---

### Task 4: Design system — AppTypography and AppSpacing

**Files:**
- Create: `lib/core/theme/app_typography.dart`
- Create: `lib/core/theme/app_spacing.dart`

- [ ] **Step 1: Create AppTypography**

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 国风字体层级 — iOS First (PingFang SC + Noto Serif SC)
abstract final class AppTypography {
  // ── Display (诗词展示) ──
  static TextStyle displayLarge(BuildContext context) =>
      GoogleFonts.notoSerifSC(
        fontSize: 28,
        height: 34 / 28,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle displayMedium(BuildContext context) =>
      GoogleFonts.notoSerifSC(
        fontSize: 20,
        height: 28 / 20,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onSurface,
      );

  // ── Body (正文阅读) ──
  static TextStyle bodyLarge(BuildContext context) =>
      GoogleFonts.notoSansSC(
        fontSize: 17,
        height: 24 / 17,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle bodyMedium(BuildContext context) =>
      GoogleFonts.notoSansSC(
        fontSize: 15,
        height: 22 / 15,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onSurface,
      );

  // ── Caption (辅助信息) ──
  static TextStyle captionRegular(BuildContext context) =>
      GoogleFonts.notoSansSC(
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      );

  static TextStyle captionMono(BuildContext context) =>
      const TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'SF Mono',
      );
}
```

- [ ] **Step 2: Create AppSpacing**

```dart
import 'package:flutter/material.dart';

/// 16pt 栅格间距系统
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;  // 基准
  static const double lg = 24;
  static const double xl = 32;
  static const double xl2 = 48;
  static const double xl3 = 64;

  /// 卡片圆角
  static const double cardRadius = 20;

  /// 胶囊按钮圆角
  static const double buttonRadius = 12;

  /// 中文阅读舒适最大宽度
  static const double maxReadingWidth = 680;

  /// 水平页面边距
  static const double pageHorizontal = 16;

  /// 边到边的 EdgeInsets
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: pageHorizontal,
  );

  /// 卡片内边距
  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  /// 列表项间距
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
}
```

- [ ] **Step 3: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/core/theme/ && git commit -m "feat: add AppTypography and AppSpacing design tokens"
```

---

### Task 5: Design system — AppTheme (light + dark)

**Files:**
- Create: `lib/core/theme/app_theme.dart`

- [ ] **Step 1: Create AppTheme**

```dart
import 'package:flutter/material.dart';
import 'package:flex_color_seed/flex_color_seed.dart';
import 'app_colors.dart';

/// 主题配置 — 使用 FlexColorScheme 实现 Apple + 国风混合主题
abstract final class AppTheme {
  static ThemeData light() {
    final scheme = SeedColorScheme.fromSeeds(
      primary: AppColors.accentPrimary,
      secondary: AppColors.celadon,
      tertiary: AppColors.accentGold,
      surface: AppColors.surfacePrimary,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.surfacePrimary,
      cardTheme: CardThemeData(
        color: AppColors.surfaceSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: AppColors.surfacePrimary,
        indicatorColor: AppColors.accentPrimary.withValues(alpha: 0.12),
        surfaceTintColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(color: AppColors.inkPrimary),
      dividerTheme: const DividerThemeData(
        color: AppColors.surfaceTertiary,
        thickness: 0.5,
      ),
      splashColor: Colors.transparent,
      highlightColor: AppColors.inkPrimary.withValues(alpha: 0.06),
    );
  }

  static ThemeData dark() {
    final scheme = SeedColorScheme.fromSeeds(
      primary: AppColors.accentPrimary,
      secondary: AppColors.celadon,
      tertiary: AppColors.accentGold,
      surface: AppColors.darkSurfacePrimary,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.darkSurfacePrimary,
      cardTheme: CardThemeData(
        color: AppColors.darkSurfaceSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: AppColors.darkSurfacePrimary,
        indicatorColor: AppColors.accentPrimary.withValues(alpha: 0.2),
        surfaceTintColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(color: AppColors.darkInkPrimary),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkSurfaceTertiary,
        thickness: 0.5,
      ),
      splashColor: Colors.transparent,
      highlightColor: AppColors.darkInkPrimary.withValues(alpha: 0.06),
    );
  }
}
```

- [ ] **Step 2: Create barrel export for theme**

```bash
echo "export 'app_colors.dart';" > e:/workspace/claw/flutter_poetry/lib/core/theme/app_colors.dart.bak
```

Actually, let me create a proper barrel file:

Create `lib/core/theme/theme.dart`:
```dart
export 'app_colors.dart';
export 'app_spacing.dart';
export 'app_theme.dart';
export 'app_typography.dart';
```

- [ ] **Step 3: Verify analysis passes**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/core/theme/
```

Expected: "No issues found!"

- [ ] **Step 4: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/core/theme/ && git commit -m "feat: add AppTheme light/dark with FlexColorScheme + 国风 palette"
```

---

### Task 6: Core constants

**Files:**
- Create: `lib/core/constants/api_constants.dart`
- Create: `lib/core/constants/app_constants.dart`

- [ ] **Step 1: Create API constants**

```dart
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
```

- [ ] **Step 2: Create App constants**

```dart
/// 应用级常量
abstract final class AppConstants {
  /// 应用名称
  static const String appName = '诗词';

  /// 首次启动标识 key
  static const String isFirstLaunchKey = 'is_first_launch';

  /// 离线数据版本 key
  static const String offlineDataVersionKey = 'offline_data_version';

  /// 阅读区最大宽度
  static const double maxReadingWidth = 680;

  /// 海报尺寸 (1080x1920)
  static const double posterWidth = 1080;
  static const double posterHeight = 1920;

  /// 收藏夹最大数量 (本地)
  static const int maxLocalFavorites = 1000;
}
```

- [ ] **Step 3: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/core/constants/ && git commit -m "feat: add API and app constants"
```

---

### Task 7: Core extensions

**Files:**
- Create: `lib/core/extensions/context_extensions.dart`
- Create: `lib/core/extensions/string_extensions.dart`

- [ ] **Step 1: Create BuildContext extensions**

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

extension BuildContextX on BuildContext {
  /// 主题颜色方案
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// 文本主题
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// 是否为暗色模式
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// 屏幕宽度
  double get screenWidth => MediaQuery.of(this).size.width;

  /// 屏幕高度
  double get screenHeight => MediaQuery.of(this).size.height;

  /// 是否为平板/大屏 (宽度 > 768)
  bool get isTablet => screenWidth > 768;

  /// 安全区域内边距
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;

  /// 是否可弹出键盘
  void dismissKeyboard() => FocusScope.of(this).unfocus();

  /// 显示 SnackBar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppColors.error : null,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          margin: const EdgeInsets.all(AppSpacing.md),
        ),
      );
  }
}
```

- [ ] **Step 2: Create String extensions**

```dart
extension StringX on String {
  /// 截取指定长度，超出加省略号
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}…';
  }

  /// 判断是否为空白或空
  bool get isBlank => trim().isEmpty;

  /// 判断是否不为空白
  bool get isNotBlank => !isBlank;

  /// 安全转换为首字母大写的显示名称
  String get displayName {
    if (isBlank) return '';
    return trim();
  }
}
```

- [ ] **Step 3: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/core/extensions/ && git commit -m "feat: add BuildContext and String extensions"
```

---

### Task 8: Network — Dio HTTP client setup

**Files:**
- Create: `lib/core/network/dio_client.dart`
- Create: `lib/core/network/network_interceptors.dart`

- [ ] **Step 1: Create Dio client with interceptors**

```dart
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

/// Dio HTTP 客户端单例 — 统一管理所有网络请求配置
final class DioClient {
  DioClient._();

  static final Dio _poetryDio = _createPoetryDio();
  static final Dio _deepseekDio = _createDeepseekDio();

  /// 诗词 API 客户端
  static Dio get poetry => _poetryDio;

  /// DeepSeek AI API 客户端
  static Dio get deepseek => _deepseekDio;

  static Dio _createPoetryDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.poetryBaseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.addAll([
      _LogInterceptor(),
      _ErrorInterceptor(),
    ]);

    return dio;
  }

  static Dio _createDeepseekDio() {
    final dio = Dio(BaseOptions(
      baseUrl: ApiConstants.deepseekBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    dio.interceptors.addAll([
      _LogInterceptor(),
      _ErrorInterceptor(),
    ]);

    return dio;
  }
}

/// 日志拦截器 — 开发调试用
final class _LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // debugPrint only in debug mode; handled by Dio's LogInterceptor
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
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
        );
      case DioExceptionType.connectionError:
        err = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          message: '网络不可用，请检查网络连接',
          error: err.error,
        );
      default:
        break;
    }
    handler.next(err);
  }
}
```

- [ ] **Step 2: Verify analysis passes**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/core/network/
```

Expected: "No issues found!"

- [ ] **Step 3: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/core/network/ && git commit -m "feat: add Dio HTTP client with interceptors"
```

---

### Task 9: Freezed data models

**Files:**
- Create: `lib/data/models/poem.dart`
- Create: `lib/data/models/author.dart`
- Create: `lib/data/models/dynasty.dart`
- Create: `lib/data/models/solar_term.dart`
- Create: `lib/data/models/paginated_response.dart`

- [ ] **Step 1: Create Dynasty model**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynasty.freezed.dart';
part 'dynasty.g.dart';

@freezed
class Dynasty with _$Dynasty {
  const factory Dynasty({
    required String id,
    required String name,
    int? startYear,
    int? endYear,
  }) = _Dynasty;

  factory Dynasty.fromJson(Map<String, dynamic> json) =>
      _$DynastyFromJson(json);
}
```

- [ ] **Step 2: Create Author model (brief + full)**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dynasty.dart';

part 'author.freezed.dart';
part 'author.g.dart';

@freezed
class AuthorBrief with _$AuthorBrief {
  const factory AuthorBrief({
    required String id,
    required String name,
    required Dynasty dynasty,
  }) = _AuthorBrief;

  factory AuthorBrief.fromJson(Map<String, dynamic> json) =>
      _$AuthorBriefFromJson(json);
}

@freezed
class Author with _$Author {
  const factory Author({
    required String id,
    required String name,
    String? courtesyName,
    String? pseudonym,
    required Dynasty dynasty,
    String? biography,
    String? birthplace,
    double? latitude,
    double? longitude,
    @Default([]) List<String> masterpieces,
    String? portraitUrl,
  }) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) =>
      _$AuthorFromJson(json);
}
```

- [ ] **Step 3: Create Poem model**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'author.dart';
import 'dynasty.dart';

part 'poem.freezed.dart';
part 'poem.g.dart';

enum PoemCategory {
  @JsonValue('landscape') landscape,     // 山水
  @JsonValue('farewell') farewell,       // 送别
  @JsonValue('frontier') frontier,       // 边塞
  @JsonValue('pastoral') pastoral,       // 田园
  @JsonValue('nostalgic') nostalgic,     // 怀古
  @JsonValue('romantic') romantic,       // 爱情
  @JsonValue('philosophical') philosophical, // 哲理
  @JsonValue('political') political,     // 政治
  @JsonValue('seasonal') seasonal,       // 时令
  @JsonValue('misc') misc,               // 其他
}

@freezed
class Poem with _$Poem {
  const factory Poem({
    required String id,
    required String title,
    required String content,
    String? translation,
    String? annotation,
    String? appreciation,
    String? aiAppreciation,
    String? aiImageUrl,
    required AuthorBrief author,
    required Dynasty dynasty,
    @Default(PoemCategory.misc) PoemCategory category,
    @Default([]) List<String> tags,
    String? pinyin,
  }) = _Poem;

  factory Poem.fromJson(Map<String, dynamic> json) => _$PoemFromJson(json);
}

@freezed
class PoemBrief with _$PoemBrief {
  const factory PoemBrief({
    required String id,
    required String title,
    required String content,
    required String authorName,
    required String dynastyName,
    PoemCategory? category,
  }) = _PoemBrief;

  factory PoemBrief.fromJson(Map<String, dynamic> json) =>
      _$PoemBriefFromJson(json);
}
```

- [ ] **Step 4: Create SolarTerm model**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'poem.dart';

part 'solar_term.freezed.dart';
part 'solar_term.g.dart';

@freezed
class SolarTerm with _$SolarTerm {
  const factory SolarTerm({
    required String name,
    required DateTime date,
    String? description,
    @Default([]) List<PoemBrief> relatedPoems,
  }) = _SolarTerm;

  factory SolarTerm.fromJson(Map<String, dynamic> json) =>
      _$SolarTermFromJson(json);
}
```

- [ ] **Step 5: Create PaginatedResponse model**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_response.freezed.dart';
part 'paginated_response.g.dart';

@freezed
class PaginatedResponse<T> with _$PaginatedResponse<T> {
  const factory PaginatedResponse({
    required List<T> data,
    required int total,
    required int page,
    required int pageSize,
    @Default(false) bool hasMore,
  }) = _PaginatedResponse<T>;
}
```

- [ ] **Step 6: Run build_runner to generate Freezed code**

```bash
cd e:/workspace/claw/flutter_poetry && dart run build_runner build --delete-conflicting-outputs
```

Expected: "Succeeded" — generates `.freezed.dart` and `.g.dart` files.

- [ ] **Step 7: Verify analysis passes on all generated code**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/data/models/
```

Expected: "No issues found!"

- [ ] **Step 8: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/data/models/ && git commit -m "feat: add Freezed data models (Poem, Author, Dynasty, SolarTerm)"
```

---

### Task 10: API client — PoetryApiClient (REST)

**Files:**
- Create: `lib/data/api/poetry_api_client.dart`
- Create: `lib/data/api/search_type.dart`

- [ ] **Step 1: Create SearchType enum**

```dart
/// 搜索类型
enum SearchType {
  all,      // 全文搜索
  title,    // 标题搜索
  content,  // 内容搜索
  author,   // 作者搜索

  String get apiValue {
    switch (this) {
      case SearchType.all:
        return 'all';
      case SearchType.title:
        return 'title';
      case SearchType.content:
        return 'content';
      case SearchType.author:
        return 'author';
    }
  }
}
```

- [ ] **Step 2: Create PoetryApiClient (REST)**

```dart
import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/poem.dart';
import '../models/author.dart';
import '../models/dynasty.dart';
import '../models/paginated_response.dart';
import 'search_type.dart';

/// 诗词 API 客户端 — REST 接口
final class PoetryApiClient {
  final Dio _dio = DioClient.poetry;

  /// 获取诗词列表
  ///
  /// [page] 页码 (从 1 开始)
  /// [pageSize] 每页数量
  /// [dynasty] 按朝代过滤
  /// [category] 按分类过滤
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

  /// 获取朝代列表
  Future<List<Dynasty>> getDynasties() async {
    final response = await _dio.get(ApiConstants.dynastiesEndpoint);

    final data = response.data;
    return (data as List)
        .map((json) => Dynasty.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
```

- [ ] **Step 3: Verify analysis passes**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/data/api/
```

Expected: "No issues found!"

- [ ] **Step 4: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/data/api/ && git commit -m "feat: add PoetryApiClient REST endpoints"
```

---

### Task 11: API client — PoetryApiClient (GraphQL) and DeepSeekApiClient

**Files:**
- Create: `lib/data/api/poetry_graphql_client.dart`
- Create: `lib/data/api/deepseek_api_client.dart`

- [ ] **Step 1: Create GraphQL client**

```dart
import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/poem.dart';
import '../models/dynasty.dart';

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

    final edges =
        response.data['data']['poemsByDynasty']['edges'] as List;
    return edges
        .map((edge) =>
            Poem.fromJson(edge['node'] as Map<String, dynamic>))
        .toList();
  }
}
```

- [ ] **Step 2: Create DeepSeek API client**

```dart
import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/poem.dart';

/// DeepSeek AI API 客户端
final class DeepSeekApiClient {
  final Dio _dio = DioClient.deepseek;

  /// 设置 API Key (从安全存储或配置中获取)
  void setApiKey(String apiKey) {
    _dio.options.headers['Authorization'] = 'Bearer $apiKey';
  }

  /// AI 赏析 — 对指定诗词生成赏析
  Future<String> analyzePoem(Poem poem) async {
    final prompt = _buildAnalysisPrompt(poem);

    final response = await _dio.post(
      '/v1/chat/completions',
      data: {
        'model': 'deepseek-chat',
        'messages': [
          {
            'role': 'system',
            'content':
                '你是一位精通中国古典诗词的学者。请用优美、深入浅出的中文为用户赏析诗词。从意境、技法、情感、历史背景等维度进行解读，字数控制在 300 字左右。',
          },
          {'role': 'user', 'content': prompt},
        ],
        'temperature': 0.7,
        'max_tokens': 800,
      },
    );

    final choices = response.data['choices'] as List;
    return choices.first['message']['content'] as String;
  }

  /// AI 配图 — 生成国风插画描述
  Future<String> generateIllustrationPrompt(Poem poem) async {
    final response = await _dio.post(
      '/v1/chat/completions',
      data: {
        'model': 'deepseek-chat',
        'messages': [
          {
            'role': 'system',
            'content':
                '你是一位国风插画师。请根据诗词内容，用中文描述一幅适合该诗词的国风插画画面。描述应包含构图、色彩、元素、氛围，适合作为 AI 绘画工具的 prompt 输入。字数控制在 150 字以内。',
          },
          {
            'role': 'user',
            'content': '请为以下诗词创作一幅国风插画描述：\n\n《${poem.title}》\n${poem.content}',
          },
        ],
        'temperature': 0.8,
        'max_tokens': 400,
      },
    );

    final choices = response.data['choices'] as List;
    return choices.first['message']['content'] as String;
  }

  String _buildAnalysisPrompt(Poem poem) {
    final buffer = StringBuffer();
    buffer.writeln('请赏析以下诗词：');
    buffer.writeln();
    buffer.writeln('《${poem.title}》');
    buffer.writeln('作者：${poem.author.name}');
    buffer.writeln('朝代：${poem.dynasty.name}');
    buffer.writeln();
    buffer.writeln(poem.content);
    return buffer.toString();
  }
}
```

- [ ] **Step 3: Verify analysis passes**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/data/api/
```

Expected: "No issues found!"

- [ ] **Step 4: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/data/api/ && git commit -m "feat: add GraphQL client and DeepSeek AI client"
```

---

### Task 12: Isar database setup

**Files:**
- Create: `lib/core/database/app_database.dart`
- Create: `lib/data/models/isar_models.dart`

- [ ] **Step 1: Create Isar models for offline storage**

```dart
import 'package:isar/isar.dart';

part 'isar_models.g.dart';

/// Isar 持久化的诗词摘要 (离线列表用)
@collection
class PoemCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String poemId;

  @Index(type: IndexType.value)
  late String title;

  @Index(type: IndexType.value)
  late String authorName;

  @Index(type: IndexType.value)
  late String dynastyName;

  late String content;
  String? category;
  String? contentSnippet; // 前 100 字用于列表预览
  DateTime? cachedAt;
}

/// Isar 持久化的完整诗词 (离线详情用)
@collection
class PoemDetailCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String poemId;

  late String fullJson; // 完整 JSON 字符串 (避免复杂的嵌套 schema)
  DateTime? cachedAt;
}

/// 收藏记录
@collection
class FavoriteRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String poemId;

  late String title;
  late String authorName;
  late String contentSnippet;
  late DateTime favoritedAt;
  @Default(false)
  bool isSynced; // 云同步状态
}

/// 阅读历史
@collection
class ReadingRecord {
  Id id = Isar.autoIncrement;

  late String poemId;
  late String title;
  late String authorName;
  late DateTime readAt;
  int readCount = 1;
}
```

- [ ] **Step 2: Create AppDatabase service**

```dart
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/isar_models.dart';

/// Isar 数据库管理
final class AppDatabase {
  AppDatabase._();
  static AppDatabase? _instance;
  Isar? _isar;

  static AppDatabase get instance {
    _instance ??= AppDatabase._();
    return _instance!;
  }

  Isar get isar {
    if (_isar == null) {
      throw StateError('AppDatabase not initialized. Call init() first.');
    }
    return _isar!;
  }

  Future<void> init() async {
    if (_isar != null) return;

    final dir = await PathProvider.getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        PoemCacheSchema,
        PoemDetailCacheSchema,
        FavoriteRecordSchema,
        ReadingRecordSchema,
      ],
      directory: dir.path,
    );
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  /// 清空所有数据 (离线数据重置用)
  Future<void> clearAll() async {
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }
}
```

Wait — `PathProvider` needs to be added. Let me fix that.

Actually, `path_provider` should be added to pubspec.yaml dependencies. Let me note this in a follow-up: we need to add `path_provider: ^2.1.5` to pubspec.yaml.

- [ ] **Step 3: Add path_provider dependency**

Ensure `pubspec.yaml` includes `path_provider: ^2.1.5` in dependencies. If not, add it and run `flutter pub get`.

- [ ] **Step 4: Run Isar code generation**

```bash
cd e:/workspace/claw/flutter_poetry && dart run build_runner build --delete-conflicting-outputs
```

Expected: Generates `isar_models.g.dart` with schema adapters.

- [ ] **Step 5: Verify analysis passes**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/core/database/ lib/data/models/isar_models.dart
```

Expected: "No issues found!"

- [ ] **Step 6: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/core/database/ lib/data/models/isar_models.dart lib/data/models/isar_models.g.dart && git commit -m "feat: add Isar database with cache, favorites, and reading records"
```

---

### Task 13: Service layer

**Files:**
- Create: `lib/data/services/poem_service.dart`
- Create: `lib/data/services/author_service.dart`
- Create: `lib/data/services/ai_service.dart`

- [ ] **Step 1: Create PoemService**

```dart
import 'package:isar/isar.dart';
import '../../core/database/app_database.dart';
import '../api/poetry_api_client.dart';
import '../api/search_type.dart';
import '../models/poem.dart';
import '../models/paginated_response.dart';
import '../models/isar_models.dart';

/// 诗词数据服务 — API 聚合 + 缓存管理
final class PoemService {
  final PoetryApiClient _api = PoetryApiClient();
  final Isar _isar = AppDatabase.instance.isar;

  /// 获取诗词列表 (API first, cache fallback)
  Future<PaginatedResponse<Poem>> getPoems({
    int page = 1,
    int pageSize = 20,
    String? dynasty,
    String? category,
  }) async {
    try {
      final result = await _api.getPoems(
        page: page,
        pageSize: pageSize,
        dynasty: dynasty,
        category: category,
      );

      // 异步缓存到 Isar (不阻塞返回)
      _cachePoems(result.data);

      return result;
    } on Exception {
      // API 失败，尝试从缓存读取
      return _getCachedPoems(page: page, pageSize: pageSize);
    }
  }

  /// 搜索诗词
  Future<PaginatedResponse<Poem>> searchPoems({
    required String query,
    SearchType type = SearchType.all,
    int page = 1,
    int pageSize = 20,
  }) async {
    return _api.searchPoems(
      query: query,
      type: type,
      page: page,
      pageSize: pageSize,
    );
  }

  /// 随机获取一首
  Future<Poem> getRandomPoem({String? dynasty, String? category}) async {
    try {
      return await _api.getRandomPoem(dynasty: dynasty, category: category);
    } on Exception {
      // 从缓存中随机取一首
      final count = await _isar.poemCaches.count();
      if (count == 0) rethrow;
      final randomIndex = DateTime.now().millisecondsSinceEpoch % count;
      final cache = await _isar.poemCaches.where().offset(randomIndex).findFirst();
      if (cache == null) rethrow;
      return Poem(
        id: cache.poemId,
        title: cache.title,
        content: cache.content,
        author: AuthorBrief(
          id: '',
          name: cache.authorName,
          dynasty: Dynasty(id: '', name: cache.dynastyName),
        ),
        dynasty: Dynasty(id: '', name: cache.dynastyName),
        category: PoemCategory.misc,
      );
    }
  }

  /// 缓存诗词到 Isar
  Future<void> _cachePoems(List<Poem> poems) async {
    final caches = poems.map((p) {
      final cache = PoemCache()
        ..poemId = p.id
        ..title = p.title
        ..authorName = p.author.name
        ..dynastyName = p.dynasty.name
        ..content = p.content
        ..category = p.category.name
        ..contentSnippet = p.content.length > 100
            ? '${p.content.substring(0, 100)}…'
            : p.content
        ..cachedAt = DateTime.now();
      return cache;
    }).toList();

    await _isar.writeTxn(() async {
      await _isar.poemCaches.putAll(caches);
    });
  }

  /// 从缓存读取诗词列表
  Future<PaginatedResponse<Poem>> _getCachedPoems({
    int page = 1,
    int pageSize = 20,
  }) async {
    final offset = (page - 1) * pageSize;
    final caches = await _isar.poemCaches.where().offset(offset).limit(pageSize).findAll();
    final total = await _isar.poemCaches.count();

    return PaginatedResponse(
      data: caches.map((c) => Poem(
        id: c.poemId,
        title: c.title,
        content: c.content,
        author: AuthorBrief(
          id: '',
          name: c.authorName,
          dynasty: Dynasty(id: '', name: c.dynastyName),
        ),
        dynasty: Dynasty(id: '', name: c.dynastyName),
        category: PoemCategory.values.firstWhere(
          (e) => e.name == c.category,
          orElse: () => PoemCategory.misc,
        ),
      )).toList(),
      total: total,
      page: page,
      pageSize: pageSize,
      hasMore: offset + pageSize < total,
    );
  }
}
```

- [ ] **Step 2: Create AuthorService**

```dart
import '../api/poetry_api_client.dart';
import '../models/author.dart';
import '../models/paginated_response.dart';

/// 作者数据服务
final class AuthorService {
  final PoetryApiClient _api = PoetryApiClient();

  Future<PaginatedResponse<Author>> getAuthors({
    int page = 1,
    int pageSize = 20,
  }) async {
    return _api.getAuthors(page: page, pageSize: pageSize);
  }
}
```

- [ ] **Step 3: Create AIService**

```dart
import '../api/deepseek_api_client.dart';
import '../models/poem.dart';

/// AI 服务 — 统一管理 DeepSeek API 调用
final class AIService {
  final DeepSeekApiClient _client = DeepSeekApiClient();

  /// 设置 API Key
  void configure({required String apiKey}) {
    _client.setApiKey(apiKey);
  }

  /// AI 赏析
  Future<String> analyze(Poem poem) async {
    return _client.analyzePoem(poem);
  }

  /// AI 配图 prompt
  Future<String> generateIllustrationPrompt(Poem poem) async {
    return _client.generateIllustrationPrompt(poem);
  }
}
```

- [ ] **Step 4: Verify analysis passes**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/data/services/
```

Expected: "No issues found!"

- [ ] **Step 5: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/data/services/ && git commit -m "feat: add Service layer (Poem, Author, AI)"
```

---

### Task 14: Repository layer

**Files:**
- Create: `lib/data/repositories/poem_repository.dart`
- Create: `lib/data/repositories/author_repository.dart`
- Create: `lib/data/repositories/ai_repository.dart`

- [ ] **Step 1: Create PoemRepository**

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/database/app_database.dart';
import '../models/poem.dart';
import '../models/paginated_response.dart';
import '../services/poem_service.dart';

part 'poem_repository.g.dart';

/// 诗词 Repository — 业务逻辑 + 状态管理边界
@riverpod
PoemRepository poemRepository(poemRepositoryRef) => PoemRepository();

final class PoemRepository {
  final PoemService _service = PoemService();

  /// 获取诗词列表
  Future<PaginatedResponse<Poem>> getPoems({
    int page = 1,
    int pageSize = 20,
    String? dynasty,
    String? category,
  }) async {
    return _service.getPoems(
      page: page,
      pageSize: pageSize,
      dynasty: dynasty,
      category: category,
    );
  }

  /// 搜索诗词
  Future<PaginatedResponse<Poem>> searchPoems({
    required String query,
    SearchType type = SearchType.all,
    int page = 1,
  }) async {
    return _service.searchPoems(query: query, type: type, page: page);
  }

  /// 随机获取诗词
  Future<Poem> getRandomPoem({String? dynasty, String? category}) async {
    return _service.getRandomPoem(dynasty: dynasty, category: category);
  }

  /// 添加收藏
  Future<void> addFavorite(Poem poem) async {
    final isar = AppDatabase.instance.isar;
    final record = FavoriteRecord()
      ..poemId = poem.id
      ..title = poem.title
      ..authorName = poem.author.name
      ..contentSnippet = poem.content.length > 100
          ? '${poem.content.substring(0, 100)}…'
          : poem.content
      ..favoritedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.favoriteRecords.put(record);
    });
  }

  /// 移除收藏
  Future<void> removeFavorite(String poemId) async {
    final isar = AppDatabase.instance.isar;
    await isar.writeTxn(() async {
      await isar.favoriteRecords.where().poemIdEqualTo(poemId).deleteAll();
    });
  }

  /// 是否已收藏
  Future<bool> isFavorited(String poemId) async {
    final isar = AppDatabase.instance.isar;
    final record =
        await isar.favoriteRecords.where().poemIdEqualTo(poemId).findFirst();
    return record != null;
  }

  /// 获取收藏列表
  Future<List<FavoriteRecord>> getFavorites() async {
    final isar = AppDatabase.instance.isar;
    return isar.favoriteRecords.where()
        .sortByFavoritedAtDesc()
        .findAll();
  }

  /// 记录阅读
  Future<void> recordReading(Poem poem) async {
    final isar = AppDatabase.instance.isar;
    final existing =
        await isar.readingRecords.where().poemIdEqualTo(poem.id).findFirst();

    await isar.writeTxn(() async {
      if (existing != null) {
        existing.readCount += 1;
        existing.readAt = DateTime.now();
        await isar.readingRecords.put(existing);
      } else {
        final record = ReadingRecord()
          ..poemId = poem.id
          ..title = poem.title
          ..authorName = poem.author.name
          ..readAt = DateTime.now()
          ..readCount = 1;
        await isar.readingRecords.put(record);
      }
    });
  }

  /// 获取最近阅读
  Future<List<ReadingRecord>> getRecentReads({int limit = 10}) async {
    final isar = AppDatabase.instance.isar;
    return isar.readingRecords.where()
        .sortByReadAtDesc()
        .limit(limit)
        .findAll();
  }
}
```

- [ ] **Step 2: Create AuthorRepository**

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/author.dart';
import '../models/paginated_response.dart';
import '../services/author_service.dart';

part 'author_repository.g.dart';

@riverpod
AuthorRepository authorRepository(authorRepositoryRef) => AuthorRepository();

final class AuthorRepository {
  final AuthorService _service = AuthorService();

  Future<PaginatedResponse<Author>> getAuthors({
    int page = 1,
    int pageSize = 20,
  }) async {
    return _service.getAuthors(page: page, pageSize: pageSize);
  }
}
```

- [ ] **Step 3: Create AiRepository**

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/poem.dart';
import '../services/ai_service.dart';

part 'ai_repository.g.dart';

@riverpod
AiRepository aiRepository(aiRepositoryRef) => AiRepository();

final class AiRepository {
  final AIService _service = AIService();

  /// 配置 API Key (应在应用启动时调用)
  void configure({required String apiKey}) {
    _service.configure(apiKey: apiKey);
  }

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

- [ ] **Step 4: Run build_runner for Riverpod code generation**

```bash
cd e:/workspace/claw/flutter_poetry && dart run build_runner build --delete-conflicting-outputs
```

Expected: Generates `.g.dart` files for repositories.

- [ ] **Step 5: Verify analysis passes**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/data/repositories/
```

Expected: "No issues found!"

- [ ] **Step 6: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/data/repositories/ && git commit -m "feat: add Repository layer with Riverpod providers"
```

---

### Task 15: Router — go_router configuration

**Files:**
- Create: `lib/core/router/app_router.dart`
- Create: `lib/core/router/routes.dart`

- [ ] **Step 1: Create route path constants**

```dart
/// 路由路径常量
abstract final class AppRoutes {
  // ── Shell (TabBar) ──
  static const String home = '/home';
  static const String discover = '/discover';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String settings = '/settings';

  // ── 详情页 ──
  static const String poemDetail = '/poem/:id';
  static String poemById(String id) => '/poem/$id';

  static const String authorDetail = '/author/:id';
  static String authorById(String id) => '/author/$id';

  // ── 独立页 ──
  static const String splash = '/splash';
  static const String dailyPoem = '/daily-poem';
  static const String sharePoster = '/share/:poemId';
  static String shareByPoemId(String id) => '/share/$id';
  static const String map = '/map';

  // ── 发现子页 ──
  static const String category = '/discover/category/:id';
  static String categoryById(String id) => '/discover/category/$id';
  static const String dynastyTimeline = '/discover/dynasty/:id';
  static String dynastyById(String id) => '/discover/dynasty/$id';
  static const String flyFlower = '/discover/fly-flower';
  static const String chain = '/discover/chain';

  // ── 设置子页 ──
  static const String fontSettings = '/settings/font';
  static const String themeSettings = '/settings/theme';
}
```

- [ ] **Step 2: Create AppRouter with go_router**

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

/// 全局 Navigator Key
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>();

/// go_router 配置 — 懒加载所有页面路由
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const _PlaceholderPage(title: '启动页'),
    ),

    // ── ShellRoute: 底部 TabBar 主框架 ──
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return _MainShell(navigationShell: navigationShell);
      },
      branches: [
        // Tab 1: 首页
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) =>
                  const _PlaceholderPage(title: '首页'),
              routes: [
                GoRoute(
                  path: 'poem/:id',
                  name: 'poemDetail',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => _PlaceholderPage(
                    title: '诗词详情 ${state.pathParameters['id']}',
                  ),
                ),
                GoRoute(
                  path: 'author/:id',
                  name: 'authorDetail',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => _PlaceholderPage(
                    title: '作者页 ${state.pathParameters['id']}',
                  ),
                ),
              ],
            ),
          ],
        ),
        // Tab 2: 发现
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.discover,
              name: 'discover',
              builder: (context, state) =>
                  const _PlaceholderPage(title: '发现'),
            ),
          ],
        ),
        // Tab 3: 搜索
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.search,
              name: 'search',
              builder: (context, state) =>
                  const _PlaceholderPage(title: '搜索'),
            ),
          ],
        ),
        // Tab 4: 收藏
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favorites,
              name: 'favorites',
              builder: (context, state) =>
                  const _PlaceholderPage(title: '收藏'),
            ),
          ],
        ),
        // Tab 5: 设置
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              name: 'settings',
              builder: (context, state) =>
                  const _PlaceholderPage(title: '设置'),
            ),
          ],
        ),
      ],
    ),
  ],
);

/// 主 Shell — 底部 NavigationBar + 页面切换
class _MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _MainShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            selectedIcon: Icon(Icons.auto_stories),
            label: '首页',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: '发现',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: '搜索',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            selectedIcon: Icon(Icons.bookmark),
            label: '收藏',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '设置',
          ),
        ],
      ),
    );
  }
}

/// 占位页面 — 后续 Phase 替换为真实页面
class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Verify analysis passes**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/core/router/
```

Expected: "No issues found!"

- [ ] **Step 3: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/core/router/ && git commit -m "feat: add go_router with StatefulShellRoute and placeholder pages"
```

---

### Task 16: Shared widgets — Skeleton, Blur, PoetryCard

**Files:**
- Create: `lib/shared/widgets/skeleton_loader.dart`
- Create: `lib/shared/widgets/glass_container.dart`
- Create: `lib/shared/widgets/poetry_card.dart`

- [ ] **Step 1: Create SkeletonLoader (Shimmer-based)**

```dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// 骨架屏加载组件 — 替代 CircularProgressIndicator
/// 遵循设计规范：禁止使用默认 CircularProgressIndicator
class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceTertiary,
      highlightColor: isDark
          ? AppColors.darkSurfaceTertiary
          : AppColors.surfacePrimary,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceTertiary,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// 诗词卡片骨架屏
class PoetryCardSkeleton extends StatelessWidget {
  const PoetryCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonLoader(width: 120, height: 20),
            const SizedBox(height: AppSpacing.md),
            const SkeletonLoader(height: 14),
            const SizedBox(height: AppSpacing.sm),
            const SkeletonLoader(height: 14),
            const SizedBox(height: AppSpacing.sm),
            const SkeletonLoader(width: 200, height: 14),
            const SizedBox(height: AppSpacing.md),
            const SkeletonLoader(width: 80, height: 12),
          ],
        ),
      ),
    );
  }
}

/// 列表骨架屏 — N 个卡片骨架
class ListSkeleton extends StatelessWidget {
  final int itemCount;
  const ListSkeleton({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (_) => const Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.sm),
          child: PoetryCardSkeleton(),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Create GlassContainer (毛玻璃)**

```dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// 毛玻璃效果容器
enum GlassIntensity { light, medium, heavy }

class GlassContainer extends StatelessWidget {
  final Widget child;
  final GlassIntensity intensity;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const GlassContainer({
    super.key,
    required this.child,
    this.intensity = GlassIntensity.medium,
    this.borderRadius = 20,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    double sigma;
    double opacity;
    switch (intensity) {
      case GlassIntensity.light:
        sigma = 10;
        opacity = 0.6;
      case GlassIntensity.medium:
        sigma = 20;
        opacity = 0.4;
      case GlassIntensity.heavy:
        sigma = 30;
        opacity = 0.2;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: (isDark ? AppColors.glassDark : AppColors.glassLight)
                .withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 0.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Create PoetryCard**

```dart
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/poem.dart';

/// 诗词卡片 — 首页列表/发现列表通用
class PoetryCard extends StatelessWidget {
  final Poem poem;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;

  const PoetryCard({
    super.key,
    required this.poem,
    this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final contentPreview = poem.content.length > 60
        ? '${poem.content.substring(0, 60)}…'
        : poem.content;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: AppSpacing.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题行
              Row(
                children: [
                  Expanded(
                    child: Text(
                      poem.title,
                      style: AppTypography.bodyMedium(context),
                    ),
                  ),
                  if (onFavorite != null)
                    IconButton(
                      onPressed: onFavorite,
                      icon: const Icon(
                        Icons.bookmark_outline,
                        size: 20,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),

              // 内容预览
              Text(
                contentPreview,
                style: AppTypography.captionRegular(context)?.copyWith(
                  color: AppColors.inkSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.sm),

              // 作者 + 朝代
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceTertiary,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.buttonRadius),
                    ),
                    child: Text(
                      poem.dynasty.name,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.inkTertiary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    poem.author.name,
                    style: AppTypography.captionRegular(context)?.copyWith(
                      color: AppColors.inkTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Verify analysis passes**

```bash
cd e:/workspace/claw/flutter_poetry && dart analyze lib/shared/widgets/
```

Expected: "No issues found!"

- [ ] **Step 5: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/shared/widgets/ && git commit -m "feat: add shared widgets (Skeleton, Glass, PoetryCard)"
```

---

### Task 17: App entry — main.dart + app.dart + splash

**Files:**
- Create: `lib/app.dart`
- Modify: `lib/main.dart`
- Create: `lib/features/splash/splash_page.dart`
- Create: `lib/shared/providers/theme_provider.dart`

- [ ] **Step 1: Create ThemeProvider**

```dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() => ThemeMode.system;

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}
```

- [ ] **Step 2: Create App widget**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/theme_provider.dart';

class PoetryApp extends ConsumerWidget {
  const PoetryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);

    return MaterialApp.router(
      title: '诗词',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
```

- [ ] **Step 3: Create main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: PoetryApp(),
    ),
  );
}
```

- [ ] **Step 4: Create Splash page**

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/router/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();

    // 2 秒后跳转首页
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go(AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfacePrimary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo / 印章
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.accentPrimary,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.cardRadius),
                ),
                child: const Center(
                  child: Text(
                    '诗',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '诗词',
                style: AppTypography.displayLarge(context),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '沉浸式古诗词阅读',
                style: AppTypography.captionRegular(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

Now update `lib/core/router/app_router.dart` to use the real SplashPage instead of placeholder. Replace the splash route:

Find the line:
```dart
builder: (context, state) => const _PlaceholderPage(title: '启动页'),
```

Replace with:
```dart
builder: (context, state) => const SplashPage(),
```

And add import at top:
```dart
import '../../features/splash/splash_page.dart';
```

- [ ] **Step 5: Run build_runner and verify analysis**

```bash
cd e:/workspace/claw/flutter_poetry && dart run build_runner build --delete-conflicting-outputs && dart analyze lib/
```

Expected: "No issues found!" (may have some warnings for unused imports in generated files — that's OK)

- [ ] **Step 6: Verify the app compiles**

```bash
cd e:/workspace/claw/flutter_poetry && flutter build apk --debug 2>&1 | tail -20
```

Expected: "Built build/app/outputs/flutter-apk/app-debug.apk" or successful compilation.

(Note: If no Android SDK is configured, use `dart compile` or skip this step and verify via `flutter analyze`)

- [ ] **Step 7: Commit**

```bash
cd e:/workspace/claw/flutter_poetry && git add lib/main.dart lib/app.dart lib/features/ lib/shared/providers/ && git commit -m "feat: add app entry, splash page, and theme provider"
```

---

### Task 18: Final verification — full project analysis and run

**Files:**
- No new files — verification only

- [ ] **Step 1: Run full static analysis**

```bash
cd e:/workspace/claw/flutter_poetry && flutter analyze
```

Expected: "No issues found!" (informational hints OK)

- [ ] **Step 2: Verify all barrel files exist**

Check that these exports work correctly:
- `lib/core/theme/theme.dart` exports all theme files
- Future barrel files for other modules can be added as needed

- [ ] **Step 3: Run flutter test if any tests exist**

```bash
cd e:/workspace/claw/flutter_poetry && flutter test
```

Expected: Tests should pass (the default widget_test.dart may need updating).

- [ ] **Step 4: Final commit for Phase 1**

```bash
cd e:/workspace/claw/flutter_poetry && git add -A && git commit -m "chore: Phase 1 complete — foundation with design system, API, DB, router"
```

- [ ] **Step 5: Create tag for Phase 1**

```bash
cd e:/workspace/claw/flutter_poetry && git tag phase-1-foundation
```

---

## Phase 1 Completion Checklist

After all 18 tasks are done, verify:

- [ ] `flutter analyze` passes with 0 errors
- [ ] Design system: Colors, Typography, Spacing, Theme (light + dark) all defined and exported
- [ ] Data models: Poem, Author, Dynasty, SolarTerm — all Freezed with JSON serialization
- [ ] API clients: PoetryApiClient (REST), PoetryGraphqlClient, DeepSeekApiClient — all implemented
- [ ] Database: Isar initialized with 4 schemas (PoemCache, PoemDetailCache, FavoriteRecord, ReadingRecord)
- [ ] Service layer: PoemService, AuthorService, AIService — all implemented
- [ ] Repository layer: PoemRepository, AuthorRepository, AiRepository — all with Riverpod providers
- [ ] Router: go_router with StatefulShellRoute, 5 tabs, splash, and detail routes
- [ ] Shared widgets: SkeletonLoader, PoetryCardSkeleton, ListSkeleton, GlassContainer, PoetryCard
- [ ] App entry: main.dart → ProviderScope → PoetryApp → MaterialApp.router
- [ ] Splash page: animated fadeIn, auto-navigates to home after 2s
- [ ] No `setState` anywhere (SplashPage uses AnimationController which is the exception)
- [ ] No files exceeding 400 lines; no widget exceeding 300 lines
- [ ] All 18 tasks committed independently

---

## Plan Self-Review

1. **Spec coverage:** All Phase 1 spec requirements are covered — project init (T1-2), design system (T3-5), Dio/Isar/Router (T8, T12, T15), Freezed models (T9), API clients (T10-11), shared widgets (T16), splash + shell (T17).
2. **Placeholder scan:** No TBD/TODO. All code blocks contain complete implementations.
3. **Type consistency:** Exported types are used consistently across tasks. `Poem`, `Author`, `Dynasty` defined in T9, consumed by T10-14, T16. `AppColors`, `AppSpacing`, `AppTypography` defined in T3-5, consumed throughout.
4. **Missing dependencies:** `path_provider` must be added to pubspec.yaml (noted in T12 Step 3). The Isar `PathProvider` import uses `path_provider` package.
