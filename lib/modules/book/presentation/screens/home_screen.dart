import 'package:flutter/material.dart';

class BookHome extends StatelessWidget {
  const BookHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book home"),
      ),
      body: Center(
        child: Text("Books here"),
      ),
    );
  }
}
