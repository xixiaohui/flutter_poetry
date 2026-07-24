import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/api/gateway_api_client.dart';
import '../../../data/models/api_models.dart';
import '../../../data/models/isar_models.dart';
import '../../../data/models/poem.dart';
import '../../../data/repositories/poem_repository.dart';

part 'home_providers.g.dart';

/// Aggregated home page data — fetches 4 APIs in parallel.
@riverpod
Future<({
  HomeData home,
  SolarTermData solarTerm,
  AppConfig config,
  ReadingStatsData stats,
})> homePageData(HomePageDataRef ref) async {
  final api = GatewayApiClient();
  final results = await Future.wait([
    api.getHome(),
    api.getSolarTerm(),
    api.getConfig(),
    api.getReadingStats(),
  ]);
  return (
    home: results[0] as HomeData,
    solarTerm: results[1] as SolarTermData,
    config: results[2] as AppConfig,
    stats: results[3] as ReadingStatsData,
  );
}

/// 首页推荐诗词 — 分页异步加载
@riverpod
class HomeRecommendations extends _$HomeRecommendations {
  int _currentPage = 1;
  bool _hasMore = true;
  final List<Poem> _items = [];

  @override
  Future<List<Poem>> build() async {
    final repo = ref.read(poemRepositoryProvider);
    final result = await repo.getPoems(page: 1);
    _items.clear();
    _items.addAll(result.data);
    _hasMore = result.hasMore;
    _currentPage = 1;
    return _items;
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    _currentPage++;
    final repo = ref.read(poemRepositoryProvider);
    final result = await repo.getPoems(page: _currentPage);
    _items.addAll(result.data);
    _hasMore = result.hasMore;
    state = AsyncData([..._items]);
  }

  Future<void> refresh() async {
    _currentPage = 1;
    final repo = ref.read(poemRepositoryProvider);
    final result = await repo.getPoems(page: 1);
    _items.clear();
    _items.addAll(result.data);
    _hasMore = result.hasMore;
    state = AsyncData([..._items]);
  }
}

/// 最近阅读
@riverpod
Future<List<ReadingRecord>> recentReads(RecentReadsRef ref) async {
  return ref.read(poemRepositoryProvider).getRecentReads(limit: 10);
}
