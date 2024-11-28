import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:insys_books/modules/book/presentation/bloc/book_bloc.dart';
import 'package:insys_books/modules/book/presentation/screens/add_book/add_book_screen.dart';
import 'package:insys_books/modules/book/presentation/screens/edit_book/edit_book_screen.dart';
import 'package:insys_books/modules/book/presentation/screens/home/widgets/form/filter_form.dart';
import 'package:insys_books/modules/book/presentation/widgets/book_scaffold.dart';

class BookHomeScreen extends StatefulWidget {
  static String path = "/";
  const BookHomeScreen({super.key});

  @override
  State<BookHomeScreen> createState() => _BookHomeScreenState();
}

class _BookHomeScreenState extends State<BookHomeScreen> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BookScaffold(
      //TODO dodaj czcionke
      title: "Book home",
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFF4ac0d1), width: 2)),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Color(0xFF4ac0d1),
        ),
        onPressed: () {
          context.push(AddBookScreen.path);
        },
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              FilterForm(
                filter: state.filter,
              ),
              Expanded(
                child: state.status == BookStateStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : ShaderMask(
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
                          itemCount: state.books.length,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          padding: EdgeInsets.symmetric(vertical: 30),
                          itemBuilder: (context, index) {
                            var book = state.books[index];
                            var selected = index == _selectedIndex;
                            return selected
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        subtitle: Text(book.authorName),
                                        leading:
                                            //TODO po prostu wyciągnąć to na początku buildera i tam sprawdzić
                                            book.imagePath != null
                                                ? book.imagePath!.isNotEmpty
                                                    ? Image.network(
                                                        book.imagePath!)
                                                    : null
                                                : null,
                                        selected: selected,
                                        title: Text("${book.title}"),
                                        trailing: Text(
                                            book.publicationYear.toString()),
                                        onLongPress: () {
                                          setState(
                                            () {
                                              if (_selectedIndex == null ||
                                                  index != _selectedIndex) {
                                                _selectedIndex = index;
                                              } else {
                                                _selectedIndex = null;
                                              }
                                            },
                                          );
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xFF4ac0d1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  BlocProvider.of<BookBloc>(
                                                          context)
                                                      .add(
                                                    EditBookButtonClickedEvent(
                                                      book: state.books[index],
                                                    ),
                                                  );
                                                  _selectedIndex = null;
                                                  context.push(
                                                      EditBookScreen.path);
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 254, 116, 107),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  BlocProvider.of<BookBloc>(
                                                          context)
                                                      .add(
                                                          DeleteBookButtonClickedEvent(
                                                              id: state
                                                                  .books[index]
                                                                  .id));
                                                  _selectedIndex = null;
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 254, 116, 107),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : ListTile(
                                    subtitle: Text(book.authorName),
                                    leading:
                                        //TODO po prostu wyciągnąć to na początku buildera i tam sprawdzić
                                        book.imagePath != null
                                            ? book.imagePath!.isNotEmpty
                                                ? Image.network(book.imagePath!)
                                                : null
                                            : null,
                                    selected: selected,
                                    title: Text("${book.title}"),
                                    trailing:
                                        Text(book.publicationYear.toString()),
                                    onLongPress: () {
                                      setState(
                                        () {
                                          if (_selectedIndex == null ||
                                              index != _selectedIndex) {
                                            _selectedIndex = index;
                                          } else {
                                            _selectedIndex = null;
                                          }
                                        },
                                      );
                                    },
                                  );
                          },
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
