import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../data/models/isar_models.dart';

/// Isar 数据库管理
final class AppDatabase {
  AppDatabase._();
  static AppDatabase? _instance;
  Isar? _isar;

  static AppDatabase get instance {
    _instance ??= AppDatabase._();
    return _instance!;
  }

  Isar get isar {
    if (_isar == null) {
      throw StateError('AppDatabase not initialized. Call init() first.');
    }
    return _isar!;
  }

  Future<void> init() async {
    if (_isar != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        PoemCacheSchema,
        PoemDetailCacheSchema,
        FavoriteRecordSchema,
        ReadingRecordSchema,
      ],
      directory: dir.path,
    );
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  /// 清空所有数据 (离线数据重置用)
  Future<void> clearAll() async {
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }
}
