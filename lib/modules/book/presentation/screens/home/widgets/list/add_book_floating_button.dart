import 'package:flutter/material.dart';
import 'package:insys_books/core/presentation/consts/app_colors.dart';

class AddBookFloatingButton extends StatelessWidget {
  final void Function()? onPressed;
  const AddBookFloatingButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.primary, width: 2)),
      backgroundColor: AppColors.primaryTextContrast,
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        color: AppColors.primary,
      ),
    );
  }
}
