import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/api_models.dart';
import '../../../data/services/discover_service.dart';

part 'browse_providers.g.dart';

/// 浏览页 state — 页码、更多标记、诗词列表
@riverpod
class BrowsePoems extends _$BrowsePoems {
  int _page = 0;
  bool _hasMore = true;

  @override
  Future<List<ApiPoem>> build({String? dynasty, String? type}) async {
    _page = 1;
    _hasMore = true;
    final response = await DiscoverService().getPoems(
      page: _page,
      dynasty: dynasty,
      type: type,
    );
    _hasMore = response.hasMore;
    return response.data;
  }

  /// 加载下一页，追加到列表末尾
  Future<void> loadMore() async {
    if (!_hasMore) return;
    final currentItems = state.valueOrNull ?? [];
    _page++;
    final response = await DiscoverService().getPoems(
      page: _page,
      dynasty: dynasty,
      type: type,
    );
    _hasMore = response.hasMore;
    state = AsyncData([...currentItems, ...response.data]);
  }
}
