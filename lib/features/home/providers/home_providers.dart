import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/utils/solar_term_calculator.dart';
import '../../../data/models/poem.dart';
import '../../../data/models/isar_models.dart';
import '../../../data/repositories/poem_repository.dart';

part 'home_providers.g.dart';

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

/// 每日一首
@riverpod
Future<Poem> dailyPoem(DailyPoemRef ref) async {
  return ref.read(poemRepositoryProvider).getRandomPoem();
}

/// 当前节气
@riverpod
({String name, String description}) currentSolarTerm(CurrentSolarTermRef ref) {
  return SolarTermCalculator.current();
}

/// 最近阅读
@riverpod
Future<List<ReadingRecord>> recentReads(RecentReadsRef ref) async {
  return ref.read(poemRepositoryProvider).getRecentReads(limit: 10);
}
