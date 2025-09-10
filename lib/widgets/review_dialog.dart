import 'package:flutter/material.dart';

class ReviewDialog extends StatefulWidget {
  final String bookTitle;
  final double initialRating;
  final String initialReview;
  final Function(double, String) onReviewSubmitted;

  const ReviewDialog({
    Key? key,
    required this.bookTitle,
    this.initialRating = 0,
    this.initialReview = '',
    required this.onReviewSubmitted,
  }) : super(key: key);

  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  late double _currentRating;
  late TextEditingController _reviewController;
  bool _isSubmitting = false;
  final FocusNode _reviewFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
    _reviewController = TextEditingController(text: widget.initialReview);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    _reviewFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Review "${widget.bookTitle}"',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Star rating
              _buildStarRating(),
              const SizedBox(height: 8),

              // Rating text
              Text(
                _getRatingText(_currentRating),
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),

              // Review text field
              Text(
                'Your Review (optional)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _reviewController,
                focusNode: _reviewFocusNode,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Share your thoughts about this book...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: (value) {
                  setState(() {}); // Rebuild to update character count
                },
              ),
              const SizedBox(height: 4),
              Text(
                '${_reviewController.text.length} characters',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: 20),

              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _isSubmitting
                        ? null
                        : () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _currentRating > 0 ? _submitReview : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Text('Submit Review'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          final starIndex = index ~/ 2;
          final isHalfStar = index.isOdd;
          final ratingValue = starIndex + (isHalfStar ? 0.5 : 1.0);

          return GestureDetector(
            onTap: () {
              setState(() {
                _currentRating = ratingValue;
              });
              // Auto-focus on review field after rating
              if (_currentRating > 0) {
                FocusScope.of(context).requestFocus(_reviewFocusNode);
              }
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Icon(
                  _getStarIcon(ratingValue),
                  size: 30,
                  color: Colors.amber,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  IconData _getStarIcon(double ratingValue) {
    if (_currentRating >= ratingValue) {
      return Icons.star;
    } else if (_currentRating >= ratingValue - 0.5 &&
        _currentRating < ratingValue) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }

  String _getRatingText(double rating) {
    if (rating == 0) return 'Tap stars to rate this book';
    if (rating == 0.5) return '0.5 - Poor';
    if (rating == 1) return '1 - Not good';
    if (rating == 1.5) return '1.5 - Below average';
    if (rating == 2) return '2 - Okay';
    if (rating == 2.5) return '2.5 - Fair';
    if (rating == 3) return '3 - Good';
    if (rating == 3.5) return '3.5 - Very good';
    if (rating == 4) return '4 - Great';
    if (rating == 4.5) return '4.5 - Excellent';
    if (rating == 5) return '5 - Amazing!';
    return '${rating.toStringAsFixed(1)} stars';
  }

  void _submitReview() async {
    setState(() => _isSubmitting = true);

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      Navigator.pop(context);
      widget.onReviewSubmitted(_currentRating, _reviewController.text.trim());
    }

    setState(() => _isSubmitting = false);
  }
}

// Helper function to show the review dialog
void showReviewDialog({
  required BuildContext context,
  required String bookTitle,
  double initialRating = 0,
  String initialReview = '',
  required Function(double, String) onReviewSubmitted,
}) {
  showDialog(
    context: context,
    builder: (context) => ReviewDialog(
      bookTitle: bookTitle,
      initialRating: initialRating,
      initialReview: initialReview,
      onReviewSubmitted: onReviewSubmitted,
    ),
  );
}
