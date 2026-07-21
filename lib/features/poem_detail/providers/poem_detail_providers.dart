import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/poem.dart';
import '../../../data/repositories/poem_repository.dart';
import '../../../data/repositories/ai_repository.dart';

part 'poem_detail_providers.g.dart';

/// 诗词详情
@riverpod
Future<Poem> poemDetail(PoemDetailRef ref, String poemId) async {
  return ref.read(poemRepositoryProvider).getPoemById(poemId);
}

/// 收藏状态 + 切换
@riverpod
class PoemFavorite extends _$PoemFavorite {
  @override
  Future<bool> build(String poemId) async {
    return ref.read(poemRepositoryProvider).isFavorited(poemId);
  }

  Future<void> toggle(Poem poem) async {
    final repo = ref.read(poemRepositoryProvider);
    final isFav = await repo.isFavorited(poem.id);
    if (isFav) {
      await repo.removeFavorite(poem.id);
    } else {
      await repo.addFavorite(poem);
    }
    // Invalidate to refresh state
    ref.invalidateSelf();
  }
}

/// AI 赏析 — 懒触发，不在 build 时自动调用
@riverpod
Future<String> aiAppreciation(AiAppreciationRef ref, String poemId) async {
  final poem = await ref.read(poemDetailProvider(poemId).future);
  return ref.read(aiRepositoryProvider).analyzePoem(poem);
}

/// 相关推荐
@riverpod
Future<List<Poem>> relatedPoems(RelatedPoemsRef ref, String poemId) async {
  final poem = await ref.read(poemDetailProvider(poemId).future);
  final result = await ref.read(poemRepositoryProvider).getPoems(
    category: poem.category.name,
    pageSize: 6,
  );
  return result.data.where((p) => p.id != poemId).take(5).toList();
}
