import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_models.dart';
import '../services/auth_service.dart';

part 'auth_repository.g.dart';

@riverpod
class AuthRepository extends _$AuthRepository {
  final AuthService _service = AuthService();

  @override
  Future<UserData?> build() async {
    await _service.init();
    if (!_service.isLoggedIn) return null;
    try {
      return await _service.getProfile();
    } catch (_) {
      return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = AsyncData((await _service.login(email: email, password: password)).user);
  }

  Future<void> register({
    required String email,
    required String password,
    String? name,
  }) async {
    state = const AsyncLoading();
    state = AsyncData((await _service.register(email: email, password: password, name: name)).user);
  }

  Future<void> logout() async {
    await _service.logout();
    state = const AsyncData(null);
  }

  Future<void> updateProfile({String? name, String? avatar}) async {
    final updated = await _service.updateProfile(name: name, avatar: avatar);
    state = AsyncData(updated);
  }
}
