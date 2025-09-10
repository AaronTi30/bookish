class SearchResult {
  final String id;
  final String title;
  final List<String> authors;
  final String? publishedDate;
  final String? description;
  final int? pageCount;
  final List<String>? categories;
  final double? averageRating;
  final int? ratingsCount;
  final String? thumbnailUrl;
  final String? previewLink;
  final String? infoLink;
  final bool isEbook;
  final String? buyLink;

  SearchResult({
    required this.id,
    required this.title,
    required this.authors,
    this.publishedDate,
    this.description,
    this.pageCount,
    this.categories,
    this.averageRating,
    this.ratingsCount,
    this.thumbnailUrl,
    this.previewLink,
    this.infoLink,
    this.isEbook = false,
    this.buyLink,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'],
      title: json['title'],
      authors: List<String>.from(json['authors']),
      publishedDate: json['publishedDate'],
      description: json['description'],
      pageCount: json['pageCount'],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : null,
      averageRating: json['averageRating']?.toDouble(),
      ratingsCount: json['ratingsCount'],
      thumbnailUrl: json['thumbnail'],
      previewLink: json['previewLink'],
      infoLink: json['infoLink'],
      isEbook: json['isEbook'] ?? false,
      buyLink: json['buyLink'],
    );
  }
}
