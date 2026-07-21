// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Poem _$PoemFromJson(Map<String, dynamic> json) {
  return _Poem.fromJson(json);
}

/// @nodoc
mixin _$Poem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get translation => throw _privateConstructorUsedError;
  String? get annotation => throw _privateConstructorUsedError;
  String? get appreciation => throw _privateConstructorUsedError;
  String? get aiAppreciation => throw _privateConstructorUsedError;
  String? get aiImageUrl => throw _privateConstructorUsedError;
  AuthorBrief get author => throw _privateConstructorUsedError;
  Dynasty get dynasty => throw _privateConstructorUsedError;
  PoemCategory get category => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String? get pinyin => throw _privateConstructorUsedError;

  /// Serializes this Poem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Poem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoemCopyWith<Poem> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoemCopyWith<$Res> {
  factory $PoemCopyWith(Poem value, $Res Function(Poem) then) =
      _$PoemCopyWithImpl<$Res, Poem>;
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    String? translation,
    String? annotation,
    String? appreciation,
    String? aiAppreciation,
    String? aiImageUrl,
    AuthorBrief author,
    Dynasty dynasty,
    PoemCategory category,
    List<String> tags,
    String? pinyin,
  });

  $AuthorBriefCopyWith<$Res> get author;
  $DynastyCopyWith<$Res> get dynasty;
}

