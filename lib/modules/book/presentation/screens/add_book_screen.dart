import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/home/book_bloc.dart';

class AddBookScreen extends StatefulWidget {
  static String path = "/add";
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _publicationYearController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _publicationYearController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookBloc, BookState>(
      listener: (context, state) {
        if (state.status == BookStateStatus.actionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfuly added book")));
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add book"),
        ),
        body: Form(
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
                      CreateBookButtonClickedEvent(
                        author: _authorController.text,
                        title: _titleController.text,
                        publicationYear:
                            int.parse(_publicationYearController.text),
                      ),
                    );
                  }
                },
                child: const Text("Wypisz ksiąki"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
