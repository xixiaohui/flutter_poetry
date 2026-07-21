/// 应用级常量
abstract final class AppConstants {
  /// 应用名称
  static const String appName = '诗词';

  /// 首次启动标识 key
  static const String isFirstLaunchKey = 'is_first_launch';

  /// 离线数据版本 key
  static const String offlineDataVersionKey = 'offline_data_version';

  /// 阅读区最大宽度
  static const double maxReadingWidth = 680;

  /// 海报尺寸 (1080x1920)
  static const double posterWidth = 1080;
  static const double posterHeight = 1920;

  /// 收藏夹最大数量 (本地)
  static const int maxLocalFavorites = 1000;
}
