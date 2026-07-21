import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';
import '../../features/author/author_page.dart';
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
              routes: [
                GoRoute(
                  path: 'category/:id',
                  name: 'category',
                  builder: (context, state) => _PlaceholderPage(
                    title: '分类 ${state.pathParameters['id']}',
                  ),
                ),
                GoRoute(
                  path: 'dynasty/:id',
                  name: 'dynastyTimeline',
                  builder: (context, state) => _PlaceholderPage(
                    title: '朝代 ${state.pathParameters['id']}',
                  ),
                ),
                GoRoute(
                  path: 'fly-flower',
                  name: 'flyFlower',
                  builder: (context, state) =>
                      const _PlaceholderPage(title: '飞花令'),
                ),
                GoRoute(
                  path: 'chain',
                  name: 'chain',
                  builder: (context, state) =>
                      const _PlaceholderPage(title: '接龙'),
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
              builder: (context, state) =>
                  const _PlaceholderPage(title: '搜索'),
              routes: [
                GoRoute(
                  path: 'poem/:id',
                  name: 'searchPoemDetail',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => PoemDetailPage(
                    poemId: state.pathParameters['id']!,
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
              routes: [
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
