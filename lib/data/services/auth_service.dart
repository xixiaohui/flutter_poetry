import '../api/gateway_api_client.dart';
import '../models/api_models.dart';

final class AuthService {
  final GatewayApiClient _api = GatewayApiClient();

  Future<void> init() => _api.init();

  Future<LoginData> login({
    required String email,
    required String password,
  }) =>
      _api.login(email: email, password: password);

  Future<LoginData> register({
    required String email,
    required String password,
    String? name,
  }) =>
      _api.register(email: email, password: password, name: name);

  Future<UserData> getProfile() => _api.getProfile();

  Future<UserData> updateProfile({String? name, String? avatar}) =>
      _api.updateProfile(name: name, avatar: avatar);

  Future<void> logout() => _api.clearToken();

  bool get isLoggedIn => _api.isLoggedIn;
}
