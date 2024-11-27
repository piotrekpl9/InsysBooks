import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/infrastructure/model/book_db_entity.dart';

class BookEntityMapper {
  static Book fromDbEntity(BookDbEntity entity) {
    return Book(
      id: entity.id,
      title: entity.title,
      authorName: entity.authorFullName,
      publicationYear: entity.publicationYear,
      imagePath: entity.imagePath,
    );
  }

  static BookDbEntity toDbEntity(Book book, {bool? deleted}) {
    return BookDbEntity(
        id: book.id,
        title: book.title,
        authorFullName: book.authorName,
        publicationYear: book.publicationYear,
        imagePath: book.imagePath,
        deleted: deleted ?? false);
  }
}
