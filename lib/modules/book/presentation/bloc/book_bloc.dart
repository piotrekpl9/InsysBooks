import 'package:equatable/equatable.dart';
import 'package:insys_books/modules/book/application/model/create_book_dto.dart';
import 'package:insys_books/modules/book/application/model/update_book_dto.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_command_service.dart';
import 'package:insys_books/modules/book/application/services/abstraction/abstract_book_query_service.dart';
import 'package:insys_books/modules/book/domain/book.dart';
import 'package:bloc/bloc.dart';
import 'package:uuid/uuid.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final AbstractBookQueryService _bookQueryService;
  final AbstractBookCommandService _bookCommandService;
  BookBloc(
      {required AbstractBookQueryService bookQueryService,
      required AbstractBookCommandService bookCommandService})
      : _bookQueryService = bookQueryService,
        _bookCommandService = bookCommandService,
        super(const BookState()) {
    on<BookBlocStarted>(_onBookBlocStarted);
    on<FilterBookButtonClickedEvent>(_onFilterBookClicked);
    on<RemoveFilterBookButtonClickedEvent>(_onRemoveFilterClicked);
    on<CreateBookButtonClickedEvent>(_onCreateBookClicked);
    on<DeleteBookButtonClickedEvent>(_onDeleteBookClicked);
    on<EditBookButtonClickedEvent>(_onEditBookClicked);
    on<BookEditingScreenLeavedEvent>(_onEditingScreenLeaved);
    on<BookEditingFormSubmittedEvent>(_onEditingFormSubmitted);

    add(const BookBlocStarted());
  }

  Future<void> _onBookBlocStarted(
    BookBlocStarted event,
    Emitter<BookState> emit,
  ) async {
    emit(state.copyWith(status: BookStateStatus.loading));
    var books = await _bookQueryService.getAllBooks();
    emit(state.copyWith(status: BookStateStatus.idle, books: books));
  }

  Future<void> _onFilterBookClicked(
    FilterBookButtonClickedEvent event,
    Emitter<BookState> emit,
  ) async {
    emit(state.copyWith(
        status: BookStateStatus.loading, filter: event.bookTitle));
    var books = await _bookQueryService.getBooksByName(event.bookTitle);
    emit(state.copyWith(status: BookStateStatus.idle, books: books));
  }

  Future<void> _onRemoveFilterClicked(
    RemoveFilterBookButtonClickedEvent event,
    Emitter<BookState> emit,
  ) async {
    emit(state.copyWith(
      status: BookStateStatus.loading,
    ));
    var books = await _bookQueryService.getAllBooks();
    emit(state.copyWithResetedFilter(
        status: BookStateStatus.idle, books: books));
  }

  Future<void> _onCreateBookClicked(
    CreateBookButtonClickedEvent event,
    Emitter<BookState> emit,
  ) async {
    var createBookDto = CreateBookDto(
        id: const Uuid().v4(),
        title: event.title,
        authorName: event.author,
        publicationDate: event.publicationYear);

    //TODO add Either

    var commandResult = await _bookCommandService.createBook(createBookDto);
    if (!commandResult) {
      emit(state.copyWith(status: BookStateStatus.actionFailure));
      emit(state.copyWith(status: BookStateStatus.idle));
      return;
    }

    var book = await _bookQueryService.getBookById(createBookDto.id);
    if (book == null) {
      emit(state.copyWith(status: BookStateStatus.actionFailure));
      emit(state.copyWith(status: BookStateStatus.idle));
      return;
    }
    var books = state.books;
    books.add(book);
    emit(state.copyWith(status: BookStateStatus.actionSuccess, books: books));
    emit(state.copyWith(status: BookStateStatus.idle));
  }

  Future<void> _onDeleteBookClicked(
    DeleteBookButtonClickedEvent event,
    Emitter<BookState> emit,
  ) async {
    var commandResult = await _bookCommandService.deleteBook(event.id);
    if (!commandResult) {
      emit(state.copyWith(status: BookStateStatus.actionFailure));
      emit(state.copyWith(status: BookStateStatus.idle));
      return;
    }
    var book = await _bookQueryService.getBookById(event.id);
    if (book != null) {
      emit(state.copyWith(status: BookStateStatus.actionFailure));
      emit(state.copyWith(status: BookStateStatus.idle));
      return;
    }
    var books = state.books;
    books.removeWhere(
      (element) => element.id == event.id,
    );
    emit(state.copyWith(status: BookStateStatus.actionSuccess, books: books));
    emit(state.copyWith(status: BookStateStatus.idle));
  }

  Future<void> _onEditBookClicked(
    EditBookButtonClickedEvent event,
    Emitter<BookState> emit,
  ) async {
    emit(state.copyWith(
        status: BookStateStatus.bookEditing, editedBook: event.book));
  }

  Future<void> _onEditingFormSubmitted(
    BookEditingFormSubmittedEvent event,
    Emitter<BookState> emit,
  ) async {
    var updateBookDto = UpdateBookDto(
        title: event.title,
        authorName: event.author,
        publicationYear: event.publicationYear);

    //TODO add Either
    final editedBook = state.editedBook;
    if (editedBook == null) {
      //TODO Implement failure
      return;
    }
    var commandResult =
        await _bookCommandService.updateBook(editedBook.id, updateBookDto);
    if (!commandResult) {
      emit(state.copyWith(status: BookStateStatus.actionFailure));
      emit(state.copyWith(status: BookStateStatus.idle));
      return;
    }
    var book = await _bookQueryService.getBookById(state.editedBook!.id);
    if (book == null) {
      emit(state.copyWith(status: BookStateStatus.actionFailure));
      emit(state.copyWith(status: BookStateStatus.idle));
      return;
    }
    var books = state.books;
    var editedIndex = books.indexWhere(
      (element) => element.id == editedBook.id,
    );
    books[editedIndex] = book;
    emit(state.copyWith(status: BookStateStatus.actionSuccess, books: books));
    emit(state.copyWith(status: BookStateStatus.idle));
  }

  Future<void> _onEditingScreenLeaved(
    BookEditingScreenLeavedEvent event,
    Emitter<BookState> emit,
  ) async {
    emit(state.copyWithResetedEditedBook(
      status: BookStateStatus.editingCancelled,
    ));
    emit(state.copyWith(
      status: BookStateStatus.idle,
    ));
  }
}
