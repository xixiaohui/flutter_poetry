import '../api/gateway_api_client.dart';
import '../models/api_models.dart';

final class AIService {
  final GatewayApiClient _client = GatewayApiClient();

  Future<AIAnalysisData> analyzePoem({required String title, required String content, String? author, String? dynasty}) =>
      _client.analyzePoem(title: title, content: content, author: author, dynasty: dynasty);

  Future<AIAnswer> askQuestion({required String question, String? context}) =>
      _client.askQuestion(question: question, context: context);

  Future<AITranslation> translatePoem({required String content, String targetLang = 'en'}) =>
      _client.translatePoem(content: content, targetLang: targetLang);
}
