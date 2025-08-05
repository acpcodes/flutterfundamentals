import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:igclone/data/notifiers.dart';
import 'package:igclone/views/pages/addnewpage.dart';
import 'package:igclone/views/pages/homepage.dart';
import 'package:igclone/views/pages/profilepage.dart';
import 'package:igclone/views/pages/reelspage.dart';
import 'package:igclone/views/pages/searchpage.dart';

List<Widget> pages = [
  HomePage(),
  SearchPage(),
  AddNewPage(),
  ReelsPage(),
  ProfilePage(uid: FirebaseAuth.instance.currentUser!.uid),
];

class MainTree extends StatelessWidget {
  const MainTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      // bottomNavigationBar: BottomNavWidget(),
    );
  }
}
