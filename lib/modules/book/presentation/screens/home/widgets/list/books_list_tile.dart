import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insys_books/core/presentation/consts/app_typography_styles.dart';
import 'package:insys_books/modules/book/domain/book.dart';

class BooksListTile extends StatelessWidget {
  final Book book;
  final bool selected;
  final void Function() onLongPress;

  const BooksListTile(
      {super.key,
      required this.onLongPress,
      required this.book,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    Widget? leading;

    if (book.imagePath == null) {
      leading = const SizedBox();
    } else if (book.imagePath!.isEmpty) {
      leading = const SizedBox();
    } else {
      leading = CachedNetworkImage(
        imageUrl: book.imagePath!,
        width: 50,
      );
    }
    String publicationYear = book.publicationYear?.toString() ?? "Unknown";
    return ListTile(
        key: ValueKey(book.id),
        subtitle: Text(book.authorName),
        leading: leading,
        selected: selected,
        title: Text(book.title),
        trailing: Text(publicationYear),
        onLongPress: onLongPress);
  }
}
