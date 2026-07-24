import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/api_models.dart';
import '../../../data/services/discover_service.dart';
part 'discover_providers.g.dart';

/// 发现页数据 — 先渲染空 UI，后台静默加载
@riverpod
class DiscoverPageDataNotifier extends _$DiscoverPageDataNotifier {
  @override
  DiscoverData? build() {
    // 异步触发加载，不阻塞 UI
    Future.microtask(() => load());
    return null;
  }

  Future<void> load() async {
    try {
      debugPrint('[Discover] 开始加载数据...');
      final data = await DiscoverService().getDiscover();
      debugPrint('[Discover] ✅ 加载成功 — 体裁${data.types.length}个, 朝代${data.dynasties.length}个, 诗词${data.recentPoems.length}首');
      state = data;
    } catch (e, st) {
      debugPrint('[Discover] ❌ 数据加载失败: $e');
      debugPrint('[Discover] 堆栈: $st');
      // 返回空数据让 UI 显示占位提示
      state = DiscoverData(recentPoems: [], dynasties: [], types: []);
    }
  }

  Future<void> refresh() async {
    state = null; // 触发 loading 骨架
    await load();
  }
}
