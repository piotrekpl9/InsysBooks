import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String id;
  final String title;
  final String authorName;
  final int? publicationYear;
  final String? imagePath;

  const Book({
    required this.id,
    required this.title,
    required this.authorName,
    required this.publicationYear,
    required this.imagePath,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    var volumeInfo = json['volumeInfo'];
    var publishedDateField = volumeInfo['publishedDate'];
    int? date;
    if (publishedDateField != null) {
      date = DateTime.tryParse(publishedDateField)?.year;
      if (date == null) {
        int? year = int.tryParse(volumeInfo['publishedDate']);
        if (year != null) {
          date = year;
        }
      }
    }

    return Book(
      id: json['id'] as String,
      title: volumeInfo["title"] as String,
      authorName: volumeInfo['authors']?.isNotEmpty == true
          ? volumeInfo['authors']![0] as String
          : 'Unknown Author',
      publicationYear: date,
      imagePath: volumeInfo["imageLinks"]?["thumbnail"] ?? "",
    );
  }

  @override
  List<Object?> get props =>
      [id, title, authorName, publicationYear, imagePath];
}
