import 'package:cloud_firestore/cloud_firestore.dart';

class PostController{
  final FirebaseFirestore _firestore;

  PostController({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addPost(String message, String username) async {
    await _firestore.collection('posts').add({
      'message': message,
      'username': username,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
