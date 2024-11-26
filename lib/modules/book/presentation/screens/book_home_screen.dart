import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insys_books/core/di/di_container.dart';
import 'package:insys_books/modules/book/application/services/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/presentation/bloc/bloc/book_bloc.dart';

class BookHome extends StatefulWidget {
  const BookHome({super.key});

  @override
  State<BookHome> createState() => _BookHomeState();
}

class _BookHomeState extends State<BookHome> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc(
          bookQueryService:
              DiContainer.container.get<AbstractBookQueryService>())
        ..add(const BookHomeScreenEntered()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book home"),
        ),
        body: BlocBuilder<BookBloc, BookState>(
          builder: (context, state) {
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
                            var service = DiContainer.container
                                .get<AbstractBookQueryService>();
                            var x = await service
                                .getBookByName(_nameController.text);

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(x?.name ?? "Nie znaleziono")));
                          }
                        },
                        child: const Text("Wypisz ksiąki"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.books.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(state.books[index].name));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
