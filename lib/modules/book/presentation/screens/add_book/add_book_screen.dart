import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/core/presentation/consts/app_strings.dart';
import 'package:insys_books/core/presentation/widgets/form/form_input_divider.dart';
import 'package:insys_books/core/presentation/widgets/form/generic_form_field.dart';
import 'package:insys_books/core/presentation/widgets/form/generic_submit_button.dart';
import 'package:insys_books/modules/book/presentation/consts/validation_messages.dart';
import 'package:insys_books/modules/book/presentation/screens/add_book/widgets/form/add_book_form.dart';
import 'package:insys_books/modules/book/presentation/widgets/book_scaffold.dart';

import '../../bloc/book_bloc.dart';

class AddBookScreen extends StatefulWidget {
  static String path = "/add";
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BookBloc, BookState>(
      listener: (context, state) {
        if (state.status == BookStateStatus.actionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfuly added book")));
          context.pop();
        }
        if (state.status == BookStateStatus.actionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.actionFailureMessage)));
        }
      },
      child: const BookScaffold(
        title: AppStrings.addBookTitle,
        body: AddBookForm(),
      ),
    );
  }
}
