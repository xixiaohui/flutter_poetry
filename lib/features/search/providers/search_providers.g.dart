// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchResultsHash() => r'a42274b4f3d23068af2b8ca0636f266c544f601f';

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

abstract class _$SearchResults
    extends BuildlessAutoDisposeAsyncNotifier<List<ApiPoem>> {
  late final String query;
  late final String type;

  FutureOr<List<ApiPoem>> build(String query, {String type = 'all'});
}

/// 搜索页 state — 页码、更多标记、搜索结果列表
///
/// Copied from [SearchResults].
@ProviderFor(SearchResults)
const searchResultsProvider = SearchResultsFamily();

/// 搜索页 state — 页码、更多标记、搜索结果列表
///
/// Copied from [SearchResults].
class SearchResultsFamily extends Family<AsyncValue<List<ApiPoem>>> {
  /// 搜索页 state — 页码、更多标记、搜索结果列表
  ///
  /// Copied from [SearchResults].
  const SearchResultsFamily();

  /// 搜索页 state — 页码、更多标记、搜索结果列表
  ///
  /// Copied from [SearchResults].
  SearchResultsProvider call(String query, {String type = 'all'}) {
    return SearchResultsProvider(query, type: type);
  }

  @override
  SearchResultsProvider getProviderOverride(
    covariant SearchResultsProvider provider,
  ) {
    return call(provider.query, type: provider.type);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchResultsProvider';
}

/// 搜索页 state — 页码、更多标记、搜索结果列表
///
/// Copied from [SearchResults].
class SearchResultsProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SearchResults, List<ApiPoem>> {
  /// 搜索页 state — 页码、更多标记、搜索结果列表
  ///
  /// Copied from [SearchResults].
  SearchResultsProvider(String query, {String type = 'all'})
    : this._internal(
        () => SearchResults()
          ..query = query
          ..type = type,
        from: searchResultsProvider,
        name: r'searchResultsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$searchResultsHash,
        dependencies: SearchResultsFamily._dependencies,
        allTransitiveDependencies:
            SearchResultsFamily._allTransitiveDependencies,
        query: query,
        type: type,
      );

  SearchResultsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
    required this.type,
  }) : super.internal();

  final String query;
  final String type;

  @override
  FutureOr<List<ApiPoem>> runNotifierBuild(covariant SearchResults notifier) {
    return notifier.build(query, type: type);
  }

  @override
  Override overrideWith(SearchResults Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchResultsProvider._internal(
        () => create()
          ..query = query
          ..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SearchResults, List<ApiPoem>>
  createElement() {
    return _SearchResultsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchResultsProvider &&
        other.query == query &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchResultsRef on AutoDisposeAsyncNotifierProviderRef<List<ApiPoem>> {
  /// The parameter `query` of this provider.
  String get query;

  /// The parameter `type` of this provider.
  String get type;
}

class _SearchResultsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<SearchResults, List<ApiPoem>>
    with SearchResultsRef {
  _SearchResultsProviderElement(super.provider);

  @override
  String get query => (origin as SearchResultsProvider).query;
  @override
  String get type => (origin as SearchResultsProvider).type;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