/// @nodoc
class _$PoemCopyWithImpl<$Res, $Val extends Poem>
    implements $PoemCopyWith<$Res> {
  _$PoemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Poem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? translation = freezed,
    Object? annotation = freezed,
    Object? appreciation = freezed,
    Object? aiAppreciation = freezed,
    Object? aiImageUrl = freezed,
    Object? author = null,
    Object? dynasty = null,
    Object? category = null,
    Object? tags = null,
    Object? pinyin = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            translation: freezed == translation
                ? _value.translation
                : translation // ignore: cast_nullable_to_non_nullable
                      as String?,
            annotation: freezed == annotation
                ? _value.annotation
                : annotation // ignore: cast_nullable_to_non_nullable
                      as String?,
            appreciation: freezed == appreciation
                ? _value.appreciation
                : appreciation // ignore: cast_nullable_to_non_nullable
                      as String?,
            aiAppreciation: freezed == aiAppreciation
                ? _value.aiAppreciation
                : aiAppreciation // ignore: cast_nullable_to_non_nullable
                      as String?,
            aiImageUrl: freezed == aiImageUrl
                ? _value.aiImageUrl
                : aiImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            author: null == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as AuthorBrief,
            dynasty: null == dynasty
                ? _value.dynasty
                : dynasty // ignore: cast_nullable_to_non_nullable
                      as Dynasty,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as PoemCategory,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            pinyin: freezed == pinyin
                ? _value.pinyin
                : pinyin // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Poem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthorBriefCopyWith<$Res> get author {
    return $AuthorBriefCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  /// Create a copy of Poem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DynastyCopyWith<$Res> get dynasty {
    return $DynastyCopyWith<$Res>(_value.dynasty, (value) {
      return _then(_value.copyWith(dynasty: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PoemImplCopyWith<$Res> implements $PoemCopyWith<$Res> {
  factory _$$PoemImplCopyWith(
    _$PoemImpl value,
    $Res Function(_$PoemImpl) then,
  ) = __$$PoemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    String? translation,
    String? annotation,
    String? appreciation,
    String? aiAppreciation,
    String? aiImageUrl,
    AuthorBrief author,
    Dynasty dynasty,
    PoemCategory category,
    List<String> tags,
    String? pinyin,
  });

  @override
  $AuthorBriefCopyWith<$Res> get author;
  @override
  $DynastyCopyWith<$Res> get dynasty;
}

/// @nodoc
class __$$PoemImplCopyWithImpl<$Res>
    extends _$PoemCopyWithImpl<$Res, _$PoemImpl>
    implements _$$PoemImplCopyWith<$Res> {
  __$$PoemImplCopyWithImpl(_$PoemImpl _value, $Res Function(_$PoemImpl) _then)
    : super(_value, _then);

  /// Create a copy of Poem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? translation = freezed,
    Object? annotation = freezed,
    Object? appreciation = freezed,
    Object? aiAppreciation = freezed,
    Object? aiImageUrl = freezed,
    Object? author = null,
    Object? dynasty = null,
    Object? category = null,
    Object? tags = null,
    Object? pinyin = freezed,
  }) {
    return _then(
      _$PoemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        translation: freezed == translation
            ? _value.translation
            : translation // ignore: cast_nullable_to_non_nullable
                  as String?,
        annotation: freezed == annotation
            ? _value.annotation
            : annotation // ignore: cast_nullable_to_non_nullable
                  as String?,
        appreciation: freezed == appreciation
            ? _value.appreciation
            : appreciation // ignore: cast_nullable_to_non_nullable
                  as String?,
        aiAppreciation: freezed == aiAppreciation
            ? _value.aiAppreciation
            : aiAppreciation // ignore: cast_nullable_to_non_nullable
                  as String?,
        aiImageUrl: freezed == aiImageUrl
            ? _value.aiImageUrl
            : aiImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        author: null == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as AuthorBrief,
        dynasty: null == dynasty
            ? _value.dynasty
            : dynasty // ignore: cast_nullable_to_non_nullable
                  as Dynasty,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PoemCategory,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        pinyin: freezed == pinyin
            ? _value.pinyin
            : pinyin // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PoemImpl implements _Poem {
  const _$PoemImpl({
    required this.id,
    required this.title,
    required this.content,
    this.translation,
    this.annotation,
    this.appreciation,
    this.aiAppreciation,
    this.aiImageUrl,
    required this.author,
    required this.dynasty,
    this.category = PoemCategory.misc,
    final List<String> tags = const [],
    this.pinyin,
  }) : _tags = tags;

  factory _$PoemImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String? translation;
  @override
  final String? annotation;
  @override
  final String? appreciation;
  @override
  final String? aiAppreciation;
  @override
  final String? aiImageUrl;
  @override
  final AuthorBrief author;
  @override
  final Dynasty dynasty;
  @override
  @JsonKey()
  final PoemCategory category;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? pinyin;

  @override
  String toString() {
    return 'Poem(id: $id, title: $title, content: $content, translation: $translation, annotation: $annotation, appreciation: $appreciation, aiAppreciation: $aiAppreciation, aiImageUrl: $aiImageUrl, author: $author, dynasty: $dynasty, category: $category, tags: $tags, pinyin: $pinyin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.translation, translation) ||
                other.translation == translation) &&
            (identical(other.annotation, annotation) ||
                other.annotation == annotation) &&
            (identical(other.appreciation, appreciation) ||
                other.appreciation == appreciation) &&
            (identical(other.aiAppreciation, aiAppreciation) ||
                other.aiAppreciation == aiAppreciation) &&
            (identical(other.aiImageUrl, aiImageUrl) ||
                other.aiImageUrl == aiImageUrl) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.dynasty, dynasty) || other.dynasty == dynasty) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.pinyin, pinyin) || other.pinyin == pinyin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    content,
    translation,
    annotation,
    appreciation,
    aiAppreciation,
    aiImageUrl,
    author,
    dynasty,
    category,
    const DeepCollectionEquality().hash(_tags),
    pinyin,
  );

  /// Create a copy of Poem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoemImplCopyWith<_$PoemImpl> get copyWith =>
      __$$PoemImplCopyWithImpl<_$PoemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoemImplToJson(this);
  }
}

abstract class _Poem implements Poem {
  const factory _Poem({
    required final String id,
    required final String title,
    required final String content,
    final String? translation,
    final String? annotation,
    final String? appreciation,
    final String? aiAppreciation,
    final String? aiImageUrl,
    required final AuthorBrief author,
    required final Dynasty dynasty,
    final PoemCategory category,
    final List<String> tags,
    final String? pinyin,
  }) = _$PoemImpl;

  factory _Poem.fromJson(Map<String, dynamic> json) = _$PoemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  String? get translation;
  @override
  String? get annotation;
  @override
  String? get appreciation;
  @override
  String? get aiAppreciation;
  @override
  String? get aiImageUrl;
  @override
  AuthorBrief get author;
  @override
  Dynasty get dynasty;
  @override
  PoemCategory get category;
  @override
  List<String> get tags;
  @override
  String? get pinyin;

