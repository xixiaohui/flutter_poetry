// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeDataHash() => r'17a6320b9fdf610ab8f466a724b45f7fd270223e';

/// 首页聚合数据 — 独立 provider，渐进渲染
///
/// Copied from [homeData].
@ProviderFor(homeData)
final homeDataProvider = AutoDisposeFutureProvider<HomeData>.internal(
  homeData,
  name: r'homeDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeDataRef = AutoDisposeFutureProviderRef<HomeData>;
String _$solarTermHash() => r'086795fb24da47493e81677f8d031ff988874d5a';

/// 节气推荐 — 独立 provider
///
/// Copied from [solarTerm].
@ProviderFor(solarTerm)
final solarTermProvider = AutoDisposeFutureProvider<SolarTermData>.internal(
  solarTerm,
  name: r'solarTermProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$solarTermHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SolarTermRef = AutoDisposeFutureProviderRef<SolarTermData>;
String _$recentReadsHash() => r'1f9e61e428f2b69f30a1fa65e78620774ee0fdb3';

/// 最近阅读
///
/// Copied from [recentReads].
@ProviderFor(recentReads)
final recentReadsProvider =
    AutoDisposeFutureProvider<List<ReadingRecord>>.internal(
      recentReads,
      name: r'recentReadsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$recentReadsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecentReadsRef = AutoDisposeFutureProviderRef<List<ReadingRecord>>;
String _$homeRecommendationsHash() =>
    r'ab1f748bce837914398e2f5806d262357d8fdc3b';

/// 首页推荐诗词 — 分页异步加载
///
/// Copied from [HomeRecommendations].
@ProviderFor(HomeRecommendations)
final homeRecommendationsProvider =
    AutoDisposeAsyncNotifierProvider<HomeRecommendations, List<Poem>>.internal(
      HomeRecommendations.new,
      name: r'homeRecommendationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$homeRecommendationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HomeRecommendations = AutoDisposeAsyncNotifier<List<Poem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
