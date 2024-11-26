import 'package:insys_books/core/common/local_db.dart';
import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/infrastructure/dao/abstract_book_db_dao.dart';
import 'package:insys_books/modules/book/infrastructure/model/book_db_entity.dart';
import 'package:insys_books/modules/book/infrastructure/utils/book_entity_mapper.dart';
import 'package:isar/isar.dart';

class BookDbDao implements AbstractBookDbDao {
  final LocalDb _localDb;

  BookDbDao({required LocalDb localDb}) : _localDb = localDb;

  @override
  Future<bool> bookExistsByName(String bookName) async {
    //TODO tu cięzki przypadek, przykład harry potter
    return await _localDb.isar.bookDbEntitys
            .filter()
            .nameMatches('*$bookName*', caseSensitive: false)
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
  Future<Book?> getBookByName(String bookName) async {
    var res = (await _localDb.isar.bookDbEntitys
        .filter()
        .nameMatches(bookName, caseSensitive: false)
        .findFirst());
    return res != null ? BookEntityMapper.fromDbEntity(res) : null;
  }

  @override
  Future<void> insertOrUpdateBook(Book book) async {
    await _localDb.isar.writeTxn(() async {
      await _localDb.isar.bookDbEntitys.put(BookEntityMapper.toDbEntity(book));
    });
  }

  @override
  Future<List<Book>> getAllLocalBooks() async {
    var res = (await _localDb.isar.bookDbEntitys.where().findAll());
    return res.map((e) => BookEntityMapper.fromDbEntity(e)).toList();
  }
}
