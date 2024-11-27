import 'package:insys_books/modules/book/infrastructure/model/book_db_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalDb {
  late Isar isar;

  Future init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        BookDbEntitySchema,
      ],
      directory: dir.path,
    );
  }
}
