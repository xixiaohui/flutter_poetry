import 'package:flutter/material.dart';

/// 16pt 栅格间距系统
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;  // 基准
  static const double lg = 24;
  static const double xl = 32;
  static const double xl2 = 48;
  static const double xl3 = 64;

  /// 卡片圆角
  static const double cardRadius = 20;

  /// 胶囊按钮圆角
  static const double buttonRadius = 12;

  /// 中文阅读舒适最大宽度
  static const double maxReadingWidth = 680;

  /// 水平页面边距
  static const double pageHorizontal = 16;

  /// 边到边的 EdgeInsets
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: pageHorizontal,
  );

  /// 卡片内边距
  static const EdgeInsets cardPadding = EdgeInsets.all(md);

  /// 列表项间距
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
}
