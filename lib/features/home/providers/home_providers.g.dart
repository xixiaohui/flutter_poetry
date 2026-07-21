// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dailyPoemHash() => r'4f5920383bfb2e55db6a468f623420383b71737e';

/// 每日一首
///
/// Copied from [dailyPoem].
@ProviderFor(dailyPoem)
final dailyPoemProvider = AutoDisposeFutureProvider<Poem>.internal(
  dailyPoem,
  name: r'dailyPoemProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyPoemHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DailyPoemRef = AutoDisposeFutureProviderRef<Poem>;
String _$currentSolarTermHash() => r'8d6aa8ccf8b798fe1a52031457d8ab3c0735d864';

/// 当前节气
///
/// Copied from [currentSolarTerm].
@ProviderFor(currentSolarTerm)
final currentSolarTermProvider =
    AutoDisposeProvider<({String name, String description})>.internal(
      currentSolarTerm,
      name: r'currentSolarTermProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentSolarTermHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSolarTermRef =
    AutoDisposeProviderRef<({String name, String description})>;
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
