import 'package:bookish/models/book_detail.dart';
import 'package:bookish/screens/my_books_screen.dart';
import 'package:bookish/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/book_card.dart';
import '../models/book.dart';
import '../widgets/genre_tile.dart';
import '../screens/book_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Book> featuredBooks = [
      Book(
        id: '1',
        title: 'The Midnight Library',
        authors: ['Matt Haig'],
        coverUrl: 'https://example.com/book1.jpg',
        averageRating: 4.2,
        ratingsCount: 1250,
      ),
      Book(
        id: '2',
        title: 'Project Hail Mary',
        authors: ['Andy Weir'],
        coverUrl: 'https://example.com/book2.jpg',
        averageRating: 4.5,
        ratingsCount: 980,
      ),
      Book(
        id: '3',
        title: 'Crime and Punishment',
        authors: ['Fyodor Dostoevsky'],
        coverUrl: 'https://example.com/book3.jpg',
        averageRating: 4.23,
        ratingsCount: 1038,
      ),
      Book(
        id: '4',
        title: 'The Way Of Kings',
        authors: ['Brandon Sanderson'],
        coverUrl: 'https://example.com/book4.jpg',
        averageRating: 4.67,
        ratingsCount: 6368,
      ),
      // Add more books...
    ];

    // mock recommended books
    final List<Book> recBooks = [
      Book(
        id: '1',
        title: 'Fourth Wing',
        authors: ['Rebecca Yarros'],
        coverUrl: 'https://example.com/book1.jpg',
        averageRating: 4.57,
        ratingsCount: 3238,
      ),
      Book(
        id: '2',
        title: 'Pride and Prejudice',
        authors: ['Jane Austen'],
        coverUrl: 'https://example.com/book2.jpg',
        averageRating: 4.29,
        ratingsCount: 4675,
      ),
      Book(
        id: '3',
        title: 'Piranesi',
        authors: ['Susanna Clarke'],
        coverUrl: 'https://example.com/book3.jpg',
        averageRating: 4.22,
        ratingsCount: 1038,
      ),
      Book(
        id: '4',
        title: 'Animal Farm',
        authors: ['George Orwell'],
        coverUrl: 'https://example.com/book4.jpg',
        averageRating: 4.01,
        ratingsCount: 4403,
      ),
      // Add more books...
    ];

    final List<Map<String, dynamic>> genres = [
      {'name': 'Fiction', 'icon': Icons.menu_book, 'color': Colors.blue},
      {'name': 'Mystery', 'icon': Icons.search, 'color': Colors.purple},
      {'name': 'Sci-Fi', 'icon': Icons.rocket_launch, 'color': Colors.green},
      {'name': 'Romance', 'icon': Icons.favorite, 'color': Colors.pink},
      {'name': 'Fantasy', 'icon': Icons.auto_awesome, 'color': Colors.orange},
      {'name': 'Non-Fiction', 'icon': Icons.lightbulb, 'color': Colors.red},
      {'name': 'Biography/Memoirs', 'icon': Icons.person, 'color': Colors.teal},
      {'name': 'History', 'icon': Icons.history, 'color': Colors.brown},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured books section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Popular Reads',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: featuredBooks.length,
              itemBuilder: (context, index) {
                return BookCard(
                  book: featuredBooks[index],
                  onTap: () {
                    // Navigate to book details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(
                          book: BookDetail(
                            id: featuredBooks[index].id,
                            title: featuredBooks[index].title,
                            authors: featuredBooks[index].authors,
                            coverUrl: featuredBooks[index].coverUrl,
                            averageRating: featuredBooks[index].averageRating,
                            ratingsCount: featuredBooks[index].ratingsCount,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Recommended books section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Recommended For You',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: recBooks.length,
              itemBuilder: (context, index) {
                return BookCard(
                  book: recBooks[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailScreen(
                          book: BookDetail(
                            id: recBooks[index].id,
                            title: recBooks[index].title,
                            authors: recBooks[index].authors,
                            coverUrl: recBooks[index].coverUrl,
                            averageRating: recBooks[index].averageRating,
                            ratingsCount: recBooks[index].ratingsCount,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Genre Reading section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Browse By Genre',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(
            height: 120, //height for genre tiles
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: genres.map((genre) {
                return GenreTile(
                  name: genre['name'],
                  icon: genre['icon'],
                  color: genre['color'],
                  onTap: () {
                    //navigate to genre page
                    print('Selected genre: ${genre['name']}');
                  },
                );
              }).toList(),
            ),
          ),
          // Add more sections...
        ],
      ),
    );
    bottomNavigationBar:
    BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.my_library_books),
          label: 'My Books',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Temporary mock data - we'll replace this with real data later
  final List<Book> featuredBooks = [
    Book(
      id: '1',
      title: 'The Midnight Library',
      authors: ['Matt Haig'],
      coverUrl: 'https://example.com/book1.jpg',
      averageRating: 4.2,
      ratingsCount: 1250,
    ),
    Book(
      id: '2',
      title: 'Project Hail Mary',
      authors: ['Andy Weir'],
      coverUrl: 'https://example.com/book2.jpg',
      averageRating: 4.5,
      ratingsCount: 980,
    ),
    Book(
      id: '3',
      title: 'Crime and Punishment',
      authors: ['Fyodor Dostoevsky'],
      coverUrl: 'https://example.com/book3.jpg',
      averageRating: 4.23,
      ratingsCount: 1038,
    ),
    Book(
      id: '4',
      title: 'The Way Of Kings',
      authors: ['Brandon Sanderson'],
      coverUrl: 'https://example.com/book4.jpg',
      averageRating: 4.67,
      ratingsCount: 6368,
    ),
    // Add more books...
  ];

  // mock recommended books
  final List<Book> recBooks = [
    Book(
      id: '1',
      title: 'Fourth Wing',
      authors: ['Rebecca Yarros'],
      coverUrl: 'https://example.com/book1.jpg',
      averageRating: 4.57,
      ratingsCount: 3238,
    ),
    Book(
      id: '2',
      title: 'Pride and Prejudice',
      authors: ['Jane Austen'],
      coverUrl: 'https://example.com/book2.jpg',
      averageRating: 4.29,
      ratingsCount: 4675,
    ),
    Book(
      id: '3',
      title: 'Piranesi',
      authors: ['Susanna Clarke'],
      coverUrl: 'https://example.com/book3.jpg',
      averageRating: 4.22,
      ratingsCount: 1038,
    ),
    Book(
      id: '4',
      title: 'Animal Farm',
      authors: ['George Orwell'],
      coverUrl: 'https://example.com/book4.jpg',
      averageRating: 4.01,
      ratingsCount: 4403,
    ),
    // Add more books...
  ];

  final List<Map<String, dynamic>> genres = [
    {'name': 'Fiction', 'icon': Icons.menu_book, 'color': Colors.blue},
    {'name': 'Mystery', 'icon': Icons.search, 'color': Colors.purple},
    {'name': 'Sci-Fi', 'icon': Icons.rocket_launch, 'color': Colors.green},
    {'name': 'Romance', 'icon': Icons.favorite, 'color': Colors.pink},
    {'name': 'Fantasy', 'icon': Icons.auto_awesome, 'color': Colors.orange},
    {'name': 'Non-Fiction', 'icon': Icons.lightbulb, 'color': Colors.red},
    {'name': 'Biography/Memoirs', 'icon': Icons.person, 'color': Colors.teal},
    {'name': 'History', 'icon': Icons.history, 'color': Colors.brown},
  ];

  // Function to handle navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of screens to display
  final List<Widget> _screens = [
    const HomeContent(),
    const MyBooksScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text('Bookish'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Navigate to search screen
                  },
                ),
              ],
            )
          : null,

      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'My Books',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
