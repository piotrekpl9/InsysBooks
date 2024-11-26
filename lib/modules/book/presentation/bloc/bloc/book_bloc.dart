import 'package:equatable/equatable.dart';
import 'package:insys_books/modules/book/application/services/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/domain/book.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final AbstractBookQueryService _bookQueryService;
  BookBloc({required AbstractBookQueryService bookQueryService})
      : _bookQueryService = bookQueryService,
        super(const BookState()) {
    on<BookHomeScreenEntered>(_onBookHomeEntered);
  }

  Future<void> _onBookHomeEntered(
    BookHomeScreenEntered event,
    Emitter<BookState> emit,
  ) async {
    emit(state.copyWith(status: BookStateStatus.loading));
    var books = await _bookQueryService.getAllLocalBooks();
    emit(state.copyWith(status: BookStateStatus.idle, books: books));
  }
}
