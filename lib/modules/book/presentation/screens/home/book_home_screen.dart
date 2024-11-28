import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/core/presentation/consts/app_strings.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/screens/add_book/add_book_screen.dart';
import 'package:insys_books/modules/book/presentation/screens/home/widgets/list/add_book_floating_button.dart';
import 'package:insys_books/modules/book/presentation/screens/home/widgets/list/books_list.dart';
import 'package:insys_books/modules/book/presentation/screens/home/widgets/filter_form/filter_form.dart';
import 'package:insys_books/modules/book/presentation/widgets/book_scaffold.dart';

class BookHomeScreen extends StatefulWidget {
  static String path = "/";
  const BookHomeScreen({super.key});

  @override
  State<BookHomeScreen> createState() => _BookHomeScreenState();
}

class _BookHomeScreenState extends State<BookHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BookScaffold(
      title: AppStrings.booksHomeTitle,
      floatingActionButton: AddBookFloatingButton(
        onPressed: () {
          context.push(AddBookScreen.path);
        },
      ),
      body: BlocConsumer<BookBloc, BookState>(
        listener: (context, state) {
          if (state.status == BookStateStatus.actionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.actionFailureMessage)));
          }
        },
        builder: (context, state) {
          Widget? bottomWidget;
          if (state.status == BookStateStatus.loading) {
            bottomWidget = const Center(child: CircularProgressIndicator());
          } else if (state.status != BookStateStatus.loading &&
              state.books.isEmpty) {
            bottomWidget = const Center(child: Text(AppStrings.noBooksMessage));
          } else {
            bottomWidget = BooksList(books: state.books);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              FilterForm(
                filter: state.filter,
              ),
              Expanded(
                child: bottomWidget,
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          );
        },
      ),
    );
  }
}
