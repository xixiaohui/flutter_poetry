import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/api_models.dart';
import '../../../data/services/discover_service.dart';
part 'discover_providers.g.dart';

/// 发现页数据
@riverpod
Future<DiscoverData> discoverPageData(DiscoverPageDataRef ref) async {
  return DiscoverService().getDiscover();
}
