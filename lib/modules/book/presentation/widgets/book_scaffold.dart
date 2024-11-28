import 'package:flutter/material.dart';
import 'package:insys_books/core/presentation/consts/app_colors.dart';
import 'package:insys_books/core/presentation/consts/app_typography_styles.dart';

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
        backgroundColor: AppColors.primary,
        title: Text(
          title,
          style: AppTypographyStyles.screenTitle,
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
