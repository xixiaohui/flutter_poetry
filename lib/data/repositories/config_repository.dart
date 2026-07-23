import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_models.dart';
import '../services/config_service.dart';

part 'config_repository.g.dart';

@riverpod
Future<AppConfig> appConfig(AppConfigRef ref) async {
  return ConfigService().getConfig();
}
