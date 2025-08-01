import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igclone/data/classes/storageclass.dart';
import 'package:igclone/models/postmodel.dart';
import 'package:uuid/uuid.dart';

class FirestoreClass {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String postID = const Uuid().v1();
    String res = 'Some error occurred';
    try {
      String photoUrl = await StorageClass().uploadImageToStorage('post', file, true);
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postID: postID,
        datePublished: DateTime.now(),
        photoUrl: photoUrl,
        profImage: profImage,
        likes: [],
      );
      _firestore.collection('posts').doc(postID).set(post.toJson());
      res = 'Success!';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
