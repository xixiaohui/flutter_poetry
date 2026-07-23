// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiChatHash() => r'51a963032b75dc3c893a50d7d4df989ee16719f2';

/// AI 问答状态 — 消息列表
///
/// Copied from [AiChat].
@ProviderFor(AiChat)
final aiChatProvider =
    AutoDisposeNotifierProvider<
      AiChat,
      List<({bool isUser, String text})>
    >.internal(
      AiChat.new,
      name: r'aiChatProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$aiChatHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AiChat = AutoDisposeNotifier<List<({bool isUser, String text})>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
