/// Web 平台桩 — 无 Isar 缓存，所有数据直读 API
import '../../core/constants/api_constants.dart';
import '../api/gateway_api_client.dart';
import '../models/api_models.dart';
import '../models/author.dart';
import '../models/dynasty.dart';
import '../models/poem.dart';
import '../models/paginated_response.dart';

final class PoemService {
  final GatewayApiClient _api = GatewayApiClient();

  Future<PaginatedResponse<Poem>> getPoems({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
    String? dynasty,
    String? type,
    String? author,
  }) async {
    final result = await _api.getPoems(page: page, pageSize: pageSize, dynasty: dynasty, type: type, author: author);
    final poems = result.data.map(_apiPoemToPoem).toList();
    return PaginatedResponse(data: poems, total: result.total, page: result.page, pageSize: result.pageSize, hasMore: result.hasMore);
  }

  Future<PaginatedResponse<Poem>> searchPoems({required String query, String? type, int page = 1, int pageSize = ApiConstants.defaultPageSize}) async {
    final result = await _api.search(q: query, type: type, page: page, pageSize: pageSize);
    return PaginatedResponse(data: result.data.map(_apiPoemToPoem).toList(), total: result.total, page: result.page, pageSize: result.pageSize, hasMore: result.hasMore);
  }

  Future<Poem> getRandomPoem({String? author, String? type, String? dynasty, String? char}) async {
    final apiPoem = await _api.getRandomPoem(author: author, type: type, dynasty: dynasty, char: char);
    return _apiPoemToPoem(apiPoem);
  }

  Future<Poem> getPoemById(int id) async {
    final apiPoem = await _api.getPoemById(id);
    return _apiPoemToPoem(apiPoem);
  }

  Future<PaginatedResponse<Poem>> getPoemsByAuthor(String authorName, {int page = 1, int pageSize = 20}) async {
    final result = await _api.getPoems(page: page, pageSize: pageSize, author: authorName);
    return PaginatedResponse(data: result.data.map(_apiPoemToPoem).toList(), total: result.total, page: result.page, pageSize: result.pageSize, hasMore: result.hasMore);
  }

  Poem _apiPoemToPoem(ApiPoem p) => Poem(
    id: p.id.toString(), title: p.title, content: p.content,
    author: AuthorBrief(id: '', name: p.author ?? '', dynasty: Dynasty(id: '', name: p.dynasty ?? '')),
    dynasty: Dynasty(id: '', name: p.dynasty ?? ''), category: PoemCategory.misc,
  );
}
