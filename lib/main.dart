import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/core/di/di_container.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_command_service.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/screens/add_book/add_book_screen.dart';
import 'package:insys_books/modules/book/presentation/screens/home/book_home_screen.dart';
import 'package:insys_books/modules/book/presentation/screens/edit_book/edit_book_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await DiContainer.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4ac0d1)),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

var bookBloc = BookBloc(
  bookQueryService: DiContainer.container.get<AbstractBookQueryService>(),
  bookCommandService: DiContainer.container.get<AbstractBookCommandService>(),
);
final _router = GoRouter(
  initialLocation: BookHomeScreen.path,
  routes: [
    GoRoute(
      path: BookHomeScreen.path,
      builder: (context, state) => BlocProvider.value(
        value: bookBloc,
        child: const BookHomeScreen(),
      ),
    ),
    GoRoute(
      path: AddBookScreen.path,
      builder: (context, state) => BlocProvider.value(
        value: bookBloc,
        child: const AddBookScreen(),
      ),
    ),
    GoRoute(
      path: EditBookScreen.path,
      builder: (context, state) => BlocProvider.value(
        value: bookBloc,
        child: const EditBookScreen(),
      ),
    ),
  ],
);
