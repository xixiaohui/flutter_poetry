import '../api/gateway_api_client.dart';
import '../models/api_models.dart';
import '../models/author.dart';
import '../models/dynasty.dart';
import '../models/paginated_response.dart';
import '../../core/constants/api_constants.dart';

/// 作者数据服务
final class AuthorService {
  final GatewayApiClient _api = GatewayApiClient();

  /// Convert flat HomeAuthor to nested Author model.
  /// Note: HomeAuthor.poemCount is not mapped as the Author model currently
  /// does not have a poemCount field.
  Author _homeAuthorToAuthor(HomeAuthor ha) => Author(
        id: ha.id.toString(),
        name: ha.name,
        dynasty: Dynasty(id: '', name: ha.dynasty),
        biography: ha.description,
      );

  Future<PaginatedResponse<Author>> getAuthors({
    int page = 1,
    int pageSize = ApiConstants.defaultPageSize,
  }) async {
    final result = await _api.getAuthors(page: page, pageSize: pageSize);

    return PaginatedResponse(
      data: result.data.map(_homeAuthorToAuthor).toList(),
      total: result.total,
      page: result.page,
      pageSize: result.pageSize,
      hasMore: result.hasMore,
    );
  }

  /// 获取作者详情
  Future<Author> getAuthorById(int id) async {
    final ha = await _api.getAuthorById(id);
    return _homeAuthorToAuthor(ha);
  }
}
