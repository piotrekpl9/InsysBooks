import 'package:flutter/material.dart';
import 'package:insys_books/core/presentation/consts/app_colors.dart';

class SearchButton extends StatelessWidget {
  final void Function() onPressed;
  const SearchButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      onPressed: onPressed,
      child: const Icon(
        Icons.search,
        color: AppColors.primaryTextContrast,
      ),
    );
  }
}
