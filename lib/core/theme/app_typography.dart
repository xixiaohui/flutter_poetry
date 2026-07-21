import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// 国风字体层级 — iOS First (PingFang SC + Noto Serif SC)
abstract final class AppTypography {
  // ── Display (诗词展示) ──
  static TextStyle displayLarge(BuildContext context) =>
      GoogleFonts.notoSerifSc(
        fontSize: 28,
        height: 34 / 28,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle displayMedium(BuildContext context) =>
      GoogleFonts.notoSerifSc(
        fontSize: 20,
        height: 28 / 20,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onSurface,
      );

  // ── Body (正文阅读) ──
  static TextStyle bodyLarge(BuildContext context) =>
      GoogleFonts.notoSansSc(
        fontSize: 17,
        height: 24 / 17,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle bodyMedium(BuildContext context) =>
      GoogleFonts.notoSansSc(
        fontSize: 15,
        height: 22 / 15,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).colorScheme.onSurface,
      );

  // ── Caption (辅助信息) ──
  static TextStyle captionRegular(BuildContext context) =>
      GoogleFonts.notoSansSc(
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      );

  static TextStyle captionMono(BuildContext context) =>
      const TextStyle(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'SF Mono',
      );
}
