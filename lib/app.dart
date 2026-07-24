import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/network/auth_event_bus.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/theme_provider.dart';

class PoetryApp extends ConsumerStatefulWidget {
  const PoetryApp({super.key});

  @override
  ConsumerState<PoetryApp> createState() => _PoetryAppState();
}

class _PoetryAppState extends ConsumerState<PoetryApp> {
  StreamSubscription<void>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = AuthEventBus.onUnauthorized.listen((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登录已过期，请重新登录')),
      );
      context.push('/login');
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeNotifierProvider);

    return MaterialApp.router(
      title: '诗词',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
