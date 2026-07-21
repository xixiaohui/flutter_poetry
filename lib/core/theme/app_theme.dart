import 'package:flutter/material.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'app_colors.dart';

/// 主题配置 — 使用 FlexColorScheme 实现 Apple + 国风混合主题
abstract final class AppTheme {
  static ThemeData light() {
    final scheme = SeedColorScheme.fromSeeds(
      primaryKey: AppColors.accentPrimary,
      secondaryKey: AppColors.celadon,
      tertiaryKey: AppColors.accentGold,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.surfacePrimary,
      cardTheme: CardThemeData(
        color: AppColors.surfaceSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: AppColors.surfacePrimary,
        indicatorColor: AppColors.accentPrimary.withValues(alpha: 0.12),
        surfaceTintColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(color: AppColors.inkPrimary),
      dividerTheme: const DividerThemeData(
        color: AppColors.surfaceTertiary,
        thickness: 0.5,
      ),
      splashColor: Colors.transparent,
      highlightColor: AppColors.inkPrimary.withValues(alpha: 0.06),
    );
  }

  static ThemeData dark() {
    final scheme = SeedColorScheme.fromSeeds(
      primaryKey: AppColors.accentPrimary,
      secondaryKey: AppColors.celadon,
      tertiaryKey: AppColors.accentGold,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.darkSurfacePrimary,
      cardTheme: CardThemeData(
        color: AppColors.darkSurfaceSecondary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: AppColors.darkSurfacePrimary,
        indicatorColor: AppColors.accentPrimary.withValues(alpha: 0.2),
        surfaceTintColor: Colors.transparent,
      ),
      iconTheme: const IconThemeData(color: AppColors.darkInkPrimary),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkSurfaceTertiary,
        thickness: 0.5,
      ),
      splashColor: Colors.transparent,
      highlightColor: AppColors.darkInkPrimary.withValues(alpha: 0.06),
    );
  }
}
