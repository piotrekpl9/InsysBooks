import 'package:insys_books/modules/book/domain/book.dart';

abstract interface class AbstractBookRepository {
  Future<List<Book>> getAllLocalBooks();
  Future<Book?> getBookByName(String name);
  Future createBook(Book book);
}
