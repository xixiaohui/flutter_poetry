// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homePageDataHash() => r'cae674f034438fd9559c552e8c5c6e71867224fc';

/// Aggregated home page data — fetches 4 APIs in parallel.
///
/// Copied from [homePageData].
@ProviderFor(homePageData)
final homePageDataProvider =
    AutoDisposeFutureProvider<
      ({
        HomeData home,
        SolarTermData solarTerm,
        AppConfig config,
        ReadingStatsData stats,
      })
    >.internal(
      homePageData,
      name: r'homePageDataProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$homePageDataHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomePageDataRef =
    AutoDisposeFutureProviderRef<
      ({
        HomeData home,
        SolarTermData solarTerm,
        AppConfig config,
        ReadingStatsData stats,
      })
    >;
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
