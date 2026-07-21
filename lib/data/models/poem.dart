import 'package:freezed_annotation/freezed_annotation.dart';
import 'author.dart';
import 'dynasty.dart';

part 'poem.freezed.dart';
part 'poem.g.dart';

enum PoemCategory {
  @JsonValue('landscape') landscape,     // 山水
  @JsonValue('farewell') farewell,       // 送别
  @JsonValue('frontier') frontier,       // 边塞
  @JsonValue('pastoral') pastoral,       // 田园
  @JsonValue('nostalgic') nostalgic,     // 怀古
  @JsonValue('romantic') romantic,       // 爱情
  @JsonValue('philosophical') philosophical, // 哲理
  @JsonValue('political') political,     // 政治
  @JsonValue('seasonal') seasonal,       // 时令
  @JsonValue('misc') misc,               // 其他
}

@freezed
class Poem with _$Poem {
  const factory Poem({
    required String id,
    required String title,
    required String content,
    String? translation,
    String? annotation,
    String? appreciation,
    String? aiAppreciation,
    String? aiImageUrl,
    required AuthorBrief author,
    required Dynasty dynasty,
    @Default(PoemCategory.misc) PoemCategory category,
    @Default([]) List<String> tags,
    String? pinyin,
  }) = _Poem;

  factory Poem.fromJson(Map<String, dynamic> json) => _$PoemFromJson(json);
}

@freezed
class PoemBrief with _$PoemBrief {
  const factory PoemBrief({
    required String id,
    required String title,
    required String content,
    required String authorName,
    required String dynastyName,
    PoemCategory? category,
  }) = _PoemBrief;

  factory PoemBrief.fromJson(Map<String, dynamic> json) =>
      _$PoemBriefFromJson(json);
}
