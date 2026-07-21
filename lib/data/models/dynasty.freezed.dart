// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynasty.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Dynasty _$DynastyFromJson(Map<String, dynamic> json) {
  return _Dynasty.fromJson(json);
}

/// @nodoc
mixin _$Dynasty {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get startYear => throw _privateConstructorUsedError;
  int? get endYear => throw _privateConstructorUsedError;

  /// Serializes this Dynasty to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Dynasty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DynastyCopyWith<Dynasty> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynastyCopyWith<$Res> {
  factory $DynastyCopyWith(Dynasty value, $Res Function(Dynasty) then) =
      _$DynastyCopyWithImpl<$Res, Dynasty>;
  @useResult
  $Res call({String id, String name, int? startYear, int? endYear});
}

/// @nodoc
class _$DynastyCopyWithImpl<$Res, $Val extends Dynasty>
    implements $DynastyCopyWith<$Res> {
  _$DynastyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Dynasty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startYear = freezed,
    Object? endYear = freezed,
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
            startYear: freezed == startYear
                ? _value.startYear
                : startYear // ignore: cast_nullable_to_non_nullable
                      as int?,
            endYear: freezed == endYear
                ? _value.endYear
                : endYear // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DynastyImplCopyWith<$Res> implements $DynastyCopyWith<$Res> {
  factory _$$DynastyImplCopyWith(
    _$DynastyImpl value,
    $Res Function(_$DynastyImpl) then,
  ) = __$$DynastyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int? startYear, int? endYear});
}

/// @nodoc
class __$$DynastyImplCopyWithImpl<$Res>
    extends _$DynastyCopyWithImpl<$Res, _$DynastyImpl>
    implements _$$DynastyImplCopyWith<$Res> {
  __$$DynastyImplCopyWithImpl(
    _$DynastyImpl _value,
    $Res Function(_$DynastyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Dynasty
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startYear = freezed,
    Object? endYear = freezed,
  }) {
    return _then(
      _$DynastyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        startYear: freezed == startYear
            ? _value.startYear
            : startYear // ignore: cast_nullable_to_non_nullable
                  as int?,
        endYear: freezed == endYear
            ? _value.endYear
            : endYear // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DynastyImpl implements _Dynasty {
  const _$DynastyImpl({
    required this.id,
    required this.name,
    this.startYear,
    this.endYear,
  });

  factory _$DynastyImpl.fromJson(Map<String, dynamic> json) =>
      _$$DynastyImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int? startYear;
  @override
  final int? endYear;

  @override
  String toString() {
    return 'Dynasty(id: $id, name: $name, startYear: $startYear, endYear: $endYear)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DynastyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startYear, startYear) ||
                other.startYear == startYear) &&
            (identical(other.endYear, endYear) || other.endYear == endYear));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, startYear, endYear);

  /// Create a copy of Dynasty
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DynastyImplCopyWith<_$DynastyImpl> get copyWith =>
      __$$DynastyImplCopyWithImpl<_$DynastyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DynastyImplToJson(this);
  }
}

abstract class _Dynasty implements Dynasty {
  const factory _Dynasty({
    required final String id,
    required final String name,
    final int? startYear,
    final int? endYear,
  }) = _$DynastyImpl;

  factory _Dynasty.fromJson(Map<String, dynamic> json) = _$DynastyImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int? get startYear;
  @override
  int? get endYear;

  /// Create a copy of Dynasty
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DynastyImplCopyWith<_$DynastyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
