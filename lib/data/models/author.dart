import 'package:freezed_annotation/freezed_annotation.dart';
import 'dynasty.dart';

part 'author.freezed.dart';
part 'author.g.dart';

@freezed
class AuthorBrief with _$AuthorBrief {
  const factory AuthorBrief({
    required String id,
    required String name,
    required Dynasty dynasty,
  }) = _AuthorBrief;

  factory AuthorBrief.fromJson(Map<String, dynamic> json) =>
      _$AuthorBriefFromJson(json);
}

@freezed
class Author with _$Author {
  const factory Author({
    required String id,
    required String name,
    String? courtesyName,
    String? pseudonym,
    required Dynasty dynasty,
    String? biography,
    String? birthplace,
    double? latitude,
    double? longitude,
    @Default([]) List<String> masterpieces,
    String? portraitUrl,
  }) = _Author;

  factory Author.fromJson(Map<String, dynamic> json) =>
      _$AuthorFromJson(json);
}
