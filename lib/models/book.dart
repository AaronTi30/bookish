import 'dart:convert'; // Add this import if you need JSON decoding

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

  // Add this factory constructor for search results
  factory Book.fromSearchJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final imageLinks = volumeInfo['imageLinks'] ?? {};

    // Debug: Print the JSON to see the actual structure
    // print('Raw JSON: $json');

    // Extract title with better null handling
    String title = 'Unknown Title';
    if (volumeInfo['title'] is String) {
      title = volumeInfo['title']!;
    } else if (volumeInfo['title'] != null) {
      title = volumeInfo['title'].toString();
    }

    // Extract authors with better handling
    List<String> authors = ['Unknown Author'];
    if (volumeInfo['authors'] is List) {
      try {
        authors = List<String>.from(
          volumeInfo['authors'].where((author) => author != null),
        );
        if (authors.isEmpty) authors = ['Unknown Author'];
      } catch (e) {
        authors = ['Unknown Author'];
      }
    }

    // Extract thumbnail URL with better handling
    String? thumbnailUrl;
    if (imageLinks['thumbnail'] is String) {
      thumbnailUrl = imageLinks['thumbnail'];
      // Fix HTTP vs HTTPS issue common with Google Books API
      if (thumbnailUrl != null && thumbnailUrl.startsWith('http:')) {
        thumbnailUrl = thumbnailUrl.replaceFirst('http:', 'https:');
      }
    }

    // Extract other fields with better null handling
    return Book(
      id: json['id']?.toString() ?? '',
      title: title,
      authors: authors,
      coverUrl: thumbnailUrl,
      averageRating: volumeInfo['averageRating'] is num
          ? volumeInfo['averageRating'].toDouble()
          : null,
      ratingsCount: volumeInfo['ratingsCount'] is int
          ? volumeInfo['ratingsCount']
          : null,
      publishedDate: _parseDate(volumeInfo['publishedDate']),
      pageCount: volumeInfo['pageCount'] is int
          ? volumeInfo['pageCount']
          : null,
      description: volumeInfo['description']?.toString(),
      genres: volumeInfo['categories'] is List
          ? List<String>.from(
              volumeInfo['categories'].where((category) => category != null),
            )
          : null,
    );
  }

  // Helper method to parse various date formats
  static DateTime? _parseDate(dynamic dateValue) {
    if (dateValue == null) return null;

    if (dateValue is DateTime) return dateValue;

    if (dateValue is String) {
      // Try parsing full date (YYYY-MM-DD)
      final fullDate = DateTime.tryParse(dateValue);
      if (fullDate != null) return fullDate;

      // Try parsing year only (YYYY)
      if (dateValue.length == 4) {
        final year = int.tryParse(dateValue);
        if (year != null) return DateTime(year);
      }

      // Try parsing year-month (YYYY-MM)
      if (dateValue.length == 7 && dateValue[4] == '-') {
        final year = int.tryParse(dateValue.substring(0, 4));
        final month = int.tryParse(dateValue.substring(5, 7));
        if (year != null && month != null) return DateTime(year, month);
      }
    }

    return null;
  }
}
