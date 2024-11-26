import 'package:flutter/material.dart';
import 'package:insys_books/core/di/di_container.dart';
import 'package:insys_books/modules/book/application/services/abstract_book_query_service.dart';

class BookHome extends StatelessWidget {
  const BookHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book home"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              var service =
                  DiContainer.container.get<AbstractBookQueryService>();
              var x = await service.getBooksByName("python programming");
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(x.first.name)));
            },
            child: Text("Wypisz ksiąki")),
      ),
    );
  }
}
