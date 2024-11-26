import 'package:insys_books/modules/book/application/abstract_book_repository.dart';
import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/infrastructure/dao/book_db_dao.dart';
import 'package:insys_books/modules/book/infrastructure/dao/book_web_api_dao.dart';

class BookRepository implements AbstractBookRepository {
  final BookWebApiDao _webApiDao;
  final BookDbDao _dbDao;

  BookRepository({required BookWebApiDao webApiDao, required BookDbDao dbDao})
      : _webApiDao = webApiDao,
        _dbDao = dbDao;

  @override
  Future<Book?> getBookByName(String name) async {
    if (await _dbDao.bookExistsByName(name)) {
      final book = await _dbDao.getBookByName(name);
      if (book != null) {
        return book;
      }
    }
    final fetchedBook = await _webApiDao.getBooksByName(name);
    if (fetchedBook == null) {
      //TODO log
      return null;
    }
    if (!(await _dbDao.bookExistsById(fetchedBook.id))) {
      //TODO jak istnieje to jest problem xd
      await _dbDao.insertOrUpdateBook(fetchedBook);
    }
    return fetchedBook;
  }

  @override
  Future createBook(Book book) {
    // TODO: implement createBook
    throw UnimplementedError();
  }

  @override
  Future<List<Book>> getAllLocalBooks() {
    return _dbDao.getAllLocalBooks();
  }
}
