import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/api/gateway_api_client.dart';
import '../../../data/models/api_models.dart';
import '../../../data/models/isar_models.dart';
import '../../../data/models/poem.dart';
import '../../../data/repositories/poem_repository.dart';

part 'home_providers.g.dart';

/// 首页聚合数据 — 独立 provider，渐进渲染
@riverpod
Future<HomeData> homeData(HomeDataRef ref) async {
  return GatewayApiClient().getHome();
}

/// 节气推荐 — 独立 provider
@riverpod
Future<SolarTermData> solarTerm(SolarTermRef ref) async {
  return GatewayApiClient().getSolarTerm();
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
