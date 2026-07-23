import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/api_models.dart';
import '../services/stats_service.dart';

part 'stats_repository.g.dart';

@riverpod
Future<ReadingStatsData> readingStats(ReadingStatsRef ref) async {
  return StatsService().getReadingStats();
}
