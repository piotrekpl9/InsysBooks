class UpdateBookDto {
  final String name;
  final String authorName;
  final DateTime? releaseDate;

  UpdateBookDto(
      {required this.name,
      required this.authorName,
      required this.releaseDate});
}
