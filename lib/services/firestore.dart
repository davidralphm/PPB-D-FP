import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // Get collection of notes from database
  final CollectionReference favorites =  FirebaseFirestore.instance.collection('favorites');

  // Get current user
  final user = FirebaseAuth.instance.currentUser;

  // CREATE
  Future<void> addFavorite(String url) async {
    final doc = await favorites.doc(user?.uid).get();
    List favList = [];

    try {
      final data = doc.data() as Map<String, dynamic>;
      favList = data['url'];
    } catch (e) {
      print(e.toString());
    }

    favList.add(url);

    Map<String, dynamic> newData = {
      'url': favList
    };

    return favorites.doc(user?.uid).set(newData);
  }

  // READ
  Stream<DocumentSnapshot> getFavoritesStream() {
    final favStream = favorites.doc(user?.uid).snapshots();

    return favStream;
  }

  Future<List> getFavoritesList() async {
    List favList = [];

    final doc = await favorites.doc(user?.uid).get();

    try {
      final data = doc.data() as Map<String, dynamic>;
      favList = data['url'];
    } catch (e) {

    }

    return favList;
  }

  // // UPDATE
  // Future<void> updateFavorite(String url, String newUrl) async {
  //   final doc = await favorites.doc(user?.uid).get();
  //   final data = doc.data() as Map<String, dynamic>;

  //   List favList = data['url'];
  //   favList.add('edit${Timestamp.now()}');

  //   return favorites.doc(user?.uid).update({
  //     'url': favList,
  //     'timestamp': Timestamp.now()
  //   });
  // }

  // DELETE
  Future<void> deleteFavorite(String url) async {
    final doc = await favorites.doc(user?.uid).get();
    List favList = [];

    try {
      final data = doc.data() as Map<String, dynamic>;
      favList = data['url'];
    } catch (e) {
      print(e.toString());
    }

    favList.remove(url);

    Map<String, dynamic> newData = {
      'url': favList
    };

    return favorites.doc(user?.uid).set(newData);
  }
}