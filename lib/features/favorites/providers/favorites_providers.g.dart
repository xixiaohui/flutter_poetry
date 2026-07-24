// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesListNotifierHash() =>
    r'4c6b64df77603b37e368e6ee2ee653ac25affb61';

/// 收藏列表 — 先渲染空 UI，后台静默加载
///
/// Copied from [FavoritesListNotifier].
@ProviderFor(FavoritesListNotifier)
final favoritesListNotifierProvider =
    AutoDisposeNotifierProvider<
      FavoritesListNotifier,
      List<FavoriteItem>?
    >.internal(
      FavoritesListNotifier.new,
      name: r'favoritesListNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoritesListNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FavoritesListNotifier = AutoDisposeNotifier<List<FavoriteItem>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
