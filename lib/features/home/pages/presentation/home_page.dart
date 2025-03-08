import 'package:flutter/material.dart';
import 'package:news_sphere/features/bookmarks/presentation/bookmark_page.dart';
import 'package:news_sphere/features/home/pages/presentation/news_feed_article.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch next 10 articles when 80% scrolled
  }

  @override
  void dispose() {
    super.dispose();
  }

  // List of Pages for Navigation
  final List<Widget> _pages = [
    NewsFeedArticlePage(), // News feed article page
    ProfilePage(), // Profile page
    BookmarksPage()
  ];

  // Handle BottomNavigationBar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.redAccent,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined, color: Colors.black),
              label: "Articles",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.black),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark, color: Colors.black),
              label: "Bookmarks",
            ),
          ],
        ),
        body: _pages[_selectedIndex]);
  }
}
