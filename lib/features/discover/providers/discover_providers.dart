import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/api_models.dart';
import '../../../data/services/discover_service.dart';
part 'discover_providers.g.dart';

/// 发现页数据 — 直接调用 Service，不通过中间 provider
@riverpod
Future<DiscoverData> discoverPageData(DiscoverPageDataRef ref) async {
  // keepAlive: 切换 tab 不重新加载
  ref.keepAlive();
  return DiscoverService().getDiscover();
}
