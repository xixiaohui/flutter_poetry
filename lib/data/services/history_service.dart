import '../api/gateway_api_client.dart';
import '../models/api_models.dart';

final class HistoryService {
  final GatewayApiClient _api = GatewayApiClient();
  Future<({List<HistoryItem> records, int total})> getHistory() => _api.getHistory();
  Future<void> recordReading({required int poemId, required String poemTitle, String? poemAuthor, String? poemDynasty}) =>
      _api.recordReading(poemId: poemId, poemTitle: poemTitle, poemAuthor: poemAuthor, poemDynasty: poemDynasty);
}
