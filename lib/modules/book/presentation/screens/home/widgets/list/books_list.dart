import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/modules/book/domain/book.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/screens/edit_book/edit_book_screen.dart';
import 'package:insys_books/modules/book/presentation/screens/home/widgets/list/books_list_tile.dart';
import 'package:insys_books/modules/book/presentation/screens/home/widgets/list/delete_book_button.dart';
import 'package:insys_books/modules/book/presentation/screens/home/widgets/list/edit_book_button.dart';

class BooksList extends StatefulWidget {
  final List<Book> books;
  const BooksList({super.key, required this.books});

  @override
  State<BooksList> createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          tileMode: TileMode.mirror,
          colors: [
            Colors.white,
            Colors.transparent,
          ],
          stops: [
            0.0,
            0.2,
          ],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: ListView.separated(
        itemCount: widget.books.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        padding: const EdgeInsets.symmetric(vertical: 30),
        itemBuilder: (context, index) {
          var book = widget.books[index];
          var selected = index == _selectedIndex;

          var listTile = BooksListTile(
              onLongPress: () {
                setState(
                  () {
                    if (_selectedIndex == null || index != _selectedIndex) {
                      _selectedIndex = index;
                    } else {
                      _selectedIndex = null;
                    }
                  },
                );
              },
              book: book,
              selected: selected);
          if (selected) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                listTile,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: EditBookButton(
                        onPressed: () {
                          context.read<BookBloc>().add(
                                EditBookButtonClickedEvent(
                                  book: widget.books[index],
                                ),
                              );
                          _selectedIndex = null;
                          context.push(EditBookScreen.path);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: DeleteBookButton(
                        onPressed: () {
                          context.read<BookBloc>().add(
                              DeleteBookButtonClickedEvent(
                                  id: widget.books[index].id));
                          _selectedIndex = null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return listTile;
        },
      ),
    );
  }
}
