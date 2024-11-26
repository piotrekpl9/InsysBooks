import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookQueryService {
  Future<List<Book>> getBooksByName(String name);
}
