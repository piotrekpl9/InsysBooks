part of 'book_bloc.dart';

sealed class BookEvent extends Equatable {
  const BookEvent();
  @override
  List<Object?> get props => [];
}

final class BookBlocStarted extends BookEvent {
  const BookBlocStarted();
}

final class FilterBookButtonClickedEvent extends BookEvent {
  final String bookTitle;
  const FilterBookButtonClickedEvent(this.bookTitle);
}

final class RemoveFilterBookButtonClickedEvent extends BookEvent {
  const RemoveFilterBookButtonClickedEvent();
}

final class CreateBookButtonClickedEvent extends BookEvent {
  final String title;
  final String author;
  final int publicationYear;

  const CreateBookButtonClickedEvent({
    required this.title,
    required this.author,
    required this.publicationYear,
  });
}

final class DeleteBookButtonClickedEvent extends BookEvent {
  final String id;

  const DeleteBookButtonClickedEvent({
    required this.id,
  });
}

final class EditBookButtonClickedEvent extends BookEvent {
  final Book book;

  const EditBookButtonClickedEvent({
    required this.book,
  });
}

final class BookEditingScreenLeavedEvent extends BookEvent {
  const BookEditingScreenLeavedEvent();
}

final class BookEditingFormSubmittedEvent extends BookEvent {
  final String title;
  final String author;
  final int publicationYear;

  const BookEditingFormSubmittedEvent({
    required this.title,
    required this.author,
    required this.publicationYear,
  });
}
