import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/author.dart';
import '../models/paginated_response.dart';
import '../services/author_service.dart';

part 'author_repository.g.dart';

@riverpod
AuthorRepository authorRepository(authorRepositoryRef) => AuthorRepository();

final class AuthorRepository {
  final AuthorService _service = AuthorService();

  Future<PaginatedResponse<Author>> getAuthors({
    int page = 1,
    int pageSize = 20,
  }) async {
    return _service.getAuthors(page: page, pageSize: pageSize);
  }

  /// 获取作者详情
  Future<Author> getAuthorById(String id) async {
    return _service.getAuthorById(id);
  }
}
