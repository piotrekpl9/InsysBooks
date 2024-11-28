import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/core/presentation/consts/app_strings.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/screens/edit_book/widgets/form/eidt_book_form.dart';

class EditBookScreen extends StatefulWidget {
  static String path = "/edit";
  const EditBookScreen({super.key});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        context.read<BookBloc>().add(
              const BookEditingScreenLeavedEvent(),
            );
      },
      child: BlocListener<BookBloc, BookState>(
        listener: (context, state) {
          if (state.status == BookStateStatus.actionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Book updated successfuly!")));
            context.pop();
          }
          if (state.status == BookStateStatus.actionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.actionFailureMessage)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit Book"),
          ),
          body: BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state.status == BookStateStatus.bookEditing) {
                return EditBookForm(book: state.editedBook!);
              }
              return const Center(
                child: Text("Book has not been selected"),
              );
            },
          ),
        ),
      ),
    );
  }
}
