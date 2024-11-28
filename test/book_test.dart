import 'package:insys_books/modules/book/application/model/create_book_dto.dart';
import 'package:insys_books/modules/book/application/model/update_book_dto.dart';
import 'package:insys_books/modules/book/application/services/book_command_service.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:insys_books/modules/book/infrastructure/book_repository.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([BookRepository])
void main() {
  late MockBookRepository mockBookRepository;
  late BookCommandService bookCommandService;

  setUp(
    () {
      mockBookRepository = MockBookRepository();
      bookCommandService =
          BookCommandService(bookRepository: mockBookRepository);
    },
  );

  group(
    'books command service',
    () {
      test(
        'create book should return true',
        () async {
          //arrange
          var createBookDto = CreateBookDto(
            title: "title",
            id: "id",
            authorName: "authorName",
            publicationYear: 2000,
          );

          when(mockBookRepository.bookExistsById(any))
              .thenAnswer((_) async => false);
          when(mockBookRepository.createBook(any))
              .thenAnswer((_) async => true);

          //act

          var result = await bookCommandService.createBook(createBookDto);

          //assert
          expect(result, true);
        },
      );

      test(
        'create book should return false when book wiith given Id already exists',
        () async {
          //arrange
          var createBookDto = CreateBookDto(
            title: "title",
            id: "id",
            authorName: "authorName",
            publicationYear: 2000,
          );

          when(mockBookRepository.bookExistsById(any))
              .thenAnswer((_) async => true);
          when(mockBookRepository.createBook(any))
              .thenAnswer((_) async => true);

          //act

          var result = await bookCommandService.createBook(createBookDto);

          //assert
          expect(result, false);
        },
      );

      test(
        'update book should return false when book doesnt exists',
        () async {
          //arrange
          var createBookDto = UpdateBookDto(
            title: "title",
            authorName: "authorName",
            publicationYear: 2000,
          );

          when(mockBookRepository.bookExistsById(any))
              .thenAnswer((_) async => false);
          when(mockBookRepository.updateBook(any))
              .thenAnswer((_) async => true);

          //act

          var result = await bookCommandService.updateBook("id", createBookDto);

          //assert
          expect(result, false);
        },
      );
    },
  );
}
