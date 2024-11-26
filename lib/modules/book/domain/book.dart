class Book {
  final String isbn;
  final String name;
  final String authorName;
  final DateTime releaseDate;
  final String imagePath;

  Book({
    required this.isbn,
    required this.name,
    required this.authorName,
    required this.releaseDate,
    required this.imagePath,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      isbn: json['isbn'][0] as String,
      name: json['title'] as String,
      authorName: json['author_name']?[0] as String,
      releaseDate: DateTime.parse(json['publish_date'][0] as String),
      imagePath:
          "https://covers.openlibrary.org/b/id/${json['cover_i'] as String}-L.jpg",
    );
  }
}
