import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookWebApiDao {
  Future<List<Book>> getBooksByName(String name);
  Future<List<Book>> getAllBooks(int limit);
}
