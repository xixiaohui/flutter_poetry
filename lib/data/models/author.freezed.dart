// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'author.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthorBrief _$AuthorBriefFromJson(Map<String, dynamic> json) {
  return _AuthorBrief.fromJson(json);
}

/// @nodoc
mixin _$AuthorBrief {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Dynasty get dynasty => throw _privateConstructorUsedError;

  /// Serializes this AuthorBrief to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthorBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthorBriefCopyWith<AuthorBrief> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorBriefCopyWith<$Res> {
  factory $AuthorBriefCopyWith(
    AuthorBrief value,
    $Res Function(AuthorBrief) then,
  ) = _$AuthorBriefCopyWithImpl<$Res, AuthorBrief>;
  @useResult
  $Res call({String id, String name, Dynasty dynasty});

  $DynastyCopyWith<$Res> get dynasty;
}

/// @nodoc
class _$AuthorBriefCopyWithImpl<$Res, $Val extends AuthorBrief>
    implements $AuthorBriefCopyWith<$Res> {
  _$AuthorBriefCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthorBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? dynasty = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            dynasty: null == dynasty
                ? _value.dynasty
                : dynasty // ignore: cast_nullable_to_non_nullable
                      as Dynasty,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthorBrief
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
abstract class _$$AuthorBriefImplCopyWith<$Res>
    implements $AuthorBriefCopyWith<$Res> {
  factory _$$AuthorBriefImplCopyWith(
    _$AuthorBriefImpl value,
    $Res Function(_$AuthorBriefImpl) then,
  ) = __$$AuthorBriefImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, Dynasty dynasty});

  @override
  $DynastyCopyWith<$Res> get dynasty;
}

