import 'package:get_it/get_it.dart';
import 'package:insys_books/core/common/http_client.dart';
import 'package:insys_books/core/common/local_db.dart';

void setupCoreDependencyInjection(GetIt container) {
  var db = LocalDb();
  db.init();
  container.registerLazySingleton<LocalDb>(
    () => db,
  );
  container.registerLazySingleton<HttpClient>(
    () => HttpClient(),
  );
}
