import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/presentation/bloc/home/book_bloc.dart';

class EditBookForm extends StatefulWidget {
  final Book book;
  const EditBookForm({super.key, required this.book});

  @override
  State<EditBookForm> createState() => _EditBookFormState();
}

class _EditBookFormState extends State<EditBookForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _publicationYearController;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.authorName);
    _publicationYearController = TextEditingController(
      text: widget.book.publicationYear.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _titleController,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Field must be filled";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _authorController,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Field must be filled";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _publicationYearController,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Field must be filled";
              }
              var parseTest = int.tryParse(_publicationYearController.text);
              if (parseTest == null) {
                return "Field must be a number";
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                BlocProvider.of<BookBloc>(context).add(
                  BookEditingFormSubmittedEvent(
                    author: _authorController.text,
                    title: _titleController.text,
                    publicationYear: int.parse(_publicationYearController.text),
                  ),
                );
              }
            },
            child: const Text("Wypisz ksiąki"),
          ),
        ],
      ),
    );
  }
}
