import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insys_books/core/presentation/widgets/form/generic_form_field.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/screens/home/widgets/filter_form/cancel_search_button.dart';
import 'package:insys_books/modules/book/presentation/screens/home/widgets/filter_form/search_button.dart';

class SearchForm extends StatefulWidget {
  final String? filter;
  const SearchForm({super.key, this.filter});

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.filter);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GenericFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Field must be filled";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: state.filter == null
                    ? SearchButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            FocusScope.of(context).unfocus();
                            context.read<BookBloc>().add(
                                FilterBookButtonClickedEvent(
                                    _nameController.text));
                          }
                        },
                      )
                    : CancelSearchButton(
                        onPressed: () async {
                          _nameController.text = "";
                          FocusScope.of(context).unfocus();
                          context
                              .read<BookBloc>()
                              .add(const RemoveFilterBookButtonClickedEvent());
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
