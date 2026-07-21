// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solar_term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolarTermImpl _$$SolarTermImplFromJson(Map<String, dynamic> json) =>
    _$SolarTermImpl(
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      relatedPoems:
          (json['relatedPoems'] as List<dynamic>?)
              ?.map((e) => PoemBrief.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$SolarTermImplToJson(_$SolarTermImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
      'relatedPoems': instance.relatedPoems,
    };
