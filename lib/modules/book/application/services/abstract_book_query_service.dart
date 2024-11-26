import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookQueryService {
  Future<Book?> getBookByName(String name);
  Future<List<Book>> getAllLocalBooks();
}
