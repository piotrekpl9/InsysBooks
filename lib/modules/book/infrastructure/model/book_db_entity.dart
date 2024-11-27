import 'package:insys_books/core/infrastructure/fast_hash.dart';
import 'package:isar/isar.dart';
part 'book_db_entity.g.dart';

@collection
class BookDbEntity {
  Id get isarId => fastHash(id);

  @Index(unique: true)
  final String id;

  String title;
  String authorFullName;
  int? publicationYear;
  final String? imagePath;
  bool deleted;

  BookDbEntity({
    required this.id,
    required this.title,
    required this.authorFullName,
    required this.publicationYear,
    required this.imagePath,
    required this.deleted,
  });
}
