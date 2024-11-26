import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/infrastructure/dao/abstract_book_web_api_dao.dart';

import '../../../../core/common/http_client.dart';

class BookWebApiDao implements AbstractBookWebApiDao {
  final HttpClient _httpClient;

  BookWebApiDao({required HttpClient httpClient}) : _httpClient = httpClient;

  @override
  Future<List<Book>> getBooksByName(String name) async {
    var response =
        await _httpClient.dio.get("/search.json?q=python+programming");
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      final books = data.map((item) => Book.fromJson(item)).toList();
      return books;
    }
    return [];
  }
}
