import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add a bookmark for a user
  Future<void> addBookmark(String userId, Map<String, dynamic> article) async {
    try {
      await _firestore
          .collection('bookmarks')
          .doc(userId)
          .collection('articles')
          .doc(article['id']) // Assuming each article has a unique ID
          .set(article);
    } catch (e) {
      print('Error adding bookmark: $e');
    }
  }

  /// Remove a bookmarked article
  Future<void> removeBookmark(String userId, String articleId) async {
    try {
      await _firestore
          .collection('bookmarks')
          .doc(userId)
          .collection('articles')
          .doc(articleId)
          .delete();
    } catch (e) {
      print('Error removing bookmark: $e');
    }
  }

  /// Check if an article is bookmarked by a user
  Future<bool> isBookmarked(String userId, String articleId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('bookmarks')
          .doc(userId)
          .collection('articles')
          .doc(articleId)
          .get();
      return doc.exists;
    } catch (e) {
      print('Error checking bookmark: $e');
      return false;
    }
  }

  /// Get all bookmarked articles for a user
  Future<List<Map<String, dynamic>>> getBookmarkedArticles(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('bookmarks')
          .doc(userId)
          .collection('articles')
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching bookmarks: $e');
      return [];
    }
  }
}
