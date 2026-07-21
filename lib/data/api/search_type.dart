/// 搜索类型
enum SearchType {
  all, // 全文搜索
  title, // 标题搜索
  content, // 内容搜索
  author; // 作者搜索

  String get apiValue {
    switch (this) {
      case SearchType.all:
        return 'all';
      case SearchType.title:
        return 'title';
      case SearchType.content:
        return 'content';
      case SearchType.author:
        return 'author';
    }
  }
}
