// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoritesRepositoryHash() =>
    r'a59eced4a312018a7402f4cc0d0135cf59fad42f';

/// See also [FavoritesRepository].
@ProviderFor(FavoritesRepository)
final favoritesRepositoryProvider =
    AutoDisposeAsyncNotifierProvider<
      FavoritesRepository,
      List<FavoriteItem>
    >.internal(
      FavoritesRepository.new,
      name: r'favoritesRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$favoritesRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FavoritesRepository = AutoDisposeAsyncNotifier<List<FavoriteItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
