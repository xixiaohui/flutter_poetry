// API response data models — direct mapping of api.md JSON format.
// Plain Dart classes with manual fromJson (NO Freezed, NO code generation).

class CategoryItem {
  final int id;
  final String name;

  const CategoryItem({required this.id, required this.name});

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        id: json['id'] as int,
        name: json['name'] as String,
      );
}

class ApiPoem {
  final int id;
  final String title;
  final String content;
  final String? author;
  final String? dynasty;
  final String? type;

  const ApiPoem({
    required this.id,
    required this.title,
    required this.content,
    this.author,
    this.dynasty,
    this.type,
  });

  factory ApiPoem.fromJson(Map<String, dynamic> json) => ApiPoem(
        id: json['id'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        author: json['author'] as String?,
        dynasty: json['dynasty'] as String?,
        type: json['type'] as String?,
      );
}

class HomeData {
  final ApiPoem featuredPoem;
  final HomeAuthor featuredAuthor;
  final int totalPoems;
  final int totalAuthors;

  const HomeData({
    required this.featuredPoem,
    required this.featuredAuthor,
    required this.totalPoems,
    required this.totalAuthors,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        featuredPoem:
            ApiPoem.fromJson(json['featuredPoem'] as Map<String, dynamic>),
        featuredAuthor:
            HomeAuthor.fromJson(json['featuredAuthor'] as Map<String, dynamic>),
        totalPoems: json['totalPoems'] as int,
        totalAuthors: json['totalAuthors'] as int,
      );
}

class HomeAuthor {
  final int id;
  final String name;
  final String dynasty;
  final String? description;
  final int poemCount;

  const HomeAuthor({
    required this.id,
    required this.name,
    required this.dynasty,
    this.description,
    required this.poemCount,
  });

  factory HomeAuthor.fromJson(Map<String, dynamic> json) => HomeAuthor(
        id: json['id'] as int,
        name: json['name'] as String,
        dynasty: json['dynasty'] as String,
        description: json['description'] as String?,
        poemCount: json['poemCount'] as int,
      );
}

class DiscoverData {
  final List<ApiPoem> recentPoems;
  final List<CategoryItem> dynasties;
  final List<CategoryItem> types;

  const DiscoverData({
    required this.recentPoems,
    required this.dynasties,
    required this.types,
  });

