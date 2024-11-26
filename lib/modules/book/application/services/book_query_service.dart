import 'package:insys_books/modules/book/application/abstract_book_repository.dart';
import 'package:insys_books/modules/book/application/services/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/domain/book.dart';

class BookQueryService implements AbstractBookQueryService {
  final AbstractBookRepository _bookRepository;

  BookQueryService({required AbstractBookRepository bookRepository})
      : _bookRepository = bookRepository;

  @override
  Future<List<Book>> getBooksByName(String name) async {
    return await _bookRepository.getBooksByName(name);
  }
}
