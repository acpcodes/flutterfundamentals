import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igclone/data/classes/storageclass.dart';
import 'package:igclone/models/postmodel.dart';
import 'package:uuid/uuid.dart';

class FirestoreClass {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //! UPLOAD POST
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

  //!LIKE POST
  Future<void> likePost(String postID, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postID).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> postComment(
    String postID,
    String text,
    String uid,
    String name,
    String profilePic,
  ) async {
    try {
      if (text.isNotEmpty) {
        String commentID = const Uuid().v1();
        _firestore.collection('posts').doc(postID).collection('comments').doc(commentID).set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentID': commentID,
          'datePublished': DateTime.now(),
        });
      } else {}
    } catch (e) {
      //do nothing
    }
  }

  //!Delete post function
  Future<void> deletePost(String postID) async {
    try {
      await _firestore.collection('posts').doc(postID).delete();
    } catch (e) {
      //do nothing
    }
  }

  Future<void> followUser(String uid, String followID) async {
    try {
      DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followID)) {
        await _firestore.collection('users').doc(followID).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followID]),
        });
      } else {
        await _firestore.collection('users').doc(followID).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followID]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
