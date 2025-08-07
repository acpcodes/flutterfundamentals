import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igclone/data/classes/storageclass.dart';
import 'package:igclone/models/usermodel.dart'
    as model;
// import 'package:flutter/material.dart';

class AuthClass {
  final FirebaseAuth _auth =
      FirebaseAuth.instance;
  final FirebaseFirestore _fireStore =
      FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _fireStore
        .collection('users')
        .doc(currentUser.uid)
        .get();

    return model.User.fromSnap(snap);
  }

  //!signup
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required Uint8List file,
    required String bio,
  }) async {
    String res = 'Some error occured';
    try {
      // ignore: unnecessary_null_comparison
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        //!register user
        UserCredential cred = await _auth
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
        String photoUrl = await StorageClass()
            .uploadImageToStorage(
              'profilePics',
              file,
              false,
            );
        //! add user to database
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          followers: [],
          following: [],
          photoUrl: photoUrl,
          bio: bio,
        );
        await _fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "Success!";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //!login of user function
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'Success!';
      } else {
        res = "Please enter all fields!";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //!logout of user function
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
