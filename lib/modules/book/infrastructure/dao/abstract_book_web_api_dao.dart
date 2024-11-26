import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookWebApiDao {
  Future<Book?> getBooksByName(String name);
}
