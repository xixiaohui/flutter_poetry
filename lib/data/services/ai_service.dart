import '../api/deepseek_api_client.dart';
import '../models/poem.dart';

/// AI 服务 — 统一管理 DeepSeek API 调用
final class AIService {
  final DeepSeekApiClient _client = DeepSeekApiClient();

  /// 设置 API Key
  void configure({required String apiKey}) {
    _client.setApiKey(apiKey);
  }

  /// AI 赏析
  Future<String> analyze(Poem poem) async {
    return _client.analyzePoem(poem);
  }

  /// AI 配图 prompt
  Future<String> generateIllustrationPrompt(Poem poem) async {
    return _client.generateIllustrationPrompt(poem);
  }
}
