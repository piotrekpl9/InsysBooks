import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookDbDao {
  Future<bool> bookExistsByName(String bookName);
  Future<bool> bookExistsById(String bookId);

  Future<List<Book>> getAllLocalBooks();
  Future<Book?> getBookByName(String bookName);

  Future<void> insertOrUpdateBook(Book book);
}
