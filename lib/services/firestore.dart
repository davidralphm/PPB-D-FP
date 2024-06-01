import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // Get collection of notes from database
  final CollectionReference favorites =  FirebaseFirestore.instance.collection('favorites');

  // Get current user
  final user = FirebaseAuth.instance.currentUser!;

  // CREATE
  Future<void> addFavorite(String url) {
    return favorites.add({
      'url': url,
      'timestamp': Timestamp.now()
    });
  }

  // READ
  Stream<DocumentSnapshot> getFavoritesStream() {
    // final favStream = favorites.orderBy('timestamp', descending: true).snapshots();
    // final favStream = favorites.where('documentId', isEqualTo: user.uid).orderBy('timestamp', descending: false).snapshots();
    // final favStream = favorites.where('docid', isEqualTo: user.uid).snapshots();
    final favStream = favorites.doc(user.uid).snapshots();

    return favStream;
  }

  // UPDATE
  Future<void> updateFavorite(String url, String newUrl) async {
    final doc = await favorites.doc(user.uid).get();
    final data = doc.data() as Map<String, dynamic>;

    print(data);

    List favList = data['url'];
    favList.add('edit${Timestamp.now()}');

    return favorites.doc(user.uid).update({
      'url': favList,
      'timestamp': Timestamp.now()
    });
  }

  // DELETE
  Future<void> deleteNote(String docID) {
    return favorites.doc(docID).delete();
  }
}