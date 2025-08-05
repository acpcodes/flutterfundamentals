import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igclone/views/pages/addnewpage.dart';
import 'package:igclone/views/pages/homepage.dart';
import 'package:igclone/views/pages/profilepage.dart';
import 'package:igclone/views/pages/reelspage.dart';
import 'package:igclone/views/pages/searchpage.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  HomePage(),
  SearchPage(),
  AddNewPage(),
  ReelsPage(),
  ProfilePage(uid: FirebaseAuth.instance.currentUser!.uid),
];
