/// 路由路径常量
abstract final class AppRoutes {
  // ── Shell (TabBar) ──
  static const String home = '/home';
  static const String discover = '/discover';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String settings = '/settings';

  // ── 详情页 ──
  static const String poemDetail = '/home/poem/:id';
  static String poemById(String id) => '/home/poem/$id';

  static const String authorDetail = '/home/author/:id';
  static String authorById(String id) => '/home/author/$id';

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
