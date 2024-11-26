import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/infrastructure/dao/abstract_book_web_api_dao.dart';

import '../../../../core/common/http_client.dart';

class BookWebApiDao implements AbstractBookWebApiDao {
  final HttpClient _httpClient;

  BookWebApiDao({required HttpClient httpClient}) : _httpClient = httpClient;

  @override
  Future<Book?> getBooksByName(String name) async {
    var response = await _httpClient.dio
        .get("/volumes?q=$name&key=${_httpClient.googleApiKey}");
    if (response.statusCode == 200) {
      //TODO czy brać tylko pierwszy element?
      final data = response.data["items"]?[0];
      // if (data is List) {
      //   final books = data.where((element) => element != null).map((item) {
      //     try {
      //       return Book.fromJson(item as Map<String, dynamic>);
      //     } catch (error) {
      //       //TODO add loggs
      //       return null;
      //     }
      //   });

      //   return books.nonNulls.toList();
      // } else {
      //   //TODO add loggs
      //   return [];
      // }
      try {
        return Book.fromJson(data as Map<String, dynamic>);
      } catch (error) {
        //TODO add loggs
        return null;
      }
    } else {
      //TODO add loggs

      return null;
    }
  }
}
