part of 'book_bloc.dart';

enum BookStateStatus { init, loading, idle }

@immutable
class BookState extends Equatable {
  final BookStateStatus status;
  final List<Book> books;
  final String filter;

  const BookState({
    this.status = BookStateStatus.init,
    this.books = const [],
    this.filter = "",
  });

  BookState copyWith({
    BookStateStatus? status,
    List<Book>? books,
    String? filter,
  }) {
    return BookState(
      status: status ?? this.status,
      books: books ?? this.books,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [books, status, filter];
}
