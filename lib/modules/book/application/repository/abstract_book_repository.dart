import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookRepository {
  Future<bool> bookExistsById(String id);
  Future<List<Book>> getAllBooks({int? limit});
  Future<List<Book>> getBooksByName(String name);
  Future<Book?> getBookById(String id);
  Future<bool> createBook(Book book);
  Future<bool> updateBook(Book book);
  Future<bool> deleteBook(String id);
}
