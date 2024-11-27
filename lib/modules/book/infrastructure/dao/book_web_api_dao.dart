import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/infrastructure/dao/abstraction/abstract_book_web_api_dao.dart';

import '../../../../core/infrastructure/http_client.dart';

class BookWebApiDao implements AbstractBookWebApiDao {
  final HttpClient _httpClient;

  BookWebApiDao({required HttpClient httpClient}) : _httpClient = httpClient;

  @override
  Future<List<Book>> getBooksByName(String name) async {
    var response = await _httpClient.dio
        .get("/volumes?q=$name&key=${_httpClient.googleApiKey}");
    if (response.statusCode == 200) {
      final data = response.data["items"];
      if (data is List) {
        final books = data.where((element) => element != null).map((item) {
          try {
            return Book.fromJson(item as Map<String, dynamic>);
          } catch (error) {
            //TODO add loggs
            return null;
          }
        });

        return books.nonNulls.toList();
      } else {
        //TODO add loggs
        return [];
      }
      // try {
      //   return Book.fromJson(data as Map<String, dynamic>);
      // } catch (error) {
      //   //TODO add loggs
      //   return null;
      // }
    } else {
      //TODO add loggs

      return [];
    }
  }

  @override
  Future<List<Book>> getAllBooks(int limit) async {
    var response = await _httpClient.dio.get(
        "/volumes?q=time&printType=books&maxResults=$limit&key=${_httpClient.googleApiKey}");
    if (response.statusCode == 200) {
      final data = response.data["items"];
      if (data is List) {
        final books = data.where((element) => element != null).map((item) {
          try {
            return Book.fromJson(item as Map<String, dynamic>);
          } catch (error) {
            //TODO add loggs
            return null;
          }
        });

        return books.nonNulls.toList();
      } else {
        //TODO add loggs
        return [];
      }
    }
    return [];
  }
}
