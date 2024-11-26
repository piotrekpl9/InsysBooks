part of 'book_bloc.dart';

@immutable
sealed class BookEvent extends Equatable {
  const BookEvent();
  @override
  List<Object?> get props => [];
}

final class BookHomeScreenEntered extends BookEvent {
  const BookHomeScreenEntered();
}
