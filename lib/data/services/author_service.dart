import '../api/poetry_api_client.dart';
import '../models/author.dart';
import '../models/paginated_response.dart';

/// 作者数据服务
final class AuthorService {
  final PoetryApiClient _api = PoetryApiClient();

  Future<PaginatedResponse<Author>> getAuthors({
    int page = 1,
    int pageSize = 20,
  }) async {
    return _api.getAuthors(page: page, pageSize: pageSize);
  }
}
