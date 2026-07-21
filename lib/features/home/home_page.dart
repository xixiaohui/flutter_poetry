import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'providers/home_providers.dart';
import 'widgets/daily_poem_card.dart';
import 'widgets/home_sliver_header.dart';
import 'widgets/recent_reads_shelf.dart';
import 'widgets/recommendations_grid.dart';
import 'widgets/solar_term_banner.dart';

/// 首页 — CustomScrollView 编排所有内容区块
///
/// Sliver 顺序：
/// 1. 可折叠大标题
/// 2. 每日诗词卡片
/// 3. 节气横幅
/// 4. 最近阅读横滑书架
/// 5. 推荐诗词无限列表（含下拉刷新和无限滚动）
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    // 滚动到 80% 时加载更多推荐
    if (maxScroll > 0 && currentScroll >= maxScroll * 0.8) {
      ref.read(homeRecommendationsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 1. 可折叠大标题
          const HomeSliverHeader(),

          // 2. 每日诗词卡片
          const SliverToBoxAdapter(child: DailyPoemCard()),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

          // 3. 节气横幅
          const SliverToBoxAdapter(child: SolarTermBanner()),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

          // 4. 最近阅读横滑书架
          const SliverToBoxAdapter(child: RecentReadsShelf()),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

          // 5. 推荐标题
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.pagePadding,
              child: Text(
                '推荐',
                style: AppTypography.bodyMedium(context),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          // 下拉刷新控件
          CupertinoSliverRefreshControl(
            onRefresh: () =>
                ref.read(homeRecommendationsProvider.notifier).refresh(),
          ),

          // 6. 推荐列表（无限滚动）
          const RecommendationsGrid(),

          // 底部安全区
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl2)),
        ],
      ),
    );
  }
}
