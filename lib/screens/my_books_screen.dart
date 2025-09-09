import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_card.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({Key? key}) : super(key: key);

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  int _selectedSegment = 0; // 0: Reading, 1: To Read, 2: Read

  // Sample data for each category
  final List<Book> _currentlyReading = [
    Book(
      id: '1',
      title: 'Dune',
      authors: ['Frank Herbert'],
      coverUrl: 'https://example.com/dune.jpg',
      averageRating: 4.3,
      ratingsCount: 1250,
    ),
    Book(
      id: '2',
      title: 'The Three-Body Problem',
      authors: ['Cixin Liu'],
      coverUrl: 'https://example.com/threebody.jpg',
      averageRating: 4.1,
      ratingsCount: 980,
    ),
  ];

  final List<Book> _wantToRead = [
    Book(
      id: '3',
      title: 'Project Hail Mary',
      authors: ['Andy Weir'],
      coverUrl: 'https://example.com/hailmary.jpg',
      averageRating: 4.5,
      ratingsCount: 1200,
    ),
  ];

  final List<Book> _alreadyRead = [
    Book(
      id: '4',
      title: 'The Midnight Library',
      authors: ['Matt Haig'],
      coverUrl: 'https://example.com/midnight.jpg',
      averageRating: 4.2,
      ratingsCount: 1500,
    ),
    Book(
      id: '5',
      title: 'Crime and Punishment',
      authors: ['Fyodor Dostoevsky'],
      coverUrl: 'https://example.com/crime.jpg',
      averageRating: 4.4,
      ratingsCount: 2000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Segmented Control for filtering
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _buildSegmentButton('Reading', 0),
                  _buildSegmentButton('To Read', 1),
                  _buildSegmentButton('Read', 2),
                ],
              ),
            ),
          ),

          // Books list based on selected segment
          Expanded(child: _buildBooksList()),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String text, int index) {
    final isSelected = _selectedSegment == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSegment = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
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

  Widget _buildBooksList() {
    List<Book> booksToShow;

    switch (_selectedSegment) {
      case 0:
        booksToShow = _currentlyReading;
        break;
      case 1:
        booksToShow = _wantToRead;
        break;
      case 2:
        booksToShow = _alreadyRead;
        break;
      default:
        booksToShow = _currentlyReading;
    }

    if (booksToShow.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu_book, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              _getEmptyStateMessage(),
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: booksToShow.length,
      itemBuilder: (context, index) {
        final book = booksToShow[index];
        return _buildBookListItem(book);
      },
    );
  }

  String _getEmptyStateMessage() {
    switch (_selectedSegment) {
      case 0:
        return 'You\'re not reading any books yet.\nStart reading to see them here!';
      case 1:
        return 'Your reading list is empty.\nAdd books you want to read later.';
      case 2:
        return 'You haven\'t finished any books yet.\nKeep reading!';
      default:
        return 'No books found.';
    }
  }

  Widget _buildBookListItem(Book book) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(Icons.book, color: Colors.grey),
        ),
        title: Text(
          book.title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.authors.join(', ')),
            if (book.averageRating != null)
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(book.averageRating!.toStringAsFixed(1)),
                ],
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            _showBookOptions(book);
          },
        ),
        onTap: () {
          // Navigate to book details
        },
      ),
    );
  }

  void _showBookOptions(Book book) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Update progress'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement update progress
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Rate book'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement rating
                },
              ),
              ListTile(
                leading: const Icon(Icons.reviews),
                title: const Text('Write review'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement review writing
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Remove from my books'),
                onTap: () {
                  Navigator.pop(context);
                  _removeBook(book);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeBook(Book book) {
    setState(() {
      // Remove book from the appropriate list
      switch (_selectedSegment) {
        case 0:
          _currentlyReading.remove(book);
          break;
        case 1:
          _wantToRead.remove(book);
          break;
        case 2:
          _alreadyRead.remove(book);
          break;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Removed ${book.title} from your books'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
