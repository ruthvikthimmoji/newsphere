import 'package:flutter/material.dart';
import 'package:news_sphere/core/services/bookmark_service.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List articles = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchBookmarks();
  }

  Future<void> fetchBookmarks() async {
    setState(() {
      _isLoading = true;
    });

    List newArticles = await BookmarkService.getBookmarkedArticles();

    setState(() {
      articles = newArticles;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Bookmarks",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child:
              Icon(Icons.account_circle_rounded, color: Colors.black, size: 28),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black, size: 26),
            onPressed: fetchBookmarks, // Refresh bookmarks
          ),
        ],
      ),
      body: articles.isEmpty
          ? (_isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(child: Text("No Bookmarks")))
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: article['urlToImage'] != null
                        ? Image.network(article['urlToImage'],
                            width: 40, fit: BoxFit.cover)
                        : const SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.image_not_supported),
                          ),
                    title: Text(article['title'] ?? 'No Title',
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    subtitle: Text(article['description'] ?? 'No Description',
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                );
              },
            ),
    );
  }
}
