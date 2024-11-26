import 'package:insys_books/modules/book/application/abstract_book_repository.dart';
import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/infrastructure/dao/book_web_api_dao.dart';

class BookRepository implements AbstractBookRepository {
  final BookWebApiDao webApiDao;

  BookRepository({required this.webApiDao});

  @override
  Future<List<Book>> getBooksByName(String name) async {
    return await webApiDao.getBooksByName(name);
  }
}
