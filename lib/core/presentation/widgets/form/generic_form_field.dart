import 'package:flutter/material.dart';
import 'package:insys_books/core/presentation/consts/app_input_decorations.dart';

class GenericFormField extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool? enableInteractiveSelection;
  final String? label;
  final Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onFieldSubmitted;
  const GenericFormField({
    super.key,
    required this.controller,
    this.validator,
    this.enableInteractiveSelection,
    this.label,
    this.onTapOutside,
    this.keyboardType,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  State<GenericFormField> createState() => GenericFormFieldState();
}

class GenericFormFieldState extends State<GenericFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.keyboardType,
      enableInteractiveSelection: widget.enableInteractiveSelection ?? true,
      decoration: AppInputDecorations.genericInputDecoration
          .copyWith(labelText: widget.label),
      onTapOutside: widget.onTapOutside,
      controller: widget.controller,
      validator: widget.validator,
    );
  }
}
