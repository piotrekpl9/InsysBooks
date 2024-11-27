import 'package:insys_books/modules/book/application/repository/abstract_book_repository.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/domain/book.dart';

class BookQueryService implements AbstractBookQueryService {
  final AbstractBookRepository _bookRepository;

  BookQueryService({required AbstractBookRepository bookRepository})
      : _bookRepository = bookRepository;

  @override
  Future<List<Book>> getBooksByName(String name) async {
    //TODO moze ustawiać deleted = false kiedy pobieramy ksiąki po nazwie????
    return await _bookRepository.getBooksByName(name);
  }

  @override
  Future<List<Book>> getAllBooks({int? limit}) async {
    return await _bookRepository.getAllBooks(limit: limit);
  }

  @override
  Future<Book?> getBookById(String id) async {
    return await _bookRepository.getBookById(id);
  }
}
