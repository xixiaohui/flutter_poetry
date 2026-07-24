import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/api_models.dart';
import '../../../data/models/poem.dart';
import '../../../data/repositories/ai_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/favorites_repository.dart';
import '../../../data/repositories/poem_repository.dart';

part 'poem_detail_providers.g.dart';

/// 诗词详情
@riverpod
Future<Poem> poemDetail(PoemDetailRef ref, String poemId) async {
  return ref.read(poemRepositoryProvider).getPoemById(int.parse(poemId));
}

/// 收藏状态 + 切换 (server-side via FavoritesRepository)
@riverpod
class PoemFavorite extends _$PoemFavorite {
  @override
  Future<bool> build(String poemId) async {
    // Check server-side favorites first
    final favState = ref.watch(favoritesRepositoryProvider);
    final poemIdInt = int.parse(poemId);
    if (favState.valueOrNull?.any((f) => f.poemId == poemIdInt) ?? false) {
      return true;
    }
    // Fall back to local Isar
    return ref.read(poemRepositoryProvider).isFavorited(poemId);
  }

  Future<void> toggle(Poem poem) async {
    final auth = ref.read(authRepositoryProvider);
    if (auth.valueOrNull == null) return;

    final favRepo = ref.read(favoritesRepositoryProvider.notifier);
    final poemIdInt = int.parse(poem.id);
    final isFav = favRepo.isFavorited(poemIdInt);

    if (isFav) {
      await favRepo.removeFavorite(poemIdInt);
    } else {
      await favRepo.addFavorite(
        poemId: poemIdInt,
        poemTitle: poem.title,
        poemAuthor: poem.author.name,
        poemDynasty: poem.dynasty.name,
      );
    }
    ref.invalidateSelf();
  }
}

/// AI 赏析 — 懒触发，返回结构化 AIAnalysisData
@riverpod
Future<AIAnalysisData> aiAppreciation(AiAppreciationRef ref, String poemId) async {
  final poem = await ref.read(poemDetailProvider(poemId).future);
  return ref.read(aiRepositoryProvider).analyzePoem(
    title: poem.title,
    content: poem.content,
    author: poem.author.name,
    dynasty: poem.dynasty.name,
  );
}

/// AI 翻译 — 接收 content + targetLang，返回 AITranslation
@riverpod
Future<AITranslation> aiTranslation(
  AiTranslationRef ref,
  ({String content, String targetLang}) params,
) async {
  return ref.read(aiRepositoryProvider).translatePoem(
    content: params.content,
    targetLang: params.targetLang,
  );
}

/// 相关推荐
@riverpod
Future<List<Poem>> relatedPoems(RelatedPoemsRef ref, String poemId) async {
  final poem = await ref.read(poemDetailProvider(poemId).future);
  final result = await ref.read(poemRepositoryProvider).getPoems(
    type: poem.category.name,
    pageSize: 6,
  );
  return result.data.where((p) => p.id != poemId).take(5).toList();
}
