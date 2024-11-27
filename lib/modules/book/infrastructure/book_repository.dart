import 'package:insys_books/modules/book/application/repository/abstract_book_repository.dart';
import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/infrastructure/dao/abstraction/abstract_book_db_dao.dart';
import 'package:insys_books/modules/book/infrastructure/dao/abstraction/abstract_book_web_api_dao.dart';
import 'package:insys_books/modules/book/infrastructure/dao/book_db_dao.dart';
import 'package:insys_books/modules/book/infrastructure/dao/book_web_api_dao.dart';
import 'package:insys_books/modules/book/infrastructure/utils/book_entity_mapper.dart';

class BookRepository implements AbstractBookRepository {
  final AbstractBookWebApiDao _webApiDao;
  final AbstractBookDbDao _dbDao;

  BookRepository({required BookWebApiDao webApiDao, required BookDbDao dbDao})
      : _webApiDao = webApiDao,
        _dbDao = dbDao;

  @override
  Future<List<Book>> getBooksByName(String name) async {
    var unmappedLocalBooks = (await _dbDao.getBooksByName(name)).toList();

    final apiBooks = await _webApiDao.getBooksByName(name);
    apiBooks.removeWhere(
      (element) => unmappedLocalBooks.any(
        (localElement) => localElement.id == element.id && localElement.deleted,
      ),
    );
    unmappedLocalBooks.removeWhere(
      (element) => element.deleted,
    );

    var localbooks = unmappedLocalBooks.map(BookEntityMapper.fromDbEntity);
    var newBooks = apiBooks
        .where(
          (element) => !localbooks.contains(element),
        )
        .toList();
    var newBooksIds = newBooks
        .map(
          (e) => e.id,
        )
        .toList();

    var matchingDbBooks = (await _dbDao.getAllBooksByIds(newBooksIds))
        .map(BookEntityMapper.fromDbEntity)
        .toList();
    var booksToCache = newBooks
        .where(
          (element) => !matchingDbBooks.contains(element),
        )
        .toList();

    if (booksToCache.isNotEmpty) {
      await _dbDao
          .insertList(booksToCache.map(BookEntityMapper.toDbEntity).toList());
    }
    var res = [...localbooks, ...newBooks];
    return res;
  }

  @override
  Future createBook(Book book) async {
    await _dbDao.insertOrUpdateBook(BookEntityMapper.toDbEntity(book));
  }

  @override
  Future<List<Book>> getAllBooks({int? limit}) async {
    var unmappedLocalBooks = (await _dbDao.getAllBooks(limit: limit)).toList();

    var apiBooks = await _webApiDao.getAllBooks(limit ?? 10);

    apiBooks.removeWhere(
      (element) => unmappedLocalBooks.any(
        (localElement) => localElement.id == element.id && localElement.deleted,
      ),
    );
    unmappedLocalBooks.removeWhere(
      (element) => element.deleted,
    );

    var localbooks = unmappedLocalBooks.map(BookEntityMapper.fromDbEntity);

    var newBooks = apiBooks
        .where(
          (element) => !localbooks.contains(element),
        )
        .toList();

    if (newBooks.isNotEmpty) {
      await _dbDao
          .insertList(newBooks.map(BookEntityMapper.toDbEntity).toList());
    }

    var res = [...localbooks, ...newBooks];
    return res;
  }

  @override
  Future<Book?> getBookById(String id) async {
    //TODO add caching
    var localBook = await _dbDao.getBookById(id);
    if (localBook == null || localBook.deleted) {
      return null;
    }
    return BookEntityMapper.fromDbEntity(localBook);
  }

  @override
  Future deleteBook(String id) async {
    await _dbDao.deleteById(id);
  }

  @override
  Future updateBook(Book book) async {
    final dbBook = await _dbDao.getBookById(book.id);
    if (dbBook == null) {
      return;
    }
    dbBook.publicationYear = book.publicationYear;
    dbBook.title = book.title;
    dbBook.authorFullName = book.authorName;

    await _dbDao.updateBook(dbBook);
  }

  @override
  Future<bool> bookExistsById(String id) async {
    return await _dbDao.bookExistsById(id);
  }
}
