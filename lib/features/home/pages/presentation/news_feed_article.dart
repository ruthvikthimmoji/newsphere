import 'package:flutter/material.dart';
import 'package:news_sphere/core/services/news_service.dart';

class NewsFeedArticlePage extends StatefulWidget {
  const NewsFeedArticlePage({super.key});

  @override
  State<NewsFeedArticlePage> createState() => _NewsFeedArticlePageState();
}

class _NewsFeedArticlePageState extends State<NewsFeedArticlePage> {
  List articles = [];
  int pageIndex = 1;
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchNews();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.8) {
        fetchNews(); // Fetch next 10 articles when 80% scrolled
      }
    });
  }

  Future<void> fetchNews() async {
    if (_isLoading) return; // Prevent multiple requests

    setState(() {
      _isLoading = true;
    });

    List newArticles = await NewsService.fetchNews(pageIndex);

    setState(() {
      if (newArticles.isNotEmpty) {
        articles.addAll(newArticles);
        pageIndex++; // Increase page for next request
      }
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Articles Feed",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          leading: const Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Icon(Icons.account_circle_rounded,
                color: Colors.black, size: 28),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert_outlined,
                  color: Colors.black, size: 26),
              onPressed: () {},
            ),
          ],
        ),
        body: articles.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
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
                              child: Icon(Icons.image_not_supported)),
                      title: Text(article['title'] ?? 'No Title',
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      subtitle: Text(article['description'] ?? 'No Description',
                          maxLines: 2, overflow: TextOverflow.ellipsis),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(article['title']),
                            content: Text(
                                article['content'] ?? 'No content available'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ));
  }
}
