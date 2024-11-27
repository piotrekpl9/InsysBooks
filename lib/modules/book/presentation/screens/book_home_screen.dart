import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/modules/book/presentation/bloc/home/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/screens/add_book_screen.dart';
import 'package:insys_books/modules/book/presentation/screens/edit_book_screen.dart';

class BookHomeScreen extends StatefulWidget {
  static String path = "/";
  const BookHomeScreen({super.key});

  @override
  State<BookHomeScreen> createState() => _BookHomeScreenState();
}

class _BookHomeScreenState extends State<BookHomeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book home"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(AddBookScreen.path);
        },
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state.status == BookStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Field must be filled";
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          BlocProvider.of<BookBloc>(context).add(
                              FilterBookButtonClickedEvent(
                                  _nameController.text));
                        }
                      },
                      child: const Text("Wypisz ksiąki"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _nameController.text = "";
                        BlocProvider.of<BookBloc>(context)
                            .add(const BookBlocStarted());
                        //TODO zrobić specjalny event pod reset
                      },
                      child: const Text("Reset"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    var selected = index == _selectedIndex;
                    return ListTile(
                      selected: selected,
                      title: Text(state.books[index].title),
                      trailing: selected
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<BookBloc>(context).add(
                                        EditBookButtonClickedEvent(
                                          book: state.books[index],
                                        ),
                                      );
                                      _selectedIndex = null;
                                      context.push(EditBookScreen.path);
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<BookBloc>(context).add(
                                          DeleteBookButtonClickedEvent(
                                              id: state.books[index].id));
                                      _selectedIndex = null;
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            )
                          : null,
                      onLongPress: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
