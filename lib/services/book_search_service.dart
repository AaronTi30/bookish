import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env.dart';

class BookSearchService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  static Future<List<Map<String, dynamic>>> searchBooks(
    String query, {
    int maxResults = 20,
    String sortBy = 'relevance',
  }) async {
    try {
      final encodedQuery = Uri.encodeQueryComponent(query);

      // Build URL without API key first (works for basic searches)
      String url =
          '$_baseUrl?q=$encodedQuery&maxResults=$maxResults&orderBy=$sortBy';

      // Only add API key if available (for higher rate limits)
      final apiKey = Env.googleBooksApiKey;
      if (apiKey.isNotEmpty) {
        url += '&key=$apiKey';
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] as List?;

        if (items == null || items.isEmpty) {
          return [];
        }

        return items.map((item) {
          final volumeInfo = item['volumeInfo'] ?? {};
          final saleInfo = item['saleInfo'] ?? {};

          return {
            'id': item['id'],
            'title': volumeInfo['title'] ?? 'Unknown Title',
            'authors':
                (volumeInfo['authors'] as List?)?.cast<String>() ??
                ['Unknown Author'],
            'publishedDate': volumeInfo['publishedDate'],
            'description': volumeInfo['description'],
            'pageCount': volumeInfo['pageCount'],
            'categories': (volumeInfo['categories'] as List?)?.cast<String>(),
            'averageRating': volumeInfo['averageRating']?.toDouble(),
            'ratingsCount': volumeInfo['ratingsCount'],
            'thumbnail': volumeInfo['imageLinks']?['thumbnail'],
            'previewLink': volumeInfo['previewLink'],
            'infoLink': volumeInfo['infoLink'],
            'isEbook': saleInfo['isEbook'] ?? false,
            'buyLink': saleInfo['buyLink'],
          };
        }).toList();
      } else if (response.statusCode == 403) {
        throw Exception('API rate limit exceeded. Please try again later.');
      } else {
        throw Exception('Failed to load books: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }
}
