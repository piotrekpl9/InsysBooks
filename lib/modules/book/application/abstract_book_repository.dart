import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookRepository {
  // Future<Book?> getBookByKey(String key);
  Future<List<Book>> getBooksByName(String name);
}
