class BookDetail {
  final String id;
  final String title;
  final List<String> authors;
  final String? coverUrl;
  final double? averageRating;
  final int? ratingsCount;
  final int? reviewCount;
  final DateTime? publishedDate;
  final String? publisher;
  final int? pageCount;
  final String? description;
  final List<String>? genres;
  final String? isbn;
  final String? language;

  BookDetail({
    required this.id,
    required this.title,
    required this.authors,
    this.coverUrl,
    this.averageRating,
    this.ratingsCount,
    this.reviewCount,
    this.publishedDate,
    this.publisher,
    this.pageCount,
    this.description,
    this.genres,
    this.isbn,
    this.language,
  });

  // You can add fromJson method later for API integration
}
