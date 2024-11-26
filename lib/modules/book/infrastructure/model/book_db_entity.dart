import 'package:insys_books/core/common/fast_hash.dart';
import 'package:isar/isar.dart';
part 'book_db_entity.g.dart';

@collection
class BookDbEntity {
  Id get isarId => fastHash(id);

  @Index(unique: true)
  String id;

  String name;
  String authorFullName;
  DateTime? releaseDate;
  String? imagePath;

  BookDbEntity({
    required this.id,
    required this.name,
    required this.authorFullName,
    required this.releaseDate,
    required this.imagePath,
  });
}
