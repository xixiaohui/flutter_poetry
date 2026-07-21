import '../api/poetry_api_client.dart';
import '../models/author.dart';
import '../models/paginated_response.dart';
import '../../core/constants/api_constants.dart';

/// 作者数据服务
final class AuthorService {
  final PoetryApiClient _api = PoetryApiClient();

  Future<PaginatedResponse<Author>> getAuthors({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    return _api.getAuthors(page: page, pageSize: pageSize);
  }

  /// 获取作者详情
  Future<Author> getAuthorById(String id) async {
    return _api.getAuthorById(id);
  }
}
