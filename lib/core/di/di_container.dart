import 'package:get_it/get_it.dart';
import 'package:insys_books/modules/book/book_di.dart';

class DiContainer {
  static final GetIt _getIt = GetIt.instance;

  static void init() {
    setupBookDependencyInjection(_getIt);
  }

  static GetIt get container => _getIt;
}
