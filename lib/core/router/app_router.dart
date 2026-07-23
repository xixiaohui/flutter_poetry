import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';
import '../../features/author/author_page.dart';
import '../../features/auth/login_page.dart';
import '../../features/browse/browse_page.dart';
import '../../features/home/home_page.dart';
import '../../features/splash/splash_page.dart';
import '../../features/poem_detail/poem_detail_page.dart';

/// 全局 Navigator Key
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// go_router 配置 — 懒加载所有页面路由
final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),

    // ── 全屏 Modal 路由 ──
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.aiChat,
      name: 'aiChat',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>?;
        // TODO: Replace with AiChatPage when created (Task 17)
        return Scaffold(
          appBar: AppBar(title: Text(extra?['title'] ?? 'AI 对话')),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
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
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'poem/:id',
                  name: 'poemDetail',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => PoemDetailPage(
                    poemId: state.pathParameters['id']!,
                  ),
                ),
                GoRoute(
                  path: 'author/:id',
                  name: 'authorDetail',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => AuthorPage(
                    authorId: state.pathParameters['id']!,
                  ),
                ),
                GoRoute(
                  path: 'daily-poem',
                  name: 'dailyPoem',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) =>
                      const _PlaceholderPage(title: '每日一首'),
                ),
                GoRoute(
                  path: 'stats',
                  name: 'stats',
                  parentNavigatorKey: rootNavigatorKey,
                  // TODO: Replace with StatsPage when created (Task 18)
                  builder: (context, state) => Scaffold(
                    appBar: AppBar(title: const Text('统计')),
                    body: const Center(child: CircularProgressIndicator()),
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
              // TODO: Replace with DiscoverPage when created (Task 12)
              builder: (context, state) => Scaffold(
                appBar: AppBar(title: const Text('发现')),
                body: const Center(child: CircularProgressIndicator()),
              ),
              routes: [
                GoRoute(
                  path: 'browse',
                  name: 'discoverBrowse',
                  builder: (context, state) => const BrowsePage(
                    title: '浏览',
                  ),
                ),
                GoRoute(
                  path: 'dynasty/:name',
                  name: 'discoverDynasty',
                  builder: (context, state) => BrowsePage(
                    dynasty: state.pathParameters['name'],
                  ),
                ),
                GoRoute(
                  path: 'type/:name',
                  name: 'discoverType',
                  builder: (context, state) => BrowsePage(
                    type: state.pathParameters['name'],
                  ),
                ),
                GoRoute(
                  path: 'author/:id',
                  name: 'discoverAuthor',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => AuthorPage(
                    authorId: state.pathParameters['id']!,
                  ),
                ),
                GoRoute(
                  path: 'poem/:id',
                  name: 'discoverPoem',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => PoemDetailPage(
                    poemId: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Tab 3: 搜索
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.search,
              name: 'search',
              // TODO: Replace with SearchPage when created (Task 14)
              builder: (context, state) => Scaffold(
                appBar: AppBar(title: const Text('搜索')),
                body: const Center(child: CircularProgressIndicator()),
              ),
              routes: [
                GoRoute(
                  path: 'poem/:id',
                  name: 'searchPoem',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => PoemDetailPage(
                    poemId: state.pathParameters['id']!,
                  ),
                ),
                GoRoute(
                  path: 'author/:id',
                  name: 'searchAuthor',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => AuthorPage(
                    authorId: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Tab 4: 收藏
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favorites,
              name: 'favorites',
              // TODO: Replace with FavoritesPage when created (Task 15)
              builder: (context, state) => Scaffold(
                appBar: AppBar(title: const Text('收藏')),
                body: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
        // Tab 5: 设置
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.settings,
              name: 'settings',
              // TODO: Replace with SettingsPage when created (Task 16)
              builder: (context, state) => Scaffold(
                appBar: AppBar(title: const Text('设置')),
                body: const Center(child: CircularProgressIndicator()),
              ),
              routes: [
                GoRoute(
                  path: 'profile',
                  name: 'settingsProfile',
                  // TODO: Replace with profile page when created
                  builder: (context, state) => Scaffold(
                    appBar: AppBar(title: const Text('个人资料')),
                    body:
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
                GoRoute(
                  path: 'font',
                  name: 'fontSettings',
                  builder: (context, state) =>
                      const _PlaceholderPage(title: '字体设置'),
                ),
                GoRoute(
                  path: 'theme',
                  name: 'themeSettings',
                  builder: (context, state) =>
                      const _PlaceholderPage(title: '主题设置'),
                ),
              ],
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
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
}

/// 占位页面 — font/theme 设置页保留使用，其余页面创建后替换
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
