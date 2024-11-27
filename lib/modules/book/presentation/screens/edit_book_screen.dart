import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/modules/book/presentation/bloc/home/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/widgets/eidt_book_form.dart';

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
        //TODO sprawdź czy lepiej uywać BlocProvider.of czy context.read
        BlocProvider.of<BookBloc>(context).add(
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
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit Book"),
          ),
          body: BlocBuilder<BookBloc, BookState>(
            bloc: BlocProvider.of<BookBloc>(context),
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
