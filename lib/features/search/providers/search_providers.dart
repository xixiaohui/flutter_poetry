import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/api/gateway_api_client.dart';
import '../../../data/models/api_models.dart';

part 'search_providers.g.dart';

/// 搜索页 state — 页码、更多标记、搜索结果列表
@riverpod
class SearchResults extends _$SearchResults {
  int _page = 0;
  bool _hasMore = true;

  @override
  Future<List<ApiPoem>> build(String query, {String type = 'all'}) async {
    _page = 1;
    _hasMore = true;
    if (query.isEmpty) return [];
    final response = await GatewayApiClient().search(
      q: query,
      type: type == 'all' ? null : type,
      page: _page,
    );
    _hasMore = response.hasMore;
    return response.data;
  }

  /// 加载下一页，追加到列表末尾
  Future<void> loadMore() async {
    if (!_hasMore) return;
    final currentItems = state.valueOrNull ?? [];
    _page++;
    final response = await GatewayApiClient().search(
      q: query,
      type: type == 'all' ? null : type,
      page: _page,
    );
    _hasMore = response.hasMore;
    state = AsyncData([...currentItems, ...response.data]);
  }
}
