import '../api/gateway_api_client.dart';
import '../models/api_models.dart';

final class DiscoverService {
  final GatewayApiClient _api = GatewayApiClient();
  Future<DiscoverData> getDiscover() => _api.getDiscover();
  Future<Map<String, List<CategoryItem>>> getCategories() => _api.getCategories();
  Future<RecommendData> getRecommend() => _api.getRecommend();
  Future<ApiPaginatedResponse<ApiPoem>> getPoems({int page = 1, String? dynasty, String? type}) =>
      _api.getPoems(page: page, dynasty: dynasty, type: type);
}
