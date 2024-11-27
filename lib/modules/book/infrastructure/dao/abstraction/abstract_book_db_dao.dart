import 'package:insys_books/modules/book/infrastructure/model/book_db_entity.dart';

abstract interface class AbstractBookDbDao {
  Future<bool> bookExistsByName(String bookName);
  Future<bool> bookExistsById(String bookId);

  Future<List<BookDbEntity>> getAllBooks({int? limit});
  Future<List<BookDbEntity>> getBooksByName(String bookName);
  Future<List<BookDbEntity>> getAllBooksByIds(List<String> ids);
  Future<BookDbEntity?> getBookById(String id);

  Future<void> insertOrUpdateBook(BookDbEntity book);
  Future<void> updateBook(BookDbEntity book);
  Future<void> insertList(List<BookDbEntity> book);
  Future<void> deleteById(String id);
}
