import 'package:insys_books/modules/book/application/model/create_book_dto.dart';
import 'package:insys_books/modules/book/application/model/update_book_dto.dart';

abstract interface class AbstractBookCommandService {
  Future createBook(CreateBookDto createBookDto);
  Future updateBook(String id, UpdateBookDto updateBookDto);
  Future deleteBook(String id);
}
