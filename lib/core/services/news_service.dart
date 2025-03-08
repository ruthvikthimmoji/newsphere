import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static Future<List> fetchNews(int pageIndex) async {
    final String apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
    final String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey&page=$pageIndex&pageSize=10';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['articles'];
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
    return [];
  }
}
