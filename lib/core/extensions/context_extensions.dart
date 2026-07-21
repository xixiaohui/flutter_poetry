import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

extension BuildContextX on BuildContext {
  /// 主题颜色方案
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// 文本主题
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// 是否为暗色模式
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// 屏幕宽度
  double get screenWidth => MediaQuery.of(this).size.width;

  /// 屏幕高度
  double get screenHeight => MediaQuery.of(this).size.height;

  /// 是否为平板/大屏 (宽度 > 768)
  bool get isTablet => screenWidth > 768;

  /// 安全区域内边距
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;

  /// 是否可弹出键盘
  void dismissKeyboard() => FocusScope.of(this).unfocus();

  /// 显示 SnackBar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppColors.error : null,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          margin: const EdgeInsets.all(AppSpacing.md),
        ),
      );
  }
}
