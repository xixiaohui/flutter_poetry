// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PoemImpl _$$PoemImplFromJson(Map<String, dynamic> json) => _$PoemImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  translation: json['translation'] as String?,
  annotation: json['annotation'] as String?,
  appreciation: json['appreciation'] as String?,
  aiAppreciation: json['aiAppreciation'] as String?,
  aiImageUrl: json['aiImageUrl'] as String?,
  author: AuthorBrief.fromJson(json['author'] as Map<String, dynamic>),
  dynasty: Dynasty.fromJson(json['dynasty'] as Map<String, dynamic>),
  category:
      $enumDecodeNullable(_$PoemCategoryEnumMap, json['category']) ??
      PoemCategory.misc,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  pinyin: json['pinyin'] as String?,
);

Map<String, dynamic> _$$PoemImplToJson(_$PoemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'translation': instance.translation,
      'annotation': instance.annotation,
      'appreciation': instance.appreciation,
      'aiAppreciation': instance.aiAppreciation,
      'aiImageUrl': instance.aiImageUrl,
      'author': instance.author,
      'dynasty': instance.dynasty,
      'category': _$PoemCategoryEnumMap[instance.category]!,
      'tags': instance.tags,
      'pinyin': instance.pinyin,
    };

const _$PoemCategoryEnumMap = {
  PoemCategory.landscape: 'landscape',
  PoemCategory.farewell: 'farewell',
  PoemCategory.frontier: 'frontier',
  PoemCategory.pastoral: 'pastoral',
  PoemCategory.nostalgic: 'nostalgic',
  PoemCategory.romantic: 'romantic',
  PoemCategory.philosophical: 'philosophical',
  PoemCategory.political: 'political',
  PoemCategory.seasonal: 'seasonal',
  PoemCategory.misc: 'misc',
};

_$PoemBriefImpl _$$PoemBriefImplFromJson(Map<String, dynamic> json) =>
    _$PoemBriefImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      authorName: json['authorName'] as String,
      dynastyName: json['dynastyName'] as String,
      category: $enumDecodeNullable(_$PoemCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$$PoemBriefImplToJson(_$PoemBriefImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorName': instance.authorName,
      'dynastyName': instance.dynastyName,
      'category': _$PoemCategoryEnumMap[instance.category],
    };
