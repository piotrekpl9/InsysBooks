import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insys_books/core/presentation/consts/app_strings.dart';
import 'package:insys_books/core/presentation/widgets/form/form_input_divider.dart';
import 'package:insys_books/core/presentation/widgets/form/generic_form_field.dart';
import 'package:insys_books/core/presentation/widgets/form/generic_submit_button.dart';
import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/consts/validation_messages.dart';

class EditBookForm extends StatefulWidget {
  final Book book;
  const EditBookForm({super.key, required this.book});

  @override
  State<EditBookForm> createState() => _EditBookFormState();
}

class _EditBookFormState extends State<EditBookForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _publicationYearController;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _authorFocusNode = FocusNode();
  final FocusNode _publicationYearFocusNode = FocusNode();

  bool buttonEnabled = false;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.authorName);
    _publicationYearController = TextEditingController(
      text: widget.book.publicationYear.toString(),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _publicationYearController.dispose();

    _titleFocusNode.dispose();
    _authorFocusNode.dispose();
    _publicationYearFocusNode.dispose();
    super.dispose();
  }

  void validateAndEnableButton() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        buttonEnabled = true;
      });
    } else {
      setState(() {
        buttonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GenericFormField(
            label: "Title",
            focusNode: _titleFocusNode,
            controller: _titleController,
            enableInteractiveSelection: false,
            onFieldSubmitted: (p0) {
              validateAndEnableButton();
              _authorFocusNode.requestFocus();
            },
            onTapOutside: (p0) {
              validateAndEnableButton();
            },
            validator: (value) {
              if (value == null) {
                return BookValidationMessages.fieldMustBeFilled;
              }
              if (value.length < 4) {
                return BookValidationMessages.valueMustHaveFourLetters;
              }
              return null;
            },
          ),
          const FormInputDivider(),
          GenericFormField(
            label: "Author",
            controller: _authorController,
            focusNode: _authorFocusNode,
            onTapOutside: (p0) {
              validateAndEnableButton();
            },
            onFieldSubmitted: (p0) {
              validateAndEnableButton();
              _publicationYearFocusNode.requestFocus();
            },
            validator: (value) {
              if (value == null) {
                return BookValidationMessages.fieldMustBeFilled;
              }
              if (value.isEmpty) {
                return BookValidationMessages.fieldMustBeFilled;
              }

              return null;
            },
          ),
          const FormInputDivider(),
          GenericFormField(
            label: "Publication year",
            focusNode: _publicationYearFocusNode,
            controller: _publicationYearController,
            keyboardType: TextInputType.number,
            onTapOutside: (p0) {
              validateAndEnableButton();
            },
            onFieldSubmitted: (p0) {
              validateAndEnableButton();
            },
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return BookValidationMessages.fieldMustBeFilled;
              }
              var parsedInt = int.tryParse(_publicationYearController.text);
              if (parsedInt == null) {
                return BookValidationMessages.valueMustBeANumber;
              }

              if (parsedInt < 1800 || parsedInt > 2024) {
                return BookValidationMessages.yearMustBeInRange;
              }
              return null;
            },
          ),
          const FormInputDivider(),
          GenericSubmitElevatedTextButton(
            enabled: buttonEnabled,
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                context.read<BookBloc>().add(
                      BookEditingFormSubmittedEvent(
                        author: _authorController.text,
                        title: _titleController.text,
                        publicationYear:
                            int.parse(_publicationYearController.text),
                      ),
                    );
              }
            },
            title: AppStrings.submit,
          ),
        ],
      ),
    );
  }
}
