import '../api/gateway_api_client.dart';
import '../models/api_models.dart';

final class ConfigService {
  final GatewayApiClient _api = GatewayApiClient();
  AppConfig? _cached;
  DateTime? _cacheTime;
  static const _cacheDuration = Duration(hours: 1);

  Future<AppConfig> getConfig() async {
    if (_cached != null && _cacheTime != null && DateTime.now().difference(_cacheTime!) < _cacheDuration) {
      return _cached!;
    }
    _cached = await _api.getConfig();
    _cacheTime = DateTime.now();
    return _cached!;
  }
}
