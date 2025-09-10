import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback? onTap;

  const BookCard({Key? key, required this.book, this.onTap}) : super(key: key);

  // Add this method to handle different book states
  Widget _buildBookStatusIndicator() {
    // You can add logic here to show reading status indicators
    return const SizedBox.shrink(); // Remove this if you want status indicators
  }

  // Update the build method to include the status indicator
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover with status indicator
            Stack(
              children: [
                // Book cover image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 120,
                    height: 180,
                    color: Colors.grey[200],
                    child: book.coverUrl != null && book.coverUrl!.isNotEmpty
                        ? Image.network(
                            book.coverUrl!,
                            width: 120,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.book, color: Colors.grey);
                            },
                          )
                        : const Icon(Icons.book, color: Colors.grey),
                  ),
                ),
                // Status indicator
                Positioned(
                  top: 8,
                  right: 8,
                  child: _buildBookStatusIndicator(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Book title
            Text(
              book.title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Author
            Text(
              book.authors.join(', '),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Rating
            if (book.averageRating != null)
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    book.averageRating!.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 4),
                  if (book.ratingsCount != null)
                    Text(
                      '(${book.ratingsCount})',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
