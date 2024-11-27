import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookQueryService {
  Future<List<Book>> getBooksByName(String name);
  Future<List<Book>> getAllBooks({int? limit});
  Future<Book?> getBookById(String id);
}
