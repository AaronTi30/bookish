class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String? coverUrl;
  final double? averageRating;
  final int? ratingsCount;
  final DateTime? publishedDate;
  final int? pageCount;
  final String? description;
  final List<String>? genres;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    this.coverUrl,
    this.averageRating,
    this.ratingsCount,
    this.publishedDate,
    this.pageCount,
    this.description,
    this.genres,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      authors: List<String>.from(json['authors']),
      coverUrl: json['coverUrl'],
      averageRating: json['averageRating']?.toDouble(),
      ratingsCount: json['ratingsCount'],
      publishedDate: json['publishedDate'] != null
          ? DateTime.parse(json['publishedDate'])
          : null,
      pageCount: json['pageCount'],
      description: json['description'],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : null,
    );
  }
}
