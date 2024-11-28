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
    try {
      var unmappedLocalBooks = (await _dbDao.getBooksByName(name)).toList();

      final apiBooks = await _webApiDao.getBooksByName(name);

      var newBooks = apiBooks
          .where((element) => !unmappedLocalBooks.any((localElement) =>
              localElement.id == element.id &&
              (localElement.deleted || localElement.edited)))
          .toList();

      unmappedLocalBooks.removeWhere((element) => element.deleted);

      var localbooks = unmappedLocalBooks.map(BookEntityMapper.fromDbEntity);
      var newBooksIds = newBooks.map((e) => e.id).toList();
      var unmappedMatchingDbBooks =
          (await _dbDao.getAllBooksByIds(newBooksIds)).toList();

      var editedBooksIds = unmappedMatchingDbBooks
          .where((element) => element.edited)
          .map((e) => e.id)
          .toSet();

      newBooks.removeWhere(
        (element) => editedBooksIds.contains(element.id),
      );

      var matchingDbBooks =
          unmappedMatchingDbBooks.map(BookEntityMapper.fromDbEntity).toSet();
      var booksToCache = newBooks
          .where((element) => !matchingDbBooks.contains(element))
          .toList();

      if (booksToCache.isNotEmpty) {
        await _dbDao
            .insertList(booksToCache.map(BookEntityMapper.toDbEntity).toList());
      }
      var res = [...localbooks, ...newBooks];
      return res;
    } catch (e) {
      //TODO logowanie
      return [];
    }
  }

  @override
  Future<bool> createBook(Book book) async {
    try {
      await _dbDao.insertOrUpdateBook(BookEntityMapper.toDbEntity(book));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<Book>> getAllBooks({int? limit}) async {
    try {
      var unmappedLocalBooks =
          (await _dbDao.getAllBooks(limit: limit)).toList();

      var apiBooks = await _webApiDao.getAllBooks(limit ?? 10);

      apiBooks.removeWhere(
        (element) => unmappedLocalBooks.any(
          (localElement) =>
              localElement.id == element.id &&
              (localElement.deleted || localElement.edited),
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
    } catch (e) {
      //TODO logowanie
      return [];
    }
  }

  @override
  Future<Book?> getBookById(String id) async {
    //TODO add caching

    try {
      var apiBook = await _webApiDao.getBookById(id);
      final localBook = await _dbDao.getBookById(id);
      if (localBook != null && localBook.deleted) {
        return null;
      }
      if (localBook == null) {
        if (apiBook != null) {
          await _dbDao.insertOrUpdateBook(BookEntityMapper.toDbEntity(apiBook));
          return apiBook;
        }
        return null;
      }

      var localMapped = BookEntityMapper.fromDbEntity(localBook);
      if (localBook.edited) {
        return localMapped;
      }
      if (apiBook != null) {
        if (localMapped != apiBook) {
          localBook.publicationYear = apiBook.publicationYear;
          localBook.title = apiBook.title;
          localBook.authorFullName = apiBook.authorName;
          await _dbDao.updateBook(localBook);
        }
        return apiBook;
      }
    } catch (e) {
      //TODO logowanie

      return null;
    }
  }

  @override
  Future<bool> deleteBook(String id) async {
    try {
      await _dbDao.deleteById(id);
      return true;
    } catch (e) {
      //TODO logowanie
      return false;
    }
  }

  @override
  Future<bool> updateBook(Book book) async {
    try {
      final dbBook = await _dbDao.getBookById(book.id);
      if (dbBook == null) {
        return false;
      }
      dbBook.publicationYear = book.publicationYear;
      dbBook.title = book.title;
      dbBook.authorFullName = book.authorName;
      dbBook.edited = true;

      await _dbDao.updateBook(dbBook);
      return true;
    } catch (e) {
      //TODO logowanie

      return false;
    }
  }

  @override
  Future<bool> bookExistsById(String id) async {
    return await _dbDao.bookExistsById(id);
  }
}
