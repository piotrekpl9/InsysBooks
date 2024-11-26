import 'package:get_it/get_it.dart';
import 'package:insys_books/core/core_di.dart';
import 'package:insys_books/modules/book/book_di.dart';

class DiContainer {
  static final GetIt _getIt = GetIt.instance;

  static void init() {
    setupCoreDependencyInjection(_getIt);
    setupBookDependencyInjection(_getIt);
  }

  static GetIt get container => _getIt;
}
