class User {
  final String id;
  final String name;
  final String? profileImageUrl;
  final int? booksCount;
  final int? reviewsCount;
  final DateTime joinedDate;

  User({
    required this.id,
    required this.name,
    this.profileImageUrl,
    this.booksCount,
    this.reviewsCount,
    required this.joinedDate,
  });
}
