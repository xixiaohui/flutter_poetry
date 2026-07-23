import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_models.dart';
import '../services/discover_service.dart';

part 'discover_repository.g.dart';

@riverpod
Future<DiscoverData> discoverData(DiscoverDataRef ref) async {
  return DiscoverService().getDiscover();
}

@riverpod
Future<RecommendData> recommendData(RecommendDataRef ref) async {
  return DiscoverService().getRecommend();
}
