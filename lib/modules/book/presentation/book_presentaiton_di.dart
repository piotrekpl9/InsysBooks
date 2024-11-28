import 'package:get_it/get_it.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_command_service.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';

void setupBookPresentationDependencyInjection(GetIt container) {
  container.registerLazySingleton<BookBloc>(() => BookBloc(
      bookQueryService: container.get<AbstractBookQueryService>(),
      bookCommandService: container.get<AbstractBookCommandService>()));
}
