import 'package:insys_books/modules/book/application/model/create_book_dto.dart';
import 'package:insys_books/modules/book/application/model/update_book_dto.dart';
import 'package:insys_books/modules/book/application/repository/abstract_book_repository.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_command_service.dart';
import 'package:insys_books/modules/book/domain/book.dart';

class BookCommandService implements AbstractBookCommandService {
  final AbstractBookRepository _bookRepository;

  BookCommandService({required AbstractBookRepository bookRepository})
      : _bookRepository = bookRepository;

  @override
  Future<bool> createBook(CreateBookDto createBookDto) async {
    var existingBook = await _bookRepository.bookExistsById(createBookDto.id);
    if (existingBook) {
      return false;
    }
    var book = Book(
        id: createBookDto.id,
        title: createBookDto.title,
        authorName: createBookDto.authorName,
        publicationYear: createBookDto.publicationDate,
        imagePath: "");
    return await _bookRepository.createBook(book);
  }

  @override
  Future<bool> deleteBook(String id) async {
    var existingBook = await _bookRepository.bookExistsById(id);
    if (!existingBook) {
      return false;
    }
    return await _bookRepository.deleteBook(id);
  }

  @override
  Future<bool> updateBook(String id, UpdateBookDto updateBookDto) async {
    var existingBook = await _bookRepository.bookExistsById(id);
    if (!existingBook) {
      return false;
    }
    var bookToUpdate = Book(
        id: id,
        title: updateBookDto.title,
        authorName: updateBookDto.authorName,
        publicationYear: updateBookDto.publicationYear,
        imagePath: "");
    return await _bookRepository.updateBook(bookToUpdate);
  }
}
