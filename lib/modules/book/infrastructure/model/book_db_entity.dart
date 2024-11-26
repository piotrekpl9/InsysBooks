import 'package:isar/isar.dart';
part 'book_db_entity.g.dart';

@collection
class BookDbEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String isbn;

  String name;
  String authorFullName;
  DateTime releaseDate;
  String imagePath;

  BookDbEntity({
    required this.id,
    required this.isbn,
    required this.name,
    required this.authorFullName,
    required this.releaseDate,
    required this.imagePath,
  });
}