  /// Create a copy of Poem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoemImplCopyWith<_$PoemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PoemBrief _$PoemBriefFromJson(Map<String, dynamic> json) {
  return _PoemBrief.fromJson(json);
}

/// @nodoc
mixin _$PoemBrief {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  String get dynastyName => throw _privateConstructorUsedError;
  PoemCategory? get category => throw _privateConstructorUsedError;

  /// Serializes this PoemBrief to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PoemBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PoemBriefCopyWith<PoemBrief> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PoemBriefCopyWith<$Res> {
  factory $PoemBriefCopyWith(PoemBrief value, $Res Function(PoemBrief) then) =
      _$PoemBriefCopyWithImpl<$Res, PoemBrief>;
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    String authorName,
    String dynastyName,
    PoemCategory? category,
  });
}

/// @nodoc
class _$PoemBriefCopyWithImpl<$Res, $Val extends PoemBrief>
    implements $PoemBriefCopyWith<$Res> {
  _$PoemBriefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PoemBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? authorName = null,
    Object? dynastyName = null,
    Object? category = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            authorName: null == authorName
                ? _value.authorName
                : authorName // ignore: cast_nullable_to_non_nullable
                      as String,
            dynastyName: null == dynastyName
                ? _value.dynastyName
                : dynastyName // ignore: cast_nullable_to_non_nullable
                      as String,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as PoemCategory?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PoemBriefImplCopyWith<$Res>
    implements $PoemBriefCopyWith<$Res> {
  factory _$$PoemBriefImplCopyWith(
    _$PoemBriefImpl value,
    $Res Function(_$PoemBriefImpl) then,
  ) = __$$PoemBriefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    String authorName,
    String dynastyName,
    PoemCategory? category,
  });
}

/// @nodoc
class __$$PoemBriefImplCopyWithImpl<$Res>
    extends _$PoemBriefCopyWithImpl<$Res, _$PoemBriefImpl>
    implements _$$PoemBriefImplCopyWith<$Res> {
  __$$PoemBriefImplCopyWithImpl(
    _$PoemBriefImpl _value,
    $Res Function(_$PoemBriefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PoemBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? authorName = null,
    Object? dynastyName = null,
    Object? category = freezed,
  }) {
    return _then(
      _$PoemBriefImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        authorName: null == authorName
            ? _value.authorName
            : authorName // ignore: cast_nullable_to_non_nullable
                  as String,
        dynastyName: null == dynastyName
            ? _value.dynastyName
            : dynastyName // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PoemCategory?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PoemBriefImpl implements _PoemBrief {
  const _$PoemBriefImpl({
    required this.id,
    required this.title,
    required this.content,
    required this.authorName,
    required this.dynastyName,
    this.category,
  });

  factory _$PoemBriefImpl.fromJson(Map<String, dynamic> json) =>
      _$$PoemBriefImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String authorName;
  @override
  final String dynastyName;
  @override
  final PoemCategory? category;

  @override
  String toString() {
    return 'PoemBrief(id: $id, title: $title, content: $content, authorName: $authorName, dynastyName: $dynastyName, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PoemBriefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.dynastyName, dynastyName) ||
                other.dynastyName == dynastyName) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    content,
    authorName,
    dynastyName,
    category,
  );

  /// Create a copy of PoemBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PoemBriefImplCopyWith<_$PoemBriefImpl> get copyWith =>
      __$$PoemBriefImplCopyWithImpl<_$PoemBriefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PoemBriefImplToJson(this);
  }
}

abstract class _PoemBrief implements PoemBrief {
  const factory _PoemBrief({
    required final String id,
    required final String title,
    required final String content,
    required final String authorName,
    required final String dynastyName,
    final PoemCategory? category,
  }) = _$PoemBriefImpl;

  factory _PoemBrief.fromJson(Map<String, dynamic> json) =
      _$PoemBriefImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  String get authorName;
  @override
  String get dynastyName;
  @override
  PoemCategory? get category;

  /// Create a copy of PoemBrief
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PoemBriefImplCopyWith<_$PoemBriefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
