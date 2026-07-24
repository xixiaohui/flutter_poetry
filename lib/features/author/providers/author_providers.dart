import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/author.dart';
import '../../../data/models/poem.dart';
import '../../../data/api/search_type.dart';
import '../../../data/repositories/author_repository.dart';
import '../../../data/repositories/poem_repository.dart';

part 'author_providers.g.dart';

/// 作者详情
@riverpod
Future<Author> authorDetail(AuthorDetailRef ref, String authorId) async {
  return ref.read(authorRepositoryProvider).getAuthorById(authorId);
}

/// 作者代表作
@riverpod
Future<List<Poem>> authorMasterpieces(AuthorMasterpiecesRef ref, String authorId) async {
  // 先获取作者信息
  final author = await ref.read(authorDetailProvider(authorId).future);

  // 按作者名搜索诗词
  final result = await ref.read(poemRepositoryProvider).searchPoems(
    query: author.name,
    type: SearchType.author.apiValue,
    page: 1,
  );
  return result.data;
}
