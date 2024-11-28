// Mocks generated by Mockito 5.4.4 from annotations
// in insys_books/test/widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:insys_books/modules/book/domain/book.dart' as _i4;
import 'package:insys_books/modules/book/infrastructure/book_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [BookRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockBookRepository extends _i1.Mock implements _i2.BookRepository {
  MockBookRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Book>> getBooksByName(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBooksByName,
          [name],
        ),
        returnValue: _i3.Future<List<_i4.Book>>.value(<_i4.Book>[]),
      ) as _i3.Future<List<_i4.Book>>);

  @override
  _i3.Future<bool> createBook(_i4.Book? book) => (super.noSuchMethod(
        Invocation.method(
          #createBook,
          [book],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<List<_i4.Book>> getAllBooks({int? limit}) => (super.noSuchMethod(
        Invocation.method(
          #getAllBooks,
          [],
          {#limit: limit},
        ),
        returnValue: _i3.Future<List<_i4.Book>>.value(<_i4.Book>[]),
      ) as _i3.Future<List<_i4.Book>>);

  @override
  _i3.Future<_i4.Book?> getBookById(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getBookById,
          [id],
        ),
        returnValue: _i3.Future<_i4.Book?>.value(),
      ) as _i3.Future<_i4.Book?>);

  @override
  _i3.Future<bool> deleteBook(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteBook,
          [id],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<bool> updateBook(_i4.Book? book) => (super.noSuchMethod(
        Invocation.method(
          #updateBook,
          [book],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);

  @override
  _i3.Future<bool> bookExistsById(String? id) => (super.noSuchMethod(
        Invocation.method(
          #bookExistsById,
          [id],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}