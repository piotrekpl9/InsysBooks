import 'package:flutter/material.dart';

class GenericFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const GenericFormField({super.key, this.validator, required this.controller});

  @override
  State<GenericFormField> createState() => GenericFormFieldState();
}

class GenericFormFieldState extends State<GenericFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: widget.controller,
      validator: widget.validator,
    );
  }
}
