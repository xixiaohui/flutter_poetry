/// 路由路径常量
abstract final class AppRoutes {
  // ── Shell (TabBar) ──
  static const String home = '/home';
  static const String discover = '/discover';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String settings = '/settings';

  // ── 首页子页 ──
  static const String poemDetail = '/home/poem/:id';
  static String poemById(String id) => '/home/poem/$id';

  static const String authorDetail = '/home/author/:id';
  static String authorById(String id) => '/home/author/$id';

  static const String stats = '/home/stats';

  // ── 发现子页 ──
  static const String discoverBrowse = '/discover/browse';
  static const String discoverDynasty = '/discover/dynasty/:name';
  static String dynastyByName(String name) => '/discover/dynasty/$name';
  static const String discoverType = '/discover/type/:name';
  static String typeByName(String name) => '/discover/type/$name';
  static const String discoverPoem = '/discover/poem/:id';
  static const String discoverAuthor = '/discover/author/:id';

  // ── 搜索子页 ──
  static const String searchPoem = '/search/poem/:id';
  static const String searchAuthor = '/search/author/:id';

  // ── 设置子页 ──
  static const String settingsProfile = '/settings/profile';
  static const String fontSettings = '/settings/font';
  static const String themeSettings = '/settings/theme';

  // ── 独立页 ──
  static const String splash = '/splash';
  static const String login = '/login';
  static const String aiChat = '/ai-chat';
  static const String dailyPoem = '/home/daily-poem';
}
