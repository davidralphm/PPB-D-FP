import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // Get collection of favorites and comments from database
  final CollectionReference favorites =  FirebaseFirestore.instance.collection('favorites');
  final CollectionReference comments = FirebaseFirestore.instance.collection('comments');
  final CollectionReference history = FirebaseFirestore.instance.collection('history');

  // Get current user
  final user = FirebaseAuth.instance.currentUser;

  // CREATE COMMENT
  Future<void> addComment(String newsGuid, String userUid, String username, String comment) {
    final Map<String, dynamic> data = {
      'newsGuid': newsGuid,
      'userUid': userUid,
      'username': username,
      'comment': comment,
      'timestamp': Timestamp.now()
    };

    return comments.add(data);
  }

  // CREATE FAVORITES
  Future<void> addFavorite(
    String title,
    String subtitle,
    String publishDate,
    String author,
    String link,
    String guid
  ) async {
    final doc = await favorites.doc(user?.uid).get();
    Map<String, dynamic> favList = {};

    try {
      favList = doc.data() as Map<String, dynamic>;
    } catch (e) {
      print(e.toString());
    }

    Map<String, dynamic> newData = {
      'title': title,
      'subtitle': subtitle,
      'publishDate': publishDate,
      'author': author,
      'link': link
    };

    favList[guid] = newData;

    return favorites.doc(user?.uid).set(favList);
  }

  // CREATE HISTORY
  Future<void> addHistory(
    String title,
    String subtitle,
    String publishDate,
    String author,
    String link,
    String guid
  ) async {
    final doc = await history.doc(user?.uid).get();
    Map<String, dynamic> historyList = {};

    try {
      historyList = doc.data() as Map<String, dynamic>;
    } catch (e) {
      print(e.toString());
    }

    Map<String, dynamic> newData = {
      'title': title,
      'subtitle': subtitle,
      'publishDate': publishDate,
      'author': author,
      'link': link
    };

    historyList[guid] = newData;

    return history.doc(user?.uid).set(historyList);
  }

  // READ COMMENTS
  Stream<QuerySnapshot> getCommentsStream(String newsGuid) {
    final commentStream = comments.where('newsGuid', isEqualTo: newsGuid).orderBy('timestamp').snapshots();

    return commentStream;
  }

  // READ FAVORITES
  Stream<DocumentSnapshot> getFavoritesStream() {
    final favStream = favorites.doc(user?.uid).snapshots();

    return favStream;
  }

  Future<Map<String, dynamic>> getFavoritesList() async {
    Map<String, dynamic> favList = {};

    final doc = await favorites.doc(user?.uid).get();

    try {
      favList = doc.data() as Map<String, dynamic>;
    } catch (e) {
      print(e.toString());
    }

    return favList;
  }

  // READ HISTORY
  Stream<DocumentSnapshot> getHistoryStream() {
    final historyStream = history.doc(user?.uid).snapshots();

    return historyStream;
  }

  // UPDATE COMMENT
  Future<void> updateComment(String docId, String comment) {
    final Map<String, dynamic> newData = {
      'comment': comment,
    };

    return comments.doc(docId).update(newData);
  }

  // DELETE COMMENT
  Future<void> deleteComment(String docId) {
    return comments.doc(docId).delete();
  }

  // DELETE FAVORITE
  Future<void> deleteFavorite(String guid) async {
    final doc = await favorites.doc(user?.uid).get();
    Map<String, dynamic> favList = {};

    try {
      favList = doc.data() as Map<String, dynamic>;
      // final data = doc.data() as Map<String, dynamic>;
      // favList = data['url'];
    } catch (e) {
      print(e.toString());
    }

    favList.remove(guid);

    // print('Removing $guid');

    return favorites.doc(user?.uid).set(favList);
  }

  // DELETE HISTORY
  Future<void> deleteHistory(String guid) async {
    final doc = await history.doc(user?.uid).get();
    Map<String, dynamic> historyList = {};

    try {
      historyList = doc.data() as Map<String, dynamic>;
    } catch (e) {
      print(e.toString());
    }

    historyList.remove(guid);

    return history.doc(user?.uid).set(historyList);
  }
}