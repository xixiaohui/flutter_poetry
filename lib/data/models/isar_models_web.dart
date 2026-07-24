/// Web 平台桩 — 无 Isar 依赖，避免 dart2js 64-bit int 编译错误
///
/// 提供与 isar_models_real.dart 相同的类接口，但不包含 Isar 注解和生成代码。
/// Web 平台不使用本地缓存，所有数据直读 API。

typedef Id = int;

class PoemCache {
  int id = 0;
  late String poemId;
  late String title;
  late String authorName;
  late String dynastyName;
  late String content;
  String? category;
  String? contentSnippet;
  DateTime? cachedAt;
}

class PoemDetailCache {
  int id = 0;
  late String poemId;
  late String fullJson;
  DateTime? cachedAt;
}

class FavoriteRecord {
  int id = 0;
  late String poemId;
  late String title;
  late String authorName;
  late String contentSnippet;
  late DateTime favoritedAt;
  bool isSynced = false;
}

class ReadingRecord {
  int id = 0;
  late String poemId;
  late String title;
  late String authorName;
  late DateTime readAt;
  late int readCount;
}
