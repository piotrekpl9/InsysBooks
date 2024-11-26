class Book {
  final String id;
  final String name;
  final String authorName;
  final DateTime? releaseDate;
  final String? imagePath;

  Book({
    required this.id,
    required this.name,
    required this.authorName,
    required this.releaseDate,
    required this.imagePath,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    var volumeInfo = json['volumeInfo'];
    var publishedDateField = volumeInfo['publishedDate'];
    DateTime? fullDate;
    if (publishedDateField != null) {
      fullDate = DateTime.tryParse(publishedDateField);
      if (fullDate == null) {
        int? year = int.tryParse(volumeInfo['publishedDate']);
        if (year != null) {
          fullDate = DateTime(year);
        }
      }
    }

    return Book(
      id: json['id'] as String,
      name: volumeInfo["title"] as String,
      authorName: volumeInfo['authors']?.isNotEmpty == true
          ? volumeInfo['authors']![0] as String
          : 'Unknown Author',
      releaseDate: fullDate,
      imagePath: volumeInfo["imageLinks"]?["thumbnail"] ?? "",
    );
  }
}
