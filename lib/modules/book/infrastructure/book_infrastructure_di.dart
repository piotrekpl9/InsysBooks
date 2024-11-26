import 'package:get_it/get_it.dart';
import 'package:insys_books/core/common/http_client.dart';
import 'package:insys_books/modules/book/application/abstract_book_repository.dart';
import 'package:insys_books/modules/book/infrastructure/book_repository.dart';
import 'package:insys_books/modules/book/infrastructure/dao/book_web_api_dao.dart';

void setupBookInfrastructureDependencyInjection(GetIt container) {
  container.registerLazySingleton<AbstractBookRepository>(() => BookRepository(
      webApiDao: BookWebApiDao(httpClient: container.get<HttpClient>())));
}
