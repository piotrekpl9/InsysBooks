import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/infrastructure/model/book_db_entity.dart';

class BookEntityMapper {
  static Book fromDbEntity(BookDbEntity entity) {
    return Book(
      id: entity.id,
      name: entity.name,
      authorName: entity.authorFullName,
      releaseDate: entity.releaseDate,
      imagePath: entity.imagePath,
    );
  }

  static BookDbEntity toDbEntity(Book book) {
    return BookDbEntity(
      id: book.id,
      name: book.name,
      authorFullName: book.authorName,
      releaseDate: book.releaseDate,
      imagePath: book.imagePath,
    );
  }
}
