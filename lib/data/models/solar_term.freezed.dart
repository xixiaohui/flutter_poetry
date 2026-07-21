// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solar_term.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SolarTerm _$SolarTermFromJson(Map<String, dynamic> json) {
  return _SolarTerm.fromJson(json);
}

/// @nodoc
mixin _$SolarTerm {
  String get name => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<PoemBrief> get relatedPoems => throw _privateConstructorUsedError;

  /// Serializes this SolarTerm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolarTerm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolarTermCopyWith<SolarTerm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolarTermCopyWith<$Res> {
  factory $SolarTermCopyWith(SolarTerm value, $Res Function(SolarTerm) then) =
      _$SolarTermCopyWithImpl<$Res, SolarTerm>;
  @useResult
  $Res call({
    String name,
    DateTime date,
    String? description,
    List<PoemBrief> relatedPoems,
  });
}

/// @nodoc
class _$SolarTermCopyWithImpl<$Res, $Val extends SolarTerm>
    implements $SolarTermCopyWith<$Res> {
  _$SolarTermCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolarTerm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? description = freezed,
    Object? relatedPoems = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            relatedPoems: null == relatedPoems
                ? _value.relatedPoems
                : relatedPoems // ignore: cast_nullable_to_non_nullable
                      as List<PoemBrief>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SolarTermImplCopyWith<$Res>
    implements $SolarTermCopyWith<$Res> {
  factory _$$SolarTermImplCopyWith(
    _$SolarTermImpl value,
    $Res Function(_$SolarTermImpl) then,
  ) = __$$SolarTermImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    DateTime date,
    String? description,
    List<PoemBrief> relatedPoems,
  });
}

/// @nodoc
class __$$SolarTermImplCopyWithImpl<$Res>
    extends _$SolarTermCopyWithImpl<$Res, _$SolarTermImpl>
    implements _$$SolarTermImplCopyWith<$Res> {
  __$$SolarTermImplCopyWithImpl(
    _$SolarTermImpl _value,
    $Res Function(_$SolarTermImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SolarTerm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? description = freezed,
    Object? relatedPoems = null,
  }) {
    return _then(
      _$SolarTermImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        relatedPoems: null == relatedPoems
            ? _value._relatedPoems
            : relatedPoems // ignore: cast_nullable_to_non_nullable
                  as List<PoemBrief>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SolarTermImpl implements _SolarTerm {
  const _$SolarTermImpl({
    required this.name,
    required this.date,
    this.description,
    final List<PoemBrief> relatedPoems = const [],
  }) : _relatedPoems = relatedPoems;

  factory _$SolarTermImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolarTermImplFromJson(json);

  @override
  final String name;
  @override
  final DateTime date;
  @override
  final String? description;
  final List<PoemBrief> _relatedPoems;
  @override
  @JsonKey()
  List<PoemBrief> get relatedPoems {
    if (_relatedPoems is EqualUnmodifiableListView) return _relatedPoems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedPoems);
  }

  @override
  String toString() {
    return 'SolarTerm(name: $name, date: $date, description: $description, relatedPoems: $relatedPoems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolarTermImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._relatedPoems,
              _relatedPoems,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    date,
    description,
    const DeepCollectionEquality().hash(_relatedPoems),
  );

  /// Create a copy of SolarTerm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolarTermImplCopyWith<_$SolarTermImpl> get copyWith =>
      __$$SolarTermImplCopyWithImpl<_$SolarTermImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolarTermImplToJson(this);
  }
}

abstract class _SolarTerm implements SolarTerm {
  const factory _SolarTerm({
    required final String name,
    required final DateTime date,
    final String? description,
    final List<PoemBrief> relatedPoems,
  }) = _$SolarTermImpl;

  factory _SolarTerm.fromJson(Map<String, dynamic> json) =
      _$SolarTermImpl.fromJson;

  @override
  String get name;
  @override
  DateTime get date;
  @override
  String? get description;
  @override
  List<PoemBrief> get relatedPoems;

  /// Create a copy of SolarTerm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolarTermImplCopyWith<_$SolarTermImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
