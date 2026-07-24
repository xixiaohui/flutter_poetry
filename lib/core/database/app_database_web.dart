/// Web 平台数据库桩 — 无 Isar 依赖，避免 dart2js 64-bit int 编译错误
///
/// Web 不使用本地 Isar 缓存，所有数据直读 API。
final class AppDatabase {
  AppDatabase._();
  static AppDatabase? _instance;

  static AppDatabase get instance {
    _instance ??= AppDatabase._();
    return _instance!;
  }

  Never get isar => throw UnsupportedError('Isar not available on web');

  Future<void> init() async {}
  Future<void> close() async {}
  Future<void> clearAll() async {}
}
