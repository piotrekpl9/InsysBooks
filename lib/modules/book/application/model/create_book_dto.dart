class CreateBookDto {
  final String name;
  final String authorName;
  final DateTime? releaseDate;

  CreateBookDto(
      {required this.name,
      required this.authorName,
      required this.releaseDate});
}
