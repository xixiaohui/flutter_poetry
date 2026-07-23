import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/api_models.dart';
import '../../../data/repositories/discover_repository.dart';
part 'discover_providers.g.dart';

@riverpod
Future<DiscoverData> discoverPageData(DiscoverPageDataRef ref) async {
  return ref.watch(discoverDataProvider.future);
}
