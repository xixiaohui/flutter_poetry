import 'package:flutter/material.dart';

/// 国风色彩系统 — Apple 框架 + 中国美学色彩注入
abstract final class AppColors {
  // ── Ink (文本层级) ──
  static const Color inkPrimary = Color(0xFF1A1A1A);
  static const Color inkSecondary = Color(0xFF666666);
  static const Color inkTertiary = Color(0xFF999999);

  // ── Xuan Paper / Surface (背景层级) ──
  static const Color surfacePrimary = Color(0xFFFAFAF5);
  static const Color surfaceSecondary = Color(0xFFF5F0E8);
  static const Color surfaceTertiary = Color(0xFFEDE8DC);

  // ── Vermillion / Accent (强调/动作) ──
  static const Color accentPrimary = Color(0xFFC9403A);
  static const Color accentSecondary = Color(0xFF8B4513);
  static const Color accentGold = Color(0xFFB8860B);

  // ── Nature (辅助色) ──
  static const Color bamboo = Color(0xFF6B8E23);
  static const Color celadon = Color(0xFF5F9EA0);
  static const Color lavender = Color(0xFF9B8EC4);

  // ── Dark mode surfaces ──
  static const Color darkSurfacePrimary = Color(0xFF1C1C1A);
  static const Color darkSurfaceSecondary = Color(0xFF2A2825);
  static const Color darkSurfaceTertiary = Color(0xFF363430);

  // ── Dark mode ink ──
  static const Color darkInkPrimary = Color(0xFFF0EDE5);
  static const Color darkInkSecondary = Color(0xFFA09D95);
  static const Color darkInkTertiary = Color(0xFF6B6862);

  // ── Glassmorphism ──
  static Color glassLight = Colors.white.withValues(alpha: 0.6);
  static Color glassMedium = Colors.white.withValues(alpha: 0.4);
  static Color glassHeavy = Colors.white.withValues(alpha: 0.2);
  static Color glassDark = const Color(0xFF1C1C1A).withValues(alpha: 0.6);

  // ── Semantic aliases ──
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFE53935);
}
