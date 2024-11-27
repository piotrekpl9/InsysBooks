class UpdateBookDto {
  final String title;
  final String authorName;
  final int publicationYear;

  UpdateBookDto(
      {required this.title,
      required this.authorName,
      required this.publicationYear});
}
