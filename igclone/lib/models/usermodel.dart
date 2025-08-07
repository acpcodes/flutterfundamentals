import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final List followers;
  final List following;
  final String photoUrl;
  final String bio;

  const User({
    required this.username,
    required this.uid,
    required this.email,
    required this.followers,
    required this.following,
    required this.photoUrl,
    required this.bio,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'uid': uid,
    'email': email,
    'photoUrl': photoUrl,
    'followers': followers,
    'following': following,
    'bio': bio,
  };

  static User fromSnap(DocumentSnapshot snap) {
    // Check if snap.data() is null before trying to cast.
    if (snap.data() == null) {
      return User(
        username: '',
        uid: '',
        email: '',
        photoUrl: '',
        followers: [],
        following: [],
        bio: '',
      );
    }
    var snapshot =
        snap.data()! as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      bio: snapshot['bio'],
    );
  }
}
