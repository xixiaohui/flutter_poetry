import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/router/routes.dart';
import '../../data/api/gateway_api_client.dart';
import '../../data/models/api_models.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  DailyQuote? _quote;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();

    _loadQuote();

    // 3 秒后跳转首页
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRoutes.home);
      }
    });
  }

  Future<void> _loadQuote() async {
    try {
      final quote = await GatewayApiClient().getQuote();
      if (mounted) {
        setState(() {
          _quote = quote;
        });
      }
    } catch (_) {
      // Silently ignore — splash should proceed even if quote fails.
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfacePrimary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo / 印章
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.accentPrimary,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.cardRadius),
                ),
                child: const Center(
                  child: Text(
                    '诗',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '诗词',
                style: AppTypography.displayLarge(context),
              ),
              if (_quote != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  _quote!.content,
                  style: AppTypography.displayMedium(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '—— ${_quote!.author}《${_quote!.source}》',
                  style: AppTypography.captionRegular(context),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              Text(
                '沉浸式古诗词阅读',
                style: AppTypography.captionRegular(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
