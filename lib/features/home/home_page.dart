import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/api_models.dart';
import '../../shared/widgets/skeleton_loader.dart';
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
/// 2. Banner 轮播（来自 real API config）
/// 3. 数据摘要行（总诗词数 / 总作者数）
/// 4. 每日诗词卡片（来自 real API home.featuredPoem）
/// 5. 节气横幅（来自 real API solar-term）
/// 6. 最近阅读横滑书架
/// 7. 热门排行（来自 real API stats）
/// 8. 推荐诗词无限列表（含下拉刷新和无限滚动）
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
    final homeDataAsync = ref.watch(homePageDataProvider);

    // Web 平台使用 Scrollbar 改善桌面端滚动体验
    Widget body = homeDataAsync.when(
        loading: () => CustomScrollView(
          controller: _scrollController,
          slivers: [
            const HomeSliverHeader(),
            _loadingBanner(),
            _loadingDailyPoem(),
            _loadingSolarTerm(),
            ..._commonTailSlivers(),
          ],
        ),
        error: (error, stack) => CustomScrollView(
          controller: _scrollController,
          slivers: [
            const HomeSliverHeader(),
            SliverFillRemaining(
              hasScrollBody: false,
              child: _fullPageError(error.toString()),
            ),
          ],
        ),
        data: (data) => CustomScrollView(
          controller: _scrollController,
          slivers: [
            const HomeSliverHeader(),

            // 2. Banner 轮播
            if (data.config.banners.isNotEmpty)
              _bannerCarousel(data.config.banners),

            // 3. 数据摘要行
            _statsSummaryRow(data.home),

            // 4. 每日诗词卡片
            SliverToBoxAdapter(
              child: DailyPoemCard(poem: data.home.featuredPoem),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.md),
            ),

            // 5. 节气横幅
            SliverToBoxAdapter(
              child: SolarTermBanner(data: data.solarTerm),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.md),
            ),

            // 6. 最近阅读横滑书架
            ..._commonTailSlivers(),

            // 7. 热门排行
            if (data.stats.topPoems.isNotEmpty)
              _hotRankings(data.stats.topPoems),
          ],
        ),
    );

    // Web: 添加 Scrollbar
    if (kIsWeb) {
      body = Scrollbar(controller: _scrollController, child: body);
    }

    return Scaffold(body: body);
  }

  // ── Banner Carousel ─────────────────────────────────────────────

  Widget _bannerCarousel(List<BannerItem> banners) {
    final sorted = [...banners]..sort((a, b) => a.sort.compareTo(b.sort));
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 160,
        child: PageView.builder(
          itemCount: sorted.length,
          padEnds: false,
          itemBuilder: (context, index) {
            final banner = sorted[index];
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? AppSpacing.pageHorizontal : AppSpacing.xs,
                right: AppSpacing.xs,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: banner.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkSurfaceSecondary
                            : AppColors.surfaceSecondary,
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.darkSurfaceSecondary
                            : AppColors.surfaceSecondary,
                        child: const Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                    // Title overlay
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.buttonRadius,
                          ),
                        ),
                        child: Text(
                          banner.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ── Stats Summary Row ───────────────────────────────────────────

  Widget _statsSummaryRow(HomeData home) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: Row(
          children: [
            Expanded(
              child: _StatCard(
                label: '首诗词',
                value: _formatNumber(home.totalPoems),
                isDark: isDark,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _StatCard(
                label: '位作者',
                value: _formatNumber(home.totalAuthors),
                isDark: isDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Hot Rankings ────────────────────────────────────────────────

  Widget _hotRankings(List<TopStatItem> topPoems) {
    final items = topPoems.take(5).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppSpacing.pagePadding,
            child: Text(
              '热门排行',
              style: AppTypography.bodyMedium(context),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageHorizontal,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkSurfaceSecondary
                            : AppColors.surfaceSecondary,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.buttonRadius),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              // Rank badge
                              Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: index < 3
                                      ? AppColors.accentPrimary
                                      : AppColors.inkTertiary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Text(
                                  item.label,
                                  style: AppTypography.captionRegular(context)
                                      .copyWith(fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '${item.count} 次阅读',
                            style: AppTypography.captionRegular(context)
                                .copyWith(
                              fontSize: 11,
                              color: isDark
                                  ? AppColors.darkInkTertiary
                                  : AppColors.inkTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Common Tail Slivers ─────────────────────────────────────────

  /// 独立于 API 数据的公共尾部区域（最近阅读 + 推荐列表）
  List<Widget> _commonTailSlivers() {
    return [
      // 最近阅读横滑书架
      const SliverToBoxAdapter(child: RecentReadsShelf()),
      const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

      // 推荐标题
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

      // Web: 按钮刷新 / 移动端: Cupertino 下拉刷新
      if (kIsWeb)
        SliverToBoxAdapter(
          child: Center(
            child: TextButton.icon(
              onPressed: () =>
                  ref.read(homeRecommendationsProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('刷新推荐'),
            ),
          ),
        )
      else
        CupertinoSliverRefreshControl(
          onRefresh: () =>
              ref.read(homeRecommendationsProvider.notifier).refresh(),
        ),

      // 推荐列表（无限滚动）
      const RecommendationsGrid(),

      // 底部安全区
      const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl2)),
    ];
  }

  // ── Loading / Error States ──────────────────────────────────────

  Widget _loadingBanner() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: AppSpacing.pagePadding,
        child: const SkeletonLoader(
          height: 160,
          borderRadius: 20,
        ),
      ),
    );
  }

  Widget _loadingDailyPoem() {
    return const SliverToBoxAdapter(child: DailyPoemCard());
  }

  Widget _loadingSolarTerm() {
    return const SliverToBoxAdapter(
      child: SolarTermBanner(),
    );
  }

  Widget _fullPageError(String error) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 56,
              color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '网络连接失败',
              style: AppTypography.bodyMedium(context),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '请检查网络后重试',
              style: AppTypography.captionRegular(context).copyWith(
                color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: () => ref.invalidate(homePageDataProvider),
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('重试'),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────

  /// Format large numbers with commas (e.g., 385000 → "385,000").
  String _formatNumber(int n) {
    if (n < 1000) return n.toString();
    final str = n.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write(',');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}

/// 统计摘要卡片
class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _StatCard({
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTypography.displayMedium(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.accentPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.captionRegular(context).copyWith(
              color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
