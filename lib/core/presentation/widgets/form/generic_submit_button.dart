import 'package:flutter/material.dart';
import 'package:insys_books/core/presentation/consts/app_colors.dart';
import 'package:insys_books/core/presentation/consts/app_typography_styles.dart';

class GenericSubmitElevatedTextButton extends StatelessWidget {
  final void Function() onPressed;
  final bool enabled;
  final String title;
  const GenericSubmitElevatedTextButton(
      {super.key, required this.onPressed, required this.title, bool? enabled})
      : enabled = enabled ?? true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      onPressed: enabled ? onPressed : null,
      child: Text(
        title,
        style: AppTypographyStyles.regular
            .copyWith(color: AppColors.primaryTextContrast),
      ),
    );
  }
}
