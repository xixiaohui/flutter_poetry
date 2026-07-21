import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

/// 毛玻璃效果容器
enum GlassIntensity { light, medium, heavy }

class GlassContainer extends StatelessWidget {
  final Widget child;
  final GlassIntensity intensity;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const GlassContainer({
    super.key,
    required this.child,
    this.intensity = GlassIntensity.medium,
    this.borderRadius = 20,
    this.padding,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    double sigma;
    double opacity;
    switch (intensity) {
      case GlassIntensity.light:
        sigma = 10;
        opacity = 0.6;
        break;
      case GlassIntensity.medium:
        sigma = 20;
        opacity = 0.4;
        break;
      case GlassIntensity.heavy:
        sigma = 30;
        opacity = 0.2;
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? AppSpacing.cardPadding,
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF1C1C1A).withValues(alpha: opacity)
                : Colors.white.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.15),
              width: 0.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
