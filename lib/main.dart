import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/database/app_database.dart';
import 'data/api/gateway_api_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDatabase.instance.init();
  await GatewayApiClient().init();

  runApp(
    const ProviderScope(
      child: PoetryApp(),
    ),
  );
}
