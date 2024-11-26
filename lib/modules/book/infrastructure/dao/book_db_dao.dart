import 'package:insys_books/core/common/local_db.dart';
import 'package:insys_books/modules/book/infrastructure/dao/abstract_book_db_dao.dart';

class BookDbDao implements AbstractBookDbDao {
  final LocalDb _localDb;

  BookDbDao({required LocalDb localDb}) : _localDb = localDb;
}
