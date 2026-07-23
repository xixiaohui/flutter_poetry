import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/ai_repository.dart';

part 'ai_providers.g.dart';

/// AI 问答状态 — 消息列表
@riverpod
class AiChat extends _$AiChat {
  @override
  List<({bool isUser, String text})> build() => [];

  /// 发送问题并获取回答
  Future<void> send(String question, {String? context}) async {
    state = [...state, (isUser: true, text: question)];
    try {
      final answer = await ref.read(aiRepositoryProvider).askQuestion(
        question: question,
        context: context,
      );
      state = [...state, (isUser: false, text: answer.answer)];
    } catch (_) {
      state = [...state, (isUser: false, text: '抱歉，回答出错了，请稍后重试。')];
    }
  }
}
