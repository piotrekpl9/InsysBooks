import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  const BookScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4ac0d1),
        title: Text(
          title,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: floatingActionButton,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: body,
      ),
    );
  }
}
