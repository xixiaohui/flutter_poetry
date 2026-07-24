// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poem_detail_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$poemDetailHash() => r'0eb35ee47064acd369744b99d2ce181cdb947933';

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

/// 诗词详情
///
/// Copied from [poemDetail].
@ProviderFor(poemDetail)
const poemDetailProvider = PoemDetailFamily();

/// 诗词详情
///
/// Copied from [poemDetail].
class PoemDetailFamily extends Family<AsyncValue<Poem>> {
  /// 诗词详情
  ///
  /// Copied from [poemDetail].
  const PoemDetailFamily();

  /// 诗词详情
  ///
  /// Copied from [poemDetail].
  PoemDetailProvider call(String poemId) {
    return PoemDetailProvider(poemId);
  }

  @override
  PoemDetailProvider getProviderOverride(
    covariant PoemDetailProvider provider,
  ) {
    return call(provider.poemId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'poemDetailProvider';
}

/// 诗词详情
///
/// Copied from [poemDetail].
class PoemDetailProvider extends AutoDisposeFutureProvider<Poem> {
  /// 诗词详情
  ///
  /// Copied from [poemDetail].
  PoemDetailProvider(String poemId)
    : this._internal(
        (ref) => poemDetail(ref as PoemDetailRef, poemId),
        from: poemDetailProvider,
        name: r'poemDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$poemDetailHash,
        dependencies: PoemDetailFamily._dependencies,
        allTransitiveDependencies: PoemDetailFamily._allTransitiveDependencies,
        poemId: poemId,
      );

  PoemDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poemId,
  }) : super.internal();

  final String poemId;

