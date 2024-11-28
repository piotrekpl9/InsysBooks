part of 'book_bloc.dart';

enum BookStateStatus {
  init,
  loading,
  idle,
  actionSuccess,
  actionFailure,
  bookEditing,
  editingCancelled,
}

class BookState extends Equatable {
  final BookStateStatus status;
  final List<Book> books;
  final String? filter;
  final Book? editedBook;

  const BookState({
    this.status = BookStateStatus.init,
    this.books = const [],
    this.filter,
    this.editedBook,
  });

  BookState copyWith({
    BookStateStatus? status,
    List<Book>? books,
    String? filter,
    Book? editedBook,
  }) {
    return BookState(
      status: status ?? this.status,
      books: books ?? this.books,
      filter: filter ?? this.filter,
      editedBook: editedBook ?? this.editedBook,
    );
  }

  BookState copyWithResetedEditedBook({
    BookStateStatus? status,
    List<Book>? books,
    String? filter,
  }) {
    return BookState(
        status: status ?? this.status,
        books: books ?? this.books,
        filter: filter ?? this.filter,
        editedBook: null);
  }

  BookState copyWithResetedFilter({
    BookStateStatus? status,
    List<Book>? books,
    String? filter,
  }) {
    return BookState(
      status: status ?? this.status,
      books: books ?? this.books,
      filter: null,
      editedBook: editedBook ?? this.editedBook,
    );
  }

  @override
  List<Object?> get props => [books, status, filter];
}