  factory DiscoverData.fromJson(Map<String, dynamic> json) => DiscoverData(
        recentPoems: (json['recentPoems'] as List)
            .map((e) => ApiPoem.fromJson(e as Map<String, dynamic>))
            .toList(),
        dynasties: (json['dynasties'] as List)
            .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        types: (json['types'] as List)
            .map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class DailyQuote {
  final String content;
  final String author;
  final String source;
  final String date;

  const DailyQuote({
    required this.content,
    required this.author,
    required this.source,
    required this.date,
  });

  factory DailyQuote.fromJson(Map<String, dynamic> json) => DailyQuote(
        content: json['content'] as String,
        author: json['author'] as String,
        source: json['source'] as String,
        date: json['date'] as String,
      );
}

class SolarTermData {
  final String termName;
  final String termDescription;
  final ApiPoem poem;
  final String reason;

  const SolarTermData({
    required this.termName,
    required this.termDescription,
    required this.poem,
    required this.reason,
  });

  factory SolarTermData.fromJson(Map<String, dynamic> json) => SolarTermData(
        termName: json['termName'] as String,
        termDescription: json['termDescription'] as String,
        poem: ApiPoem.fromJson(json['poem'] as Map<String, dynamic>),
        reason: json['reason'] as String,
      );
}

class AppConfig {
  final String version;
  final List<BannerItem> banners;
  final FeatureFlags features;

  const AppConfig({
    required this.version,
    required this.banners,
    required this.features,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) => AppConfig(
        version: json['version'] as String,
        banners: (json['banners'] as List)
            .map((e) => BannerItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        features:
            FeatureFlags.fromJson(json['features'] as Map<String, dynamic>),
      );
}

class BannerItem {
  final String id;
  final String imageUrl;
  final String title;
  final String? link;
  final int sort;

  const BannerItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.link,
    required this.sort,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) => BannerItem(
        id: json['id'] as String,
        imageUrl: json['imageUrl'] as String,
        title: json['title'] as String,
        link: json['link'] as String?,
        sort: json['sort'] as int,
      );
}

class FeatureFlags {
  final bool aiAnalysis;
  final bool aiAsk;
  final bool aiTranslate;
  final bool favorites;
  final bool readingHistory;
  final bool recommendations;
  final bool solarTerm;
  final bool dailyQuote;

  const FeatureFlags({
    this.aiAnalysis = true,
    this.aiAsk = true,
    this.aiTranslate = true,
    this.favorites = true,
    this.readingHistory = true,
    this.recommendations = true,
    this.solarTerm = true,
    this.dailyQuote = true,
  });

  factory FeatureFlags.fromJson(Map<String, dynamic> json) => FeatureFlags(
        aiAnalysis: json['aiAnalysis'] as bool? ?? true,
        aiAsk: json['aiAsk'] as bool? ?? true,
        aiTranslate: json['aiTranslate'] as bool? ?? true,
        favorites: json['favorites'] as bool? ?? true,
        readingHistory: json['readingHistory'] as bool? ?? true,
        recommendations: json['recommendations'] as bool? ?? true,
        solarTerm: json['solarTerm'] as bool? ?? true,
        dailyQuote: json['dailyQuote'] as bool? ?? true,
      );
}

class RecommendData {
  final List<ApiPoem> poems;
  final String reason;

  const RecommendData({
    required this.poems,
    required this.reason,
  });

  factory RecommendData.fromJson(Map<String, dynamic> json) => RecommendData(
        poems: (json['poems'] as List)
            .map((e) => ApiPoem.fromJson(e as Map<String, dynamic>))
            .toList(),
        reason: json['reason'] as String,
      );
}

class AIAnalysisData {
  final String background;
  final String appreciation;
  final List<String> keywords;
  final List<String> emotions;

  const AIAnalysisData({
    required this.background,
    required this.appreciation,
    required this.keywords,
    required this.emotions,
  });

  factory AIAnalysisData.fromJson(Map<String, dynamic> json) =>
      AIAnalysisData(
        background: json['background'] as String,
        appreciation: json['appreciation'] as String,
        keywords: List<String>.from(json['keywords'] as List),
        emotions: List<String>.from(json['emotions'] as List),
      );
}

class AIAnswer {
  final String answer;

  const AIAnswer({required this.answer});

  factory AIAnswer.fromJson(Map<String, dynamic> json) => AIAnswer(
        answer: json['answer'] as String,
      );
}

class AITranslation {
  final String translation;
  final List<String> notes;

  const AITranslation({
    required this.translation,
    this.notes = const [],
  });

  factory AITranslation.fromJson(Map<String, dynamic> json) => AITranslation(
        translation: json['translation'] as String,
        notes: List<String>.from((json['notes'] as List?) ?? []),
      );
}

class ReadingStatsData {
  final int totalReads;
  final int totalPoems;
  final List<TopStatItem> topPoems;
  final List<TopStatItem> topAuthors;
  final List<DailyCount> readsByDay;

  const ReadingStatsData({
    required this.totalReads,
    required this.totalPoems,
    required this.topPoems,
    required this.topAuthors,
    required this.readsByDay,
  });

  factory ReadingStatsData.fromJson(Map<String, dynamic> json) =>
      ReadingStatsData(
        totalReads: json['totalReads'] as int,
        totalPoems: json['totalPoems'] as int,
        topPoems: (json['topPoems'] as List)
            .map((e) => TopStatItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        topAuthors: (json['topAuthors'] as List)
            .map((e) => TopStatItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        readsByDay: (json['readsByDay'] as List)
            .map((e) => DailyCount.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class TopStatItem {
  final String label;
  final int count;

  const TopStatItem({required this.label, required this.count});

  factory TopStatItem.fromJson(Map<String, dynamic> json) => TopStatItem(
        label: (json['poemTitle'] ?? json['author'] ?? '') as String,
        count: json['count'] as int,
      );
}

class DailyCount {
  final String date;
  final int count;

  const DailyCount({required this.date, required this.count});

  factory DailyCount.fromJson(Map<String, dynamic> json) => DailyCount(
        date: json['date'] as String,
        count: json['count'] as int,
      );
}

class FavoriteItem {
  final String id;
  final int poemId;
  final String poemTitle;
  final String? poemAuthor;
  final String? poemDynasty;
  final String createdAt;
  final String? updatedAt;

  const FavoriteItem({
    required this.id,
    required this.poemId,
    required this.poemTitle,
    this.poemAuthor,
    this.poemDynasty,
    required this.createdAt,
    this.updatedAt,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) => FavoriteItem(
        id: json['id'] as String,
        poemId: json['poemId'] is int
            ? json['poemId'] as int
            : int.parse(json['poemId'] as String),
        poemTitle: json['poemTitle'] as String,
        poemAuthor: json['poemAuthor'] as String?,
        poemDynasty: json['poemDynasty'] as String?,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String?,
      );
}

class HistoryItem {
  final String id;
  final int poemId;
  final String poemTitle;
  final String? poemAuthor;
  final String? poemDynasty;
  final String readAt;

  const HistoryItem({
    required this.id,
    required this.poemId,
    required this.poemTitle,
    this.poemAuthor,
    this.poemDynasty,
    required this.readAt,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) => HistoryItem(
        id: json['id'] as String,
        poemId: json['poemId'] is int
            ? json['poemId'] as int
            : int.parse(json['poemId'] as String),
        poemTitle: json['poemTitle'] as String,
        poemAuthor: json['poemAuthor'] as String?,
        poemDynasty: json['poemDynasty'] as String?,
        readAt: json['readAt'] as String,
      );
}

class LoginData {
  final String token;
  final UserData user;

  const LoginData({required this.token, required this.user});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json['token'] as String,
        user: UserData.fromJson(json['user'] as Map<String, dynamic>),
      );
}

class UserData {
  final String id;
  final String email;
  final String? name;
  final String? avatar;
  final String? createdAt;

  const UserData({
    required this.id,
    required this.email,
    this.name,
    this.avatar,
    this.createdAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'] as String,
        email: json['email'] as String,
        name: json['name'] as String?,
        avatar: json['avatar'] as String?,
        createdAt: json['createdAt'] as String?,
      );
}

class ApiPaginatedResponse<T> {
  final List<T> data;
  final int total;
  final int page;
  final int pageSize;

  bool get hasMore => page * pageSize < total;

  const ApiPaginatedResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  factory ApiPaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromItem, {
    String dataKey = 'data',
  }) =>
      ApiPaginatedResponse(
        data: (json[dataKey] as List)
            .map((e) => fromItem(e as Map<String, dynamic>))
            .toList(),
        total: json['total'] as int,
        page: json['page'] as int,
        pageSize: json['pageSize'] as int,
      );
}
