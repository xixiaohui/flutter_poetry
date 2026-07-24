import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/api_models.dart';
import '../../data/repositories/config_repository.dart';
import '../../data/repositories/stats_repository.dart';
import '../../shared/widgets/skeleton_loader.dart';
import 'providers/home_providers.dart';
import 'widgets/daily_poem_card.dart';
import 'widgets/home_sliver_header.dart';
import 'widgets/recent_reads_shelf.dart';
import 'widgets/recommendations_grid.dart';
import 'widgets/solar_term_banner.dart';

/// 首页 — 独立 Provider 渐进渲染
///
/// 每个区块独立加载，互不阻塞：
/// 1. 可折叠大标题（始终显示）
/// 2. Banner 轮播 → configRepository
/// 3. 数据摘要 + 每日诗词 → homeData
/// 4. 节气横幅 → solarTerm
/// 5. 最近阅读 → Isar 本地
/// 6. 热门排行 → readingStats
/// 7. 推荐列表 → HomeRecommendations
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
    if (maxScroll > 0 && currentScroll >= maxScroll * 0.8) {
      ref.read(homeRecommendationsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body = CustomScrollView(
      controller: _scrollController,
      slivers: [
        // 1. 标题 — 始终显示
        const HomeSliverHeader(),

        // 2. Banner 轮播 — 独立加载
        _bannerSection(),

        // 3. 数据摘要 + 每日诗词 — 共享 homeData
        _homeDataSection(),

        // 4. 节气横幅 — 独立加载
        _solarTermSection(),

        // 5. 最近阅读 — 独立加载
        const SliverToBoxAdapter(child: RecentReadsShelf()),
        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

        // 6. 热门排行 — 独立加载
        _hotRankingsSection(),

        // 7. 推荐标题
        SliverToBoxAdapter(
          child: Padding(
            padding: AppSpacing.pagePadding,
            child: Text('推荐', style: AppTypography.bodyMedium(context)),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

        // 下拉刷新
        if (kIsWeb)
          SliverToBoxAdapter(
            child: Center(
              child: TextButton.icon(
                onPressed: () => ref.read(homeRecommendationsProvider.notifier).refresh(),
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('刷新推荐'),
              ),
            ),
          )
        else
          CupertinoSliverRefreshControl(
            onRefresh: () => ref.read(homeRecommendationsProvider.notifier).refresh(),
          ),

        // 推荐列表
        const RecommendationsGrid(),

        // 底部安全区
        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xl2)),
      ],
    );

    if (kIsWeb) {
      body = Scrollbar(controller: _scrollController, child: body);
    }

    return Scaffold(body: body);
  }

  // ═══════════════════════════════════════════════════════════════
  // Banner Section
  // ═══════════════════════════════════════════════════════════════

  Widget _bannerSection() {
    final configAsync = ref.watch(appConfigProvider);
    return configAsync.when(
      loading: () => _sliverShimmer(160),
      error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
      data: (config) {
        if (config.banners.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return _bannerCarousel(config.banners);
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Home Data Section (stats row + daily poem)
  // ═══════════════════════════════════════════════════════════════

  Widget _homeDataSection() {
    final homeAsync = ref.watch(homeDataProvider);
    return homeAsync.when(
      loading: () => SliverToBoxAdapter(
        child: Column(children: [
          _shimmerStatsRow(),
          _boxShimmer(120),
        ]),
      ),
      error: (_, __) => SliverToBoxAdapter(
        child: _inlineError('首页数据加载失败', () => ref.invalidate(homeDataProvider)),
      ),
      data: (home) => SliverToBoxAdapter(
        child: Column(children: [
          _statsSummaryRow(home),
          DailyPoemCard(poem: home.featuredPoem),
          const SizedBox(height: AppSpacing.md),
        ]),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Solar Term Section
  // ═══════════════════════════════════════════════════════════════

  Widget _solarTermSection() {
    final solarAsync = ref.watch(solarTermProvider);
    return solarAsync.when(
      loading: () => SliverToBoxAdapter(child: SolarTermBanner()),
      error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
      data: (data) => SliverToBoxAdapter(
        child: Column(children: [
          SolarTermBanner(data: data),
          const SizedBox(height: AppSpacing.md),
        ]),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Hot Rankings Section
  // ═══════════════════════════════════════════════════════════════

  Widget _hotRankingsSection() {
    final statsAsync = ref.watch(readingStatsProvider);
    return statsAsync.when(
      loading: () => _sliverShimmer(140),
      error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
      data: (stats) {
        if (stats.topPoems.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return _hotRankings(stats.topPoems);
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Shared Helpers
  // ═══════════════════════════════════════════════════════════════

  /// 骨架屏 — 用于 slivers 列表
  Widget _sliverShimmer(double height) => SliverToBoxAdapter(
        child: Padding(
          padding: AppSpacing.pagePadding.copyWith(bottom: AppSpacing.md),
          child: SkeletonLoader(height: height, borderRadius: AppSpacing.cardRadius),
        ),
      );

  /// 骨架屏 — 用于 Column/Row 等 box 布局
  Widget _boxShimmer(double height) => Padding(
        padding: AppSpacing.pagePadding.copyWith(bottom: AppSpacing.md),
        child: SkeletonLoader(height: height, borderRadius: AppSpacing.cardRadius),
      );

  Widget _shimmerStatsRow() => Padding(
        padding: AppSpacing.pagePadding.copyWith(bottom: AppSpacing.md),
        child: Row(
          children: [
            Expanded(child: SkeletonLoader(height: 64, borderRadius: AppSpacing.cardRadius)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: SkeletonLoader(height: 64, borderRadius: AppSpacing.cardRadius)),
          ],
        ),
      );

  Widget _inlineError(String message, VoidCallback onRetry) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: AppSpacing.pagePadding.copyWith(bottom: AppSpacing.md),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(children: [
            Icon(Icons.error_outline, size: 18,
                color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(message,
                style: AppTypography.captionRegular(context).copyWith(
                    color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary))),
            GestureDetector(
              onTap: onRetry,
              child: Text('重试', style: AppTypography.captionRegular(context)
                  .copyWith(color: AppColors.accentPrimary)),
            ),
          ]),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Banner Carousel
  // ═══════════════════════════════════════════════════════════════

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
                    Positioned(
                      left: 12, right: 12, bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.45),
                          borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                        ),
                        child: Text(banner.title,
                          style: const TextStyle(color: Colors.white, fontSize: 13,
                              fontWeight: FontWeight.w500),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
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

  // ═══════════════════════════════════════════════════════════════
  // Stats Summary Row
  // ═══════════════════════════════════════════════════════════════

  Widget _statsSummaryRow(HomeData home) {
    return Padding(
      padding: AppSpacing.pagePadding.copyWith(bottom: AppSpacing.md),
      child: Row(
        children: [
          Expanded(child: _StatCard(label: '首诗词', value: _formatNumber(home.totalPoems))),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: _StatCard(label: '位作者', value: _formatNumber(home.totalAuthors))),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Hot Rankings
  // ═══════════════════════════════════════════════════════════════

  Widget _hotRankings(List<TopStatItem> topPoems) {
    final items = topPoems.take(5).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: AppSpacing.pagePadding,
          child: Text('热门排行', style: AppTypography.bodyMedium(context)),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageHorizontal),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: Container(
                  width: 140,
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        Container(
                          width: 20, height: 20, alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: index < 3 ? AppColors.accentPrimary : AppColors.inkTertiary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('${index + 1}',
                            style: const TextStyle(color: Colors.white, fontSize: 11,
                                fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(item.label,
                            style: AppTypography.captionRegular(context).copyWith(fontSize: 13),
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                      ]),
                      const Spacer(),
                      Text('${item.count} 次阅读',
                        style: AppTypography.captionRegular(context).copyWith(
                          fontSize: 11,
                          color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
      ]),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  // Formatting
  // ═══════════════════════════════════════════════════════════════

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
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm + 2),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurfaceSecondary : AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value,
          style: AppTypography.displayMedium(context).copyWith(
            fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.accentPrimary)),
        const SizedBox(height: 2),
        Text(label,
          style: AppTypography.captionRegular(context).copyWith(
            color: isDark ? AppColors.darkInkTertiary : AppColors.inkTertiary)),
      ]),
    );
  }
}
