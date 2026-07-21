import 'package:freezed_annotation/freezed_annotation.dart';
import 'poem.dart';

part 'solar_term.freezed.dart';
part 'solar_term.g.dart';

@freezed
class SolarTerm with _$SolarTerm {
  const factory SolarTerm({
    required String name,
    required DateTime date,
    String? description,
    @Default([]) List<PoemBrief> relatedPoems,
  }) = _SolarTerm;

  factory SolarTerm.fromJson(Map<String, dynamic> json) =>
      _$SolarTermFromJson(json);
}
