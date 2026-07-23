import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  final auth = ref.watch(authRepositoryProvider);
  return auth.valueOrNull != null;
}
