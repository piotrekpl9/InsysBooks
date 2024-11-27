import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookRepository {
  Future<bool> bookExistsById(String id);
  Future<List<Book>> getAllBooks({int? limit});
  Future<List<Book>> getBooksByName(String name);
  Future<Book?> getBookById(String id);
  Future createBook(Book book);
  Future updateBook(Book book);
  Future deleteBook(String id);
}
