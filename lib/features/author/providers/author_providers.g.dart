// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authorDetailHash() => r'6b4baa75aa2c2c8e3cc5d954fd042cad30a0f226';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 作者详情
///
/// Copied from [authorDetail].
@ProviderFor(authorDetail)
const authorDetailProvider = AuthorDetailFamily();

/// 作者详情
///
/// Copied from [authorDetail].
class AuthorDetailFamily extends Family<AsyncValue<Author>> {
  /// 作者详情
  ///
  /// Copied from [authorDetail].
  const AuthorDetailFamily();

  /// 作者详情
  ///
  /// Copied from [authorDetail].
  AuthorDetailProvider call(String authorId) {
    return AuthorDetailProvider(authorId);
  }

  @override
  AuthorDetailProvider getProviderOverride(
    covariant AuthorDetailProvider provider,
  ) {
    return call(provider.authorId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'authorDetailProvider';
}

/// 作者详情
///
/// Copied from [authorDetail].
class AuthorDetailProvider extends AutoDisposeFutureProvider<Author> {
  /// 作者详情
  ///
  /// Copied from [authorDetail].
  AuthorDetailProvider(String authorId)
    : this._internal(
        (ref) => authorDetail(ref as AuthorDetailRef, authorId),
        from: authorDetailProvider,
        name: r'authorDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$authorDetailHash,
        dependencies: AuthorDetailFamily._dependencies,
        allTransitiveDependencies:
            AuthorDetailFamily._allTransitiveDependencies,
        authorId: authorId,
      );

  AuthorDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.authorId,
  }) : super.internal();

  final String authorId;

  @override
  Override overrideWith(
    FutureOr<Author> Function(AuthorDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthorDetailProvider._internal(
        (ref) => create(ref as AuthorDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        authorId: authorId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Author> createElement() {
    return _AuthorDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorDetailProvider && other.authorId == authorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, authorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AuthorDetailRef on AutoDisposeFutureProviderRef<Author> {
  /// The parameter `authorId` of this provider.
  String get authorId;
}

class _AuthorDetailProviderElement
    extends AutoDisposeFutureProviderElement<Author>
    with AuthorDetailRef {
  _AuthorDetailProviderElement(super.provider);

  @override
  String get authorId => (origin as AuthorDetailProvider).authorId;
}

String _$authorMasterpiecesHash() =>
    r'fb17c85603b6389ff4324028f0812235bd4497de';

/// 作者代表作
///
/// Copied from [authorMasterpieces].
@ProviderFor(authorMasterpieces)
const authorMasterpiecesProvider = AuthorMasterpiecesFamily();

/// 作者代表作
///
/// Copied from [authorMasterpieces].
class AuthorMasterpiecesFamily extends Family<AsyncValue<List<Poem>>> {
  /// 作者代表作
  ///
  /// Copied from [authorMasterpieces].
  const AuthorMasterpiecesFamily();

  /// 作者代表作
  ///
  /// Copied from [authorMasterpieces].
  AuthorMasterpiecesProvider call(String authorId) {
    return AuthorMasterpiecesProvider(authorId);
  }

  @override
  AuthorMasterpiecesProvider getProviderOverride(
    covariant AuthorMasterpiecesProvider provider,
  ) {
    return call(provider.authorId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'authorMasterpiecesProvider';
}

/// 作者代表作
///
/// Copied from [authorMasterpieces].
class AuthorMasterpiecesProvider extends AutoDisposeFutureProvider<List<Poem>> {
  /// 作者代表作
  ///
  /// Copied from [authorMasterpieces].
  AuthorMasterpiecesProvider(String authorId)
    : this._internal(
        (ref) => authorMasterpieces(ref as AuthorMasterpiecesRef, authorId),
        from: authorMasterpiecesProvider,
        name: r'authorMasterpiecesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$authorMasterpiecesHash,
        dependencies: AuthorMasterpiecesFamily._dependencies,
        allTransitiveDependencies:
            AuthorMasterpiecesFamily._allTransitiveDependencies,
        authorId: authorId,
      );

  AuthorMasterpiecesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.authorId,
  }) : super.internal();

  final String authorId;

  @override
  Override overrideWith(
    FutureOr<List<Poem>> Function(AuthorMasterpiecesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AuthorMasterpiecesProvider._internal(
        (ref) => create(ref as AuthorMasterpiecesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        authorId: authorId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Poem>> createElement() {
    return _AuthorMasterpiecesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorMasterpiecesProvider && other.authorId == authorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, authorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AuthorMasterpiecesRef on AutoDisposeFutureProviderRef<List<Poem>> {
  /// The parameter `authorId` of this provider.
  String get authorId;
}

class _AuthorMasterpiecesProviderElement
    extends AutoDisposeFutureProviderElement<List<Poem>>
    with AuthorMasterpiecesRef {
  _AuthorMasterpiecesProviderElement(super.provider);

  @override
  String get authorId => (origin as AuthorMasterpiecesProvider).authorId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
