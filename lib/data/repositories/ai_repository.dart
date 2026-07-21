import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/poem.dart';
import '../services/ai_service.dart';

part 'ai_repository.g.dart';

@riverpod
AiRepository aiRepository(aiRepositoryRef) => AiRepository();

final class AiRepository {
  final AIService _service = AIService();

  /// 配置 API Key (应在应用启动时调用)
  void configure({required String apiKey}) {
    _service.configure(apiKey: apiKey);
  }

  /// AI 赏析诗词
  Future<String> analyzePoem(Poem poem) async {
    return _service.analyze(poem);
  }

  /// 生成配图 prompt
  Future<String> generateIllustration(Poem poem) async {
    return _service.generateIllustrationPrompt(poem);
  }
}
