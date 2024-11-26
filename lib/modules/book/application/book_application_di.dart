import 'package:get_it/get_it.dart';
import 'package:insys_books/modules/book/application/abstract_book_repository.dart';
import 'package:insys_books/modules/book/application/services/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/application/services/book_query_service.dart';

void setupBookApplicationDependencyInjection(GetIt container) {
  container.registerLazySingleton<AbstractBookQueryService>(() =>
      BookQueryService(
          bookRepository: container.get<AbstractBookRepository>()));
}
