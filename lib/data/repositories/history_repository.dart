import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_models.dart';
import '../services/history_service.dart';
import 'auth_repository.dart';

part 'history_repository.g.dart';

@riverpod
class HistoryRepository extends _$HistoryRepository {
  final HistoryService _service = HistoryService();

  @override
  Future<List<HistoryItem>> build() async {
    final auth = ref.watch(authRepositoryProvider);
    if (!auth.hasValue || auth.value == null) return [];
    try {
      final result = await _service.getHistory();
      return result.records;
    } catch (_) {
      return [];
    }
  }

  /// Record a poem reading (no-op if not logged in).
  Future<void> recordReading({
    required int poemId,
    required String poemTitle,
    String? poemAuthor,
    String? poemDynasty,
  }) async {
    final auth = ref.read(authRepositoryProvider);
    if (auth.valueOrNull == null) return;
    await _service.recordReading(
      poemId: poemId,
      poemTitle: poemTitle,
      poemAuthor: poemAuthor,
      poemDynasty: poemDynasty,
    );
    ref.invalidateSelf();
  }
}
