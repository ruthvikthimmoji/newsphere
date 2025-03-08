import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_sphere/features/auth/domain/auth.dart';

class BookmarkService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String generateHashId(String url) {
    return sha256.convert(utf8.encode(url)).toString();
  }

  /// Add a bookmark for a user
  static Future<void> addBookmark(Map<String, dynamic> article) async {
    String userId = Auth.currentUser!.uid;
    String docId = generateHashId(article['url']);
    try {
      await _firestore
          .collection('bookmarks')
          .doc(userId)
          .collection('articles')
          .doc(docId) // Assuming each article has a unique ID
          .set(article);
    } catch (e) {
      print('Error adding bookmark: $e');
    }
  }

  /// Remove a bookmarked article
  static Future<void> removeBookmark(Map<String, dynamic> article) async {
    String userId = Auth.currentUser!.uid;
    String docId = generateHashId(article['url']);
    try {
      await _firestore
          .collection('bookmarks')
          .doc(userId)
          .collection('articles')
          .doc(docId)
          .delete();
    } catch (e) {
      print('Error removing bookmark: $e');
    }
  }

  /// Check if an article is bookmarked by a user
  static Future<bool> isBookmarked(Map<String, dynamic> article) async {
    String userId = Auth.currentUser!.uid;
    String docId = generateHashId(article['url']);
    try {
      DocumentSnapshot doc = await _firestore
          .collection('bookmarks')
          .doc(userId)
          .collection('articles')
          .doc(docId)
          .get();
      return doc.exists;
    } catch (e) {
      print('Error checking bookmark: $e');
      return false;
    }
  }

  /// Get all bookmarked articles for a user
  static Future<List<Map<String, dynamic>>> getBookmarkedArticles() async {
    String userId = Auth.currentUser!.uid;
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
