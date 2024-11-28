import 'package:flutter/material.dart';

class DeleteBookButton extends StatelessWidget {
  final void Function() onPressed;
  const DeleteBookButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Color.fromARGB(255, 254, 116, 107),
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: const Icon(
        Icons.delete,
        color: Color.fromARGB(255, 254, 116, 107),
      ),
    );
  }
}
