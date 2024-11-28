import 'package:get_it/get_it.dart';
import 'package:insys_books/modules/book/application/book_application_di.dart';
import 'package:insys_books/modules/book/infrastructure/book_infrastructure_di.dart';
import 'package:insys_books/modules/book/presentation/book_presentaiton_di.dart';

void setupBookDependencyInjection(GetIt container) {
  setupBookInfrastructureDependencyInjection(container);
  setupBookApplicationDependencyInjection(container);
  setupBookPresentationDependencyInjection(container);
}