  @override
  Override overrideWith(
    FutureOr<Poem> Function(PoemDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PoemDetailProvider._internal(
        (ref) => create(ref as PoemDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poemId: poemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Poem> createElement() {
    return _PoemDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PoemDetailProvider && other.poemId == poemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PoemDetailRef on AutoDisposeFutureProviderRef<Poem> {
  /// The parameter `poemId` of this provider.
  String get poemId;
}

class _PoemDetailProviderElement extends AutoDisposeFutureProviderElement<Poem>
    with PoemDetailRef {
  _PoemDetailProviderElement(super.provider);

  @override
  String get poemId => (origin as PoemDetailProvider).poemId;
}

String _$aiAppreciationHash() => r'ee3fda84460d1d309f2f1705dbf6dbaf1a9e74e3';

/// AI 赏析 — 懒触发，返回结构化 AIAnalysisData
///
/// Copied from [aiAppreciation].
@ProviderFor(aiAppreciation)
const aiAppreciationProvider = AiAppreciationFamily();

/// AI 赏析 — 懒触发，返回结构化 AIAnalysisData
///
/// Copied from [aiAppreciation].
class AiAppreciationFamily extends Family<AsyncValue<AIAnalysisData>> {
  /// AI 赏析 — 懒触发，返回结构化 AIAnalysisData
  ///
  /// Copied from [aiAppreciation].
  const AiAppreciationFamily();

  /// AI 赏析 — 懒触发，返回结构化 AIAnalysisData
  ///
  /// Copied from [aiAppreciation].
  AiAppreciationProvider call(String poemId) {
    return AiAppreciationProvider(poemId);
  }

  @override
  AiAppreciationProvider getProviderOverride(
    covariant AiAppreciationProvider provider,
  ) {
    return call(provider.poemId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'aiAppreciationProvider';
}

/// AI 赏析 — 懒触发，返回结构化 AIAnalysisData
///
/// Copied from [aiAppreciation].
class AiAppreciationProvider extends AutoDisposeFutureProvider<AIAnalysisData> {
  /// AI 赏析 — 懒触发，返回结构化 AIAnalysisData
  ///
  /// Copied from [aiAppreciation].
  AiAppreciationProvider(String poemId)
    : this._internal(
        (ref) => aiAppreciation(ref as AiAppreciationRef, poemId),
        from: aiAppreciationProvider,
        name: r'aiAppreciationProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$aiAppreciationHash,
        dependencies: AiAppreciationFamily._dependencies,
        allTransitiveDependencies:
            AiAppreciationFamily._allTransitiveDependencies,
        poemId: poemId,
      );

  AiAppreciationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poemId,
  }) : super.internal();

  final String poemId;

  @override
  Override overrideWith(
    FutureOr<AIAnalysisData> Function(AiAppreciationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AiAppreciationProvider._internal(
        (ref) => create(ref as AiAppreciationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poemId: poemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AIAnalysisData> createElement() {
    return _AiAppreciationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AiAppreciationProvider && other.poemId == poemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AiAppreciationRef on AutoDisposeFutureProviderRef<AIAnalysisData> {
  /// The parameter `poemId` of this provider.
  String get poemId;
}

class _AiAppreciationProviderElement
    extends AutoDisposeFutureProviderElement<AIAnalysisData>
    with AiAppreciationRef {
  _AiAppreciationProviderElement(super.provider);

  @override
  String get poemId => (origin as AiAppreciationProvider).poemId;
}

String _$aiTranslationHash() => r'bc86acd460869f533bda4f3581f4bec8a5992eeb';

/// AI 翻译 — 接收 content + targetLang，返回 AITranslation
///
/// Copied from [aiTranslation].
@ProviderFor(aiTranslation)
const aiTranslationProvider = AiTranslationFamily();

/// AI 翻译 — 接收 content + targetLang，返回 AITranslation
///
/// Copied from [aiTranslation].
class AiTranslationFamily extends Family<AsyncValue<AITranslation>> {
  /// AI 翻译 — 接收 content + targetLang，返回 AITranslation
  ///
  /// Copied from [aiTranslation].
  const AiTranslationFamily();

  /// AI 翻译 — 接收 content + targetLang，返回 AITranslation
  ///
  /// Copied from [aiTranslation].
  AiTranslationProvider call(({String content, String targetLang}) params) {
    return AiTranslationProvider(params);
  }

  @override
  AiTranslationProvider getProviderOverride(
    covariant AiTranslationProvider provider,
  ) {
    return call(provider.params);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'aiTranslationProvider';
}

/// AI 翻译 — 接收 content + targetLang，返回 AITranslation
///
/// Copied from [aiTranslation].
class AiTranslationProvider extends AutoDisposeFutureProvider<AITranslation> {
  /// AI 翻译 — 接收 content + targetLang，返回 AITranslation
  ///
  /// Copied from [aiTranslation].
  AiTranslationProvider(({String content, String targetLang}) params)
    : this._internal(
        (ref) => aiTranslation(ref as AiTranslationRef, params),
        from: aiTranslationProvider,
        name: r'aiTranslationProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$aiTranslationHash,
        dependencies: AiTranslationFamily._dependencies,
        allTransitiveDependencies:
            AiTranslationFamily._allTransitiveDependencies,
        params: params,
      );

  AiTranslationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final ({String content, String targetLang}) params;

  @override
  Override overrideWith(
    FutureOr<AITranslation> Function(AiTranslationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AiTranslationProvider._internal(
        (ref) => create(ref as AiTranslationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<AITranslation> createElement() {
    return _AiTranslationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AiTranslationProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AiTranslationRef on AutoDisposeFutureProviderRef<AITranslation> {
  /// The parameter `params` of this provider.
  ({String content, String targetLang}) get params;
}

class _AiTranslationProviderElement
    extends AutoDisposeFutureProviderElement<AITranslation>
    with AiTranslationRef {
  _AiTranslationProviderElement(super.provider);

  @override
  ({String content, String targetLang}) get params =>
      (origin as AiTranslationProvider).params;
}

String _$relatedPoemsHash() => r'4d1f801a957eede326c05a8e8e50f6a1305dfb46';

/// 相关推荐
///
/// Copied from [relatedPoems].
@ProviderFor(relatedPoems)
const relatedPoemsProvider = RelatedPoemsFamily();

/// 相关推荐
///
/// Copied from [relatedPoems].
class RelatedPoemsFamily extends Family<AsyncValue<List<Poem>>> {
  /// 相关推荐
  ///
  /// Copied from [relatedPoems].
  const RelatedPoemsFamily();

  /// 相关推荐
  ///
  /// Copied from [relatedPoems].
  RelatedPoemsProvider call(String poemId) {
    return RelatedPoemsProvider(poemId);
  }

  @override
  RelatedPoemsProvider getProviderOverride(
    covariant RelatedPoemsProvider provider,
  ) {
    return call(provider.poemId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'relatedPoemsProvider';
}

/// 相关推荐
///
/// Copied from [relatedPoems].
class RelatedPoemsProvider extends AutoDisposeFutureProvider<List<Poem>> {
  /// 相关推荐
  ///
  /// Copied from [relatedPoems].
  RelatedPoemsProvider(String poemId)
    : this._internal(
        (ref) => relatedPoems(ref as RelatedPoemsRef, poemId),
        from: relatedPoemsProvider,
        name: r'relatedPoemsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$relatedPoemsHash,
        dependencies: RelatedPoemsFamily._dependencies,
        allTransitiveDependencies:
            RelatedPoemsFamily._allTransitiveDependencies,
        poemId: poemId,
      );

  RelatedPoemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poemId,
  }) : super.internal();

  final String poemId;

  @override
  Override overrideWith(
    FutureOr<List<Poem>> Function(RelatedPoemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RelatedPoemsProvider._internal(
        (ref) => create(ref as RelatedPoemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poemId: poemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Poem>> createElement() {
    return _RelatedPoemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RelatedPoemsProvider && other.poemId == poemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RelatedPoemsRef on AutoDisposeFutureProviderRef<List<Poem>> {
  /// The parameter `poemId` of this provider.
  String get poemId;
}

class _RelatedPoemsProviderElement
    extends AutoDisposeFutureProviderElement<List<Poem>>
    with RelatedPoemsRef {
  _RelatedPoemsProviderElement(super.provider);

  @override
  String get poemId => (origin as RelatedPoemsProvider).poemId;
}

String _$poemFavoriteHash() => r'feb691fcbfc5c19e627f9889c9a753f161e3c3bd';

abstract class _$PoemFavorite extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final String poemId;

  FutureOr<bool> build(String poemId);
}

/// 收藏状态 + 切换 (server-side via FavoritesRepository)
///
/// Copied from [PoemFavorite].
@ProviderFor(PoemFavorite)
const poemFavoriteProvider = PoemFavoriteFamily();

/// 收藏状态 + 切换 (server-side via FavoritesRepository)
///
/// Copied from [PoemFavorite].
class PoemFavoriteFamily extends Family<AsyncValue<bool>> {
  /// 收藏状态 + 切换 (server-side via FavoritesRepository)
  ///
  /// Copied from [PoemFavorite].
  const PoemFavoriteFamily();

  /// 收藏状态 + 切换 (server-side via FavoritesRepository)
  ///
  /// Copied from [PoemFavorite].
  PoemFavoriteProvider call(String poemId) {
    return PoemFavoriteProvider(poemId);
  }

  @override
  PoemFavoriteProvider getProviderOverride(
    covariant PoemFavoriteProvider provider,
  ) {
    return call(provider.poemId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'poemFavoriteProvider';
}

/// 收藏状态 + 切换 (server-side via FavoritesRepository)
///
/// Copied from [PoemFavorite].
class PoemFavoriteProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PoemFavorite, bool> {
  /// 收藏状态 + 切换 (server-side via FavoritesRepository)
  ///
  /// Copied from [PoemFavorite].
  PoemFavoriteProvider(String poemId)
    : this._internal(
        () => PoemFavorite()..poemId = poemId,
        from: poemFavoriteProvider,
        name: r'poemFavoriteProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$poemFavoriteHash,
        dependencies: PoemFavoriteFamily._dependencies,
        allTransitiveDependencies:
            PoemFavoriteFamily._allTransitiveDependencies,
        poemId: poemId,
      );

  PoemFavoriteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.poemId,
  }) : super.internal();

  final String poemId;

  @override
  FutureOr<bool> runNotifierBuild(covariant PoemFavorite notifier) {
    return notifier.build(poemId);
  }

  @override
  Override overrideWith(PoemFavorite Function() create) {
    return ProviderOverride(
      origin: this,
      override: PoemFavoriteProvider._internal(
        () => create()..poemId = poemId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        poemId: poemId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PoemFavorite, bool> createElement() {
    return _PoemFavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PoemFavoriteProvider && other.poemId == poemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, poemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PoemFavoriteRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `poemId` of this provider.
  String get poemId;
}

class _PoemFavoriteProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PoemFavorite, bool>
    with PoemFavoriteRef {
  _PoemFavoriteProviderElement(super.provider);

  @override
  String get poemId => (origin as PoemFavoriteProvider).poemId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
