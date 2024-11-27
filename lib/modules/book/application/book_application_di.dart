import 'package:get_it/get_it.dart';
import 'package:insys_books/modules/book/application/repository/abstract_book_repository.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_command_service.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/application/services/book_command_service.dart';
import 'package:insys_books/modules/book/application/services/book_query_service.dart';

void setupBookApplicationDependencyInjection(GetIt container) {
  container.registerLazySingleton<AbstractBookQueryService>(() =>
      BookQueryService(
          bookRepository: container.get<AbstractBookRepository>()));
  container.registerLazySingleton<AbstractBookCommandService>(() =>
      BookCommandService(
          bookRepository: container.get<AbstractBookRepository>()));
}
