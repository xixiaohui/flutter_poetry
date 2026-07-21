// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthorBriefImpl _$$AuthorBriefImplFromJson(Map<String, dynamic> json) =>
    _$AuthorBriefImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      dynasty: Dynasty.fromJson(json['dynasty'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthorBriefImplToJson(_$AuthorBriefImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dynasty': instance.dynasty,
    };

_$AuthorImpl _$$AuthorImplFromJson(Map<String, dynamic> json) => _$AuthorImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  courtesyName: json['courtesyName'] as String?,
  pseudonym: json['pseudonym'] as String?,
  dynasty: Dynasty.fromJson(json['dynasty'] as Map<String, dynamic>),
  biography: json['biography'] as String?,
  birthplace: json['birthplace'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  masterpieces:
      (json['masterpieces'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  portraitUrl: json['portraitUrl'] as String?,
);

Map<String, dynamic> _$$AuthorImplToJson(_$AuthorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'courtesyName': instance.courtesyName,
      'pseudonym': instance.pseudonym,
      'dynasty': instance.dynasty,
      'biography': instance.biography,
      'birthplace': instance.birthplace,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'masterpieces': instance.masterpieces,
      'portraitUrl': instance.portraitUrl,
    };
