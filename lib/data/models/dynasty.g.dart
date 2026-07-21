// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynasty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DynastyImpl _$$DynastyImplFromJson(Map<String, dynamic> json) =>
    _$DynastyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      startYear: (json['startYear'] as num?)?.toInt(),
      endYear: (json['endYear'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DynastyImplToJson(_$DynastyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startYear': instance.startYear,
      'endYear': instance.endYear,
    };
