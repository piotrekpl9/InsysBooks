import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/core/presentation/consts/app_strings.dart';
import 'package:insys_books/core/presentation/widgets/form/form_input_divider.dart';
import 'package:insys_books/core/presentation/widgets/form/generic_form_field.dart';
import 'package:insys_books/core/presentation/widgets/form/generic_submit_button.dart';
import 'package:insys_books/modules/book/presentation/consts/validation_messages.dart';
import 'package:insys_books/modules/book/presentation/widgets/book_scaffold.dart';

import '../../bloc/book_bloc.dart';

class AddBookScreen extends StatefulWidget {
  static String path = "/add";
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
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
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _publicationYearController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookBloc, BookState>(
      listener: (context, state) {
        if (state.status == BookStateStatus.actionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Successfuly added book")));
          context.pop();
        }
        if (state.status == BookStateStatus.actionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.actionFailureMessage)));
        }
      },
      child: BookScaffold(
        title: AppStrings.addBookTitle,
        body: Form(
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
                  _authorFocusNode.requestFocus();
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
                onFieldSubmitted: (p0) {
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
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<BookBloc>().add(
                          CreateBookButtonClickedEvent(
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
        ),
      ),
    );
  }
}
