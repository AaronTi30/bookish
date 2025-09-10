import 'package:flutter/material.dart';
import '../models/book_detail.dart';
import '../widgets/review_dialog.dart';

class BookDetailScreen extends StatefulWidget {
  final BookDetail book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _isDescriptionExpanded = false;
  int _selectedAction = 0; // 0: Want to read, 1: Currently reading, 2: Read

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with back button and book cover
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(background: _buildBookCover()),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Book details content
          SliverList(
            delegate: SliverChildListDelegate([
              _buildBookInfo(),
              _buildActionButtons(),
              _buildDescription(),
              _buildBookDetails(),
              _buildReviewsSection(),
              const SizedBox(height: 40),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCover() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.3),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 180,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.book, size: 60, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildBookInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.book.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.book.authors.join(', '),
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          const SizedBox(height: 16),
          _buildRatingSection(),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        // Star rating
        if (widget.book.averageRating != null) ...[
          Icon(Icons.star, color: Colors.amber, size: 20),
          const SizedBox(width: 4),
          Text(
            widget.book.averageRating!.toStringAsFixed(1),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
        ],

        // Ratings count
        if (widget.book.ratingsCount != null)
          Text(
            '(${widget.book.ratingsCount!.formatCount()} ratings)',
            style: TextStyle(color: Colors.grey[600]),
          ),

        const Spacer(),

        // Review count
        if (widget.book.reviewCount != null)
          Text(
            '${widget.book.reviewCount!.formatCount()} reviews',
            style: TextStyle(color: Colors.grey[600]),
          ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          // Reading status selector
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildStatusButton('Want to read', 0),
                _buildStatusButton('Currently reading', 1),
                _buildStatusButton('Read', 2),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Action buttons row
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.reviews, size: 20),
              label: const Text('Write a Review'),
              onPressed: () => _showReviewDialog(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(String text, int index) {
    final isSelected = _selectedAction == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedAction = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    if (widget.book.description == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            _isDescriptionExpanded
                ? widget.book.description!
                : widget.book.description!.length > 200
                ? '${widget.book.description!.substring(0, 200)}...'
                : widget.book.description!,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey[700],
            ),
          ),
          if (widget.book.description!.length > 200)
            TextButton(
              onPressed: () => setState(
                () => _isDescriptionExpanded = !_isDescriptionExpanded,
              ),
              child: Text(
                _isDescriptionExpanded ? 'Show less' : 'Read more',
                style: const TextStyle(color: Colors.blue),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBookDetails() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Book Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            'Published',
            widget.book.publishedDate?.year.toString(),
          ),
          _buildDetailRow('Publisher', widget.book.publisher),
          _buildDetailRow('Pages', widget.book.pageCount?.toString()),
          _buildDetailRow('ISBN', widget.book.isbn),
          _buildDetailRow('Language', widget.book.language),
          if (widget.book.genres != null && widget.book.genres!.isNotEmpty)
            _buildDetailRow('Genres', widget.book.genres!.join(', ')),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    if (value == null) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reviews',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Placeholder for reviews - we'll implement this later
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.reviews, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 16),
                const Text(
                  'No reviews yet',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showReviewDialog() {
    // Implement rating dialog
    showReviewDialog(
      context: context,
      bookTitle: widget.book.title,
      initialRating: 0,
      onReviewSubmitted: (rating, review) {
        //Handle the submitted rating
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rated "${widget.book.title}" with $rating stars!'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
    print('Show rating dialog for ${widget.book.title}');
  }
}

// Extension for formatting large numbers
extension NumberFormatting on int {
  String formatCount() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toString();
  }
}
