import 'package:get_it/get_it.dart';
import 'package:insys_books/core/infrastructure/http_client.dart';
import 'package:insys_books/core/infrastructure/local_db.dart';

Future setupCoreDependencyInjection(GetIt container) async {
  var db = LocalDb();
  await db.init();
  container.registerLazySingleton<LocalDb>(
    () => db,
  );
  container.registerLazySingleton<HttpClient>(
    () => HttpClient(),
  );
}
