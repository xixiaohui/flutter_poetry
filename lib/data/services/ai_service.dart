import '../api/gateway_api_client.dart';
import '../models/poem.dart';

/// AI 服务 — 通过 Poetry Gateway 调用 AI
final class AIService {
  final GatewayApiClient _client = GatewayApiClient();

  /// AI 赏析
  ///
  /// 签名保持接收 [Poem] 以兼容上层，内部提取 poemId 调用 Gateway。
  Future<String> analyze(Poem poem) async {
    return _client.analyzePoem(poem.id);
  }

  /// AI 配图 prompt
  ///
  /// 签名保持接收 [Poem] 以兼容上层，内部提取 poemId 调用 Gateway。
  Future<String> generateIllustrationPrompt(Poem poem) async {
    return _client.generateIllustration(poem.id);
  }
}
