import 'package:insys_books/core/infrastructure/local_db.dart';
import 'package:insys_books/modules/book/infrastructure/dao/abstraction/abstract_book_db_dao.dart';
import 'package:insys_books/modules/book/infrastructure/model/book_db_entity.dart';
import 'package:isar/isar.dart';

class BookDbDao implements AbstractBookDbDao {
  final LocalDb _localDb;

  BookDbDao({required LocalDb localDb}) : _localDb = localDb;

  @override
  Future<bool> bookExistsByName(String bookName) async {
    return await _localDb.isar.bookDbEntitys
            .filter()
            .titleMatches('*$bookName*', caseSensitive: false)
            .count() >
        0;
  }

  @override
  Future<bool> bookExistsById(String bookId) async {
    return await _localDb.isar.bookDbEntitys
            .filter()
            .idEqualTo(bookId, caseSensitive: false)
            .count() >
        0;
  }

  @override
  Future<List<BookDbEntity>> getBooksByName(String bookName) async {
    return await _localDb.isar.bookDbEntitys
        .filter()
        .titleMatches('*$bookName*', caseSensitive: false)
        .findAll();
  }

  @override
  Future<void> insertOrUpdateBook(BookDbEntity book) async {
    await _localDb.isar.writeTxn(() async {
      await _localDb.isar.bookDbEntitys.put(book);
    });
  }

  @override
  Future<void> updateBook(BookDbEntity book) async {
    await _localDb.isar.writeTxn(() async {
      await _localDb.isar.bookDbEntitys.putById(book);
    });
  }

  @override
  Future<List<BookDbEntity>> getAllBooks({int? limit}) async {
    var query = _localDb.isar.bookDbEntitys.where();
    if (limit != null) {
      return (await query.limit(limit).findAll()).toList();
    }
    return (await query.findAll()).toList();
  }

  @override
  Future<void> insertList(List<BookDbEntity> books) async {
    await _localDb.isar.writeTxn(() async {
      await _localDb.isar.bookDbEntitys.putAllById(books);
    });
  }

  @override
  Future<BookDbEntity?> getBookById(String id) async {
    return await _localDb.isar.bookDbEntitys.filter().idEqualTo(id).findFirst();
  }

  @override
  Future<List<BookDbEntity>> getAllBooksByIds(List<String> ids) async {
    return (await _localDb.isar.bookDbEntitys.getAllById(ids))
        .nonNulls
        .toList();
  }

  @override
  Future<void> deleteById(String id) async {
    try {
      var book = await getBookById(id);
      if (book == null) {
        return;
      }
      book.deleted = true;
      await _localDb.isar.writeTxn(() async {
        await _localDb.isar.bookDbEntitys.putById(book);
      });
    } catch (e) {
      var x = 2;
    }
  }
}
