import '../api/gateway_api_client.dart';
import '../models/api_models.dart';

final class StatsService {
  final GatewayApiClient _api = GatewayApiClient();
  Future<ReadingStatsData> getReadingStats() => _api.getReadingStats();
}
