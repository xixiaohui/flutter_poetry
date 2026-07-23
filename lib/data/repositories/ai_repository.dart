import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_models.dart';
import '../services/ai_service.dart';
part 'ai_repository.g.dart';

@riverpod
AiRepository aiRepository(AiRepositoryRef ref) => AiRepository();

final class AiRepository {
  final AIService _service = AIService();

  Future<AIAnalysisData> analyzePoem({required String title, required String content, String? author, String? dynasty}) =>
      _service.analyzePoem(title: title, content: content, author: author, dynasty: dynasty);

  Future<AIAnswer> askQuestion({required String question, String? context}) =>
      _service.askQuestion(question: question, context: context);

  Future<AITranslation> translatePoem({required String content, String targetLang = 'en'}) =>
      _service.translatePoem(content: content, targetLang: targetLang);
}
