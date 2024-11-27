class CreateBookDto {
  final String id;
  final String title;
  final String authorName;
  final int publicationDate;

  CreateBookDto(
      {required this.title,
      required this.id,
      required this.authorName,
      required this.publicationDate});
}
