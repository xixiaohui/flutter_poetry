// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browse_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$browsePoemsHash() => r'82b941896ba638c8041af1a4f1e53630a559c34d';

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

abstract class _$BrowsePoems
    extends BuildlessAutoDisposeAsyncNotifier<List<ApiPoem>> {
  late final String? dynasty;
  late final String? type;

  FutureOr<List<ApiPoem>> build({String? dynasty, String? type});
}

/// 浏览页 state — 页码、更多标记、诗词列表
///
/// Copied from [BrowsePoems].
@ProviderFor(BrowsePoems)
const browsePoemsProvider = BrowsePoemsFamily();

/// 浏览页 state — 页码、更多标记、诗词列表
///
/// Copied from [BrowsePoems].
class BrowsePoemsFamily extends Family<AsyncValue<List<ApiPoem>>> {
  /// 浏览页 state — 页码、更多标记、诗词列表
  ///
  /// Copied from [BrowsePoems].
  const BrowsePoemsFamily();

  /// 浏览页 state — 页码、更多标记、诗词列表
  ///
  /// Copied from [BrowsePoems].
  BrowsePoemsProvider call({String? dynasty, String? type}) {
    return BrowsePoemsProvider(dynasty: dynasty, type: type);
  }

  @override
  BrowsePoemsProvider getProviderOverride(
    covariant BrowsePoemsProvider provider,
  ) {
    return call(dynasty: provider.dynasty, type: provider.type);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'browsePoemsProvider';
}

/// 浏览页 state — 页码、更多标记、诗词列表
///
/// Copied from [BrowsePoems].
class BrowsePoemsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BrowsePoems, List<ApiPoem>> {
  /// 浏览页 state — 页码、更多标记、诗词列表
  ///
  /// Copied from [BrowsePoems].
  BrowsePoemsProvider({String? dynasty, String? type})
    : this._internal(
        () => BrowsePoems()
          ..dynasty = dynasty
          ..type = type,
        from: browsePoemsProvider,
        name: r'browsePoemsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$browsePoemsHash,
        dependencies: BrowsePoemsFamily._dependencies,
        allTransitiveDependencies: BrowsePoemsFamily._allTransitiveDependencies,
        dynasty: dynasty,
        type: type,
      );

  BrowsePoemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dynasty,
    required this.type,
  }) : super.internal();

  final String? dynasty;
  final String? type;

  @override
  FutureOr<List<ApiPoem>> runNotifierBuild(covariant BrowsePoems notifier) {
    return notifier.build(dynasty: dynasty, type: type);
  }

  @override
  Override overrideWith(BrowsePoems Function() create) {
    return ProviderOverride(
      origin: this,
      override: BrowsePoemsProvider._internal(
        () => create()
          ..dynasty = dynasty
          ..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dynasty: dynasty,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BrowsePoems, List<ApiPoem>>
  createElement() {
    return _BrowsePoemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BrowsePoemsProvider &&
        other.dynasty == dynasty &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dynasty.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BrowsePoemsRef on AutoDisposeAsyncNotifierProviderRef<List<ApiPoem>> {
  /// The parameter `dynasty` of this provider.
  String? get dynasty;

  /// The parameter `type` of this provider.
  String? get type;
}

class _BrowsePoemsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BrowsePoems, List<ApiPoem>>
    with BrowsePoemsRef {
  _BrowsePoemsProviderElement(super.provider);

  @override
  String? get dynasty => (origin as BrowsePoemsProvider).dynasty;
  @override
  String? get type => (origin as BrowsePoemsProvider).type;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
