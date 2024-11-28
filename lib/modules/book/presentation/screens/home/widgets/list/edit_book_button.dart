import 'package:flutter/material.dart';
import 'package:insys_books/core/presentation/consts/app_colors.dart';

class EditBookButton extends StatelessWidget {
  final void Function() onPressed;
  const EditBookButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: const Icon(
        Icons.edit,
        color: AppColors.primaryTextContrast,
      ),
    );
  }
}
