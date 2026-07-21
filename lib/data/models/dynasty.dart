import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynasty.freezed.dart';
part 'dynasty.g.dart';

@freezed
class Dynasty with _$Dynasty {
  const factory Dynasty({
    required String id,
    required String name,
    int? startYear,
    int? endYear,
  }) = _Dynasty;

  factory Dynasty.fromJson(Map<String, dynamic> json) =>
      _$DynastyFromJson(json);
}
