import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDatabase.instance.init();
  // TODO: await AiRepository.configure(apiKey: await SecureStorage.getDeepSeekKey());

  runApp(
    const ProviderScope(
      child: PoetryApp(),
    ),
  );
}
