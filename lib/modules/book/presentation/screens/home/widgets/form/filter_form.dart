import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';

class FilterForm extends StatefulWidget {
  final String? filter;
  const FilterForm({super.key, this.filter});

  @override
  State<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
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
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  controller: _nameController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Field must be filled";
                    }
                    return null;
                  },
                ),
              ),
              state.filter == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4ac0d1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            BlocProvider.of<BookBloc>(context).add(
                                FilterBookButtonClickedEvent(
                                    _nameController.text));
                          }
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4ac0d1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            _nameController.text = "";
                            BlocProvider.of<BookBloc>(context).add(
                                const RemoveFilterBookButtonClickedEvent());
                          }
                        },
                        child: const Icon(
                          Icons.search_off,
                          color: Colors.white,
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
