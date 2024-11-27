import 'package:insys_books/modules/book/application/model/create_book_dto.dart';
import 'package:insys_books/modules/book/application/model/update_book_dto.dart';
import 'package:insys_books/modules/book/application/repository/abstract_book_repository.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_command_service.dart';
import 'package:insys_books/modules/book/domain/book.dart';

class BookCommandService implements AbstractBookCommandService {
  final AbstractBookRepository _bookRepository;

  BookCommandService({required AbstractBookRepository bookRepository})
      : _bookRepository = bookRepository;

  //TODO add Either to Future

  @override
  Future createBook(CreateBookDto createBookDto) async {
    var book = Book(
        id: createBookDto.id,
        title: createBookDto.title,
        authorName: createBookDto.authorName,
        publicationYear: createBookDto.publicationDate,
        imagePath: "");
    await _bookRepository.createBook(book);
  }

  @override
  Future deleteBook(String id) async {
    await _bookRepository.deleteBook(id);
  }

  @override
  Future updateBook(String id, UpdateBookDto updateBookDto) async {
    var existingBook = await _bookRepository.getBookById(id);
    if (existingBook == null) {
      return;
    }
    var bookToUpdate = Book(
        id: id,
        title: updateBookDto.title,
        authorName: updateBookDto.authorName,
        publicationYear: updateBookDto.publicationYear,
        imagePath: "");
    await _bookRepository.updateBook(bookToUpdate);
  }
}
