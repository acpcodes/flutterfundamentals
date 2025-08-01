import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postID;
  final datePublished;
  final String photoUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postID,
    required this.datePublished,
    required this.photoUrl,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
    'description': description,
    'username': username,
    'uid': uid,
    'postID': postID,
    'datePublished': datePublished,
    'photoUrl': photoUrl,
    'profImage': profImage,
    'likes': likes,
  };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      description: '',
      uid: '',
      username: '',
      postID: '',
      datePublished: '',
      photoUrl: '',
      profImage: '',
      likes: null,
    );
  }
}
