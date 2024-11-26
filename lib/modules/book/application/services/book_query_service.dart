import 'package:insys_books/modules/book/application/abstract_book_repository.dart';
import 'package:insys_books/modules/book/application/services/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/domain/book.dart';

class BookQueryService implements AbstractBookQueryService {
  final AbstractBookRepository _bookRepository;

  BookQueryService({required AbstractBookRepository bookRepository})
      : _bookRepository = bookRepository;

  @override
  Future<Book?> getBookByName(String name) async {
    return await _bookRepository.getBookByName(name);
  }

  @override
  Future<List<Book>> getAllLocalBooks() async {
    return await _bookRepository.getAllLocalBooks();
  }
}
