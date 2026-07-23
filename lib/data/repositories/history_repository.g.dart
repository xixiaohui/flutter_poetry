// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historyRepositoryHash() => r'3a4051a51f754eedc8d87a4d74218ccc4acf10c2';

/// See also [HistoryRepository].
@ProviderFor(HistoryRepository)
final historyRepositoryProvider =
    AutoDisposeAsyncNotifierProvider<
      HistoryRepository,
      List<HistoryItem>
    >.internal(
      HistoryRepository.new,
      name: r'historyRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$historyRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HistoryRepository = AutoDisposeAsyncNotifier<List<HistoryItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