/// @nodoc
class __$$AuthorBriefImplCopyWithImpl<$Res>
    extends _$AuthorBriefCopyWithImpl<$Res, _$AuthorBriefImpl>
    implements _$$AuthorBriefImplCopyWith<$Res> {
  __$$AuthorBriefImplCopyWithImpl(
    _$AuthorBriefImpl _value,
    $Res Function(_$AuthorBriefImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthorBrief
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? dynasty = null}) {
    return _then(
      _$AuthorBriefImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        dynasty: null == dynasty
            ? _value.dynasty
            : dynasty // ignore: cast_nullable_to_non_nullable
                  as Dynasty,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthorBriefImpl implements _AuthorBrief {
  const _$AuthorBriefImpl({
    required this.id,
    required this.name,
    required this.dynasty,
  });

  factory _$AuthorBriefImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorBriefImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final Dynasty dynasty;

  @override
  String toString() {
    return 'AuthorBrief(id: $id, name: $name, dynasty: $dynasty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorBriefImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dynasty, dynasty) || other.dynasty == dynasty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, dynasty);

  /// Create a copy of AuthorBrief
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorBriefImplCopyWith<_$AuthorBriefImpl> get copyWith =>
      __$$AuthorBriefImplCopyWithImpl<_$AuthorBriefImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorBriefImplToJson(this);
  }
}

abstract class _AuthorBrief implements AuthorBrief {
  const factory _AuthorBrief({
    required final String id,
    required final String name,
    required final Dynasty dynasty,
  }) = _$AuthorBriefImpl;

  factory _AuthorBrief.fromJson(Map<String, dynamic> json) =
      _$AuthorBriefImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  Dynasty get dynasty;

  /// Create a copy of AuthorBrief
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthorBriefImplCopyWith<_$AuthorBriefImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return _Author.fromJson(json);
}

/// @nodoc
mixin _$Author {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get courtesyName => throw _privateConstructorUsedError;
  String? get pseudonym => throw _privateConstructorUsedError;
  Dynasty get dynasty => throw _privateConstructorUsedError;
  String? get biography => throw _privateConstructorUsedError;
  String? get birthplace => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  List<String> get masterpieces => throw _privateConstructorUsedError;
  String? get portraitUrl => throw _privateConstructorUsedError;

  /// Serializes this Author to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthorCopyWith<Author> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthorCopyWith<$Res> {
  factory $AuthorCopyWith(Author value, $Res Function(Author) then) =
      _$AuthorCopyWithImpl<$Res, Author>;
  @useResult
  $Res call({
    String id,
    String name,
    String? courtesyName,
    String? pseudonym,
    Dynasty dynasty,
    String? biography,
    String? birthplace,
    double? latitude,
    double? longitude,
    List<String> masterpieces,
    String? portraitUrl,
  });

  $DynastyCopyWith<$Res> get dynasty;
}

/// @nodoc
class _$AuthorCopyWithImpl<$Res, $Val extends Author>
    implements $AuthorCopyWith<$Res> {
  _$AuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? courtesyName = freezed,
    Object? pseudonym = freezed,
    Object? dynasty = null,
    Object? biography = freezed,
    Object? birthplace = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? masterpieces = null,
    Object? portraitUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            courtesyName: freezed == courtesyName
                ? _value.courtesyName
                : courtesyName // ignore: cast_nullable_to_non_nullable
                      as String?,
            pseudonym: freezed == pseudonym
                ? _value.pseudonym
                : pseudonym // ignore: cast_nullable_to_non_nullable
                      as String?,
            dynasty: null == dynasty
                ? _value.dynasty
                : dynasty // ignore: cast_nullable_to_non_nullable
                      as Dynasty,
            biography: freezed == biography
                ? _value.biography
                : biography // ignore: cast_nullable_to_non_nullable
                      as String?,
            birthplace: freezed == birthplace
                ? _value.birthplace
                : birthplace // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            masterpieces: null == masterpieces
                ? _value.masterpieces
                : masterpieces // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            portraitUrl: freezed == portraitUrl
                ? _value.portraitUrl
                : portraitUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Author
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
abstract class _$$AuthorImplCopyWith<$Res> implements $AuthorCopyWith<$Res> {
  factory _$$AuthorImplCopyWith(
    _$AuthorImpl value,
    $Res Function(_$AuthorImpl) then,
  ) = __$$AuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? courtesyName,
    String? pseudonym,
    Dynasty dynasty,
    String? biography,
    String? birthplace,
    double? latitude,
    double? longitude,
    List<String> masterpieces,
    String? portraitUrl,
  });

  @override
  $DynastyCopyWith<$Res> get dynasty;
}

/// @nodoc
class __$$AuthorImplCopyWithImpl<$Res>
    extends _$AuthorCopyWithImpl<$Res, _$AuthorImpl>
    implements _$$AuthorImplCopyWith<$Res> {
  __$$AuthorImplCopyWithImpl(
    _$AuthorImpl _value,
    $Res Function(_$AuthorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? courtesyName = freezed,
    Object? pseudonym = freezed,
    Object? dynasty = null,
    Object? biography = freezed,
    Object? birthplace = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? masterpieces = null,
    Object? portraitUrl = freezed,
  }) {
    return _then(
      _$AuthorImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        courtesyName: freezed == courtesyName
            ? _value.courtesyName
            : courtesyName // ignore: cast_nullable_to_non_nullable
                  as String?,
        pseudonym: freezed == pseudonym
            ? _value.pseudonym
            : pseudonym // ignore: cast_nullable_to_non_nullable
                  as String?,
        dynasty: null == dynasty
            ? _value.dynasty
            : dynasty // ignore: cast_nullable_to_non_nullable
                  as Dynasty,
        biography: freezed == biography
            ? _value.biography
            : biography // ignore: cast_nullable_to_non_nullable
                  as String?,
        birthplace: freezed == birthplace
            ? _value.birthplace
            : birthplace // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        masterpieces: null == masterpieces
            ? _value._masterpieces
            : masterpieces // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        portraitUrl: freezed == portraitUrl
            ? _value.portraitUrl
            : portraitUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthorImpl implements _Author {
  const _$AuthorImpl({
    required this.id,
    required this.name,
    this.courtesyName,
    this.pseudonym,
    required this.dynasty,
    this.biography,
    this.birthplace,
    this.latitude,
    this.longitude,
    final List<String> masterpieces = const [],
    this.portraitUrl,
  }) : _masterpieces = masterpieces;

  factory _$AuthorImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthorImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? courtesyName;
  @override
  final String? pseudonym;
  @override
  final Dynasty dynasty;
  @override
  final String? biography;
  @override
  final String? birthplace;
  @override
  final double? latitude;
  @override
  final double? longitude;
  final List<String> _masterpieces;
  @override
  @JsonKey()
  List<String> get masterpieces {
    if (_masterpieces is EqualUnmodifiableListView) return _masterpieces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_masterpieces);
  }

  @override
  final String? portraitUrl;

  @override
  String toString() {
    return 'Author(id: $id, name: $name, courtesyName: $courtesyName, pseudonym: $pseudonym, dynasty: $dynasty, biography: $biography, birthplace: $birthplace, latitude: $latitude, longitude: $longitude, masterpieces: $masterpieces, portraitUrl: $portraitUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.courtesyName, courtesyName) ||
                other.courtesyName == courtesyName) &&
            (identical(other.pseudonym, pseudonym) ||
                other.pseudonym == pseudonym) &&
            (identical(other.dynasty, dynasty) || other.dynasty == dynasty) &&
            (identical(other.biography, biography) ||
                other.biography == biography) &&
            (identical(other.birthplace, birthplace) ||
                other.birthplace == birthplace) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality().equals(
              other._masterpieces,
              _masterpieces,
            ) &&
            (identical(other.portraitUrl, portraitUrl) ||
                other.portraitUrl == portraitUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    courtesyName,
    pseudonym,
    dynasty,
    biography,
    birthplace,
    latitude,
    longitude,
    const DeepCollectionEquality().hash(_masterpieces),
    portraitUrl,
  );

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthorImplCopyWith<_$AuthorImpl> get copyWith =>
      __$$AuthorImplCopyWithImpl<_$AuthorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthorImplToJson(this);
  }
}

abstract class _Author implements Author {
  const factory _Author({
    required final String id,
    required final String name,
    final String? courtesyName,
    final String? pseudonym,
    required final Dynasty dynasty,
    final String? biography,
    final String? birthplace,
    final double? latitude,
    final double? longitude,
    final List<String> masterpieces,
    final String? portraitUrl,
  }) = _$AuthorImpl;

  factory _Author.fromJson(Map<String, dynamic> json) = _$AuthorImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get courtesyName;
  @override
  String? get pseudonym;
  @override
  Dynasty get dynasty;
  @override
  String? get biography;
  @override
  String? get birthplace;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  List<String> get masterpieces;
  @override
  String? get portraitUrl;

  /// Create a copy of Author
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthorImplCopyWith<_$AuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
