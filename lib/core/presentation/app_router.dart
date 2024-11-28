import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/core/common/di/di_container.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/screens/add_book/add_book_screen.dart';
import 'package:insys_books/modules/book/presentation/screens/edit_book/edit_book_screen.dart';
import 'package:insys_books/modules/book/presentation/screens/home/book_home_screen.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        initialLocation: BookHomeScreen.path,
        routes: [
          GoRoute(
            path: BookHomeScreen.path,
            builder: (context, state) => BlocProvider.value(
              value: DiContainer.container
                  .get<BookBloc>(), // Retrieve BookBloc here
              child: const BookHomeScreen(),
            ),
          ),
          GoRoute(
            path: AddBookScreen.path,
            builder: (context, state) => BlocProvider.value(
              value: DiContainer.container.get<BookBloc>(),
              child: const AddBookScreen(),
            ),
          ),
          GoRoute(
            path: EditBookScreen.path,
            builder: (context, state) => BlocProvider.value(
              value: DiContainer.container.get<BookBloc>(),
              child: const EditBookScreen(),
            ),
          ),
        ],
      );
}
