import 'package:insys_books/modules/book/application/model/create_book_dto.dart';
import 'package:insys_books/modules/book/application/model/update_book_dto.dart';

abstract interface class AbstractBookCommandService {
  void createBook(CreateBookDto createBookDto);
  void updateBook(String id, UpdateBookDto updateBookDto);
}
