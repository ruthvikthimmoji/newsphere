import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_sphere/data/news_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    _isLoading = true;

    List newArticles = await NewsService.fetchNews(pageIndex);

    setState(() {
      if (newArticles.isNotEmpty) {
        articles.addAll(newArticles);
        pageIndex++; // Increase page for next request
      }
    });

    _isLoading = false;
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
        title: Text(
          "Newsphere",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true, // Centers the title for a balanced UI
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child:
              Icon(Icons.account_circle_rounded, color: Colors.black, size: 28),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert_outlined, color: Colors.black, size: 26),
            onPressed: () {
              // Action for more options
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.redAccent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
              size: 24,
            ),
            // activeIcon: Icon(Icons.home, color: Colors.blue),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined, color: Colors.black),
            // activeIcon: Icon(Icons.article, color: Colors.blue),
            label: "Articles",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline, color: Colors.black),
            // activeIcon: Icon(Icons.bookmark, color: Colors.blue),
            label: "Bookmarks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined, color: Colors.black),
            // activeIcon: Icon(Icons.notifications, color: Colors.blue),
            label: "Notifications",
          ),
        ],
      ),
      body: articles.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: article['urlToImage'] != null
                        ? Image.network(article['urlToImage'],
                            width: 100, fit: BoxFit.cover)
                        : SizedBox(
                            width: 100,
                            height: 100,
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
                              child: Text('Close'),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      //   body: SafeArea(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20.0, top: 20.0),
      //           child: Text(
      //             "Let’s find the latest news around you!",
      //           ),
      //         ),
      //         Container(
      //           margin: EdgeInsets.all(20),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(50),
      //             border: Border.all(
      //               color: Colors.blue,
      //             ),
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 18.0),
      //                 child: Icon(Icons.search),
      //               ),
      //               Text("Search"),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 18.0),
      //                 child: IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
      //               )
      //             ],
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(18.0),
      //           child: Text("Trending"),
      //         )
      //       ],
      //     ),
      //   ),
    );
  }
}
