import 'package:isar_community/isar.dart';

part 'isar_models.g.dart';

/// Isar 持久化的诗词摘要 (离线列表用)
@collection
class PoemCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String poemId;

  @Index(type: IndexType.value)
  late String title;

  @Index(type: IndexType.value)
  late String authorName;

  @Index(type: IndexType.value)
  late String dynastyName;

  late String content;
  String? category;
  String? contentSnippet; // 前 100 字用于列表预览
  DateTime? cachedAt;
}

/// Isar 持久化的完整诗词 (离线详情用)
@collection
class PoemDetailCache {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String poemId;

  late String fullJson; // 完整 JSON 字符串 (避免复杂的嵌套 schema)
  DateTime? cachedAt;
}

/// 收藏记录
@collection
class FavoriteRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String poemId;

  late String title;
  late String authorName;
  late String contentSnippet;
  late DateTime favoritedAt;
  bool isSynced = false; // 云同步状态
}

/// 阅读历史
@collection
class ReadingRecord {
  Id id = Isar.autoIncrement;

  late String poemId;
  late String title;
  late String authorName;
  late DateTime readAt;
  int readCount = 1;
}
