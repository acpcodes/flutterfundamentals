import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igclone/data/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igclone/widgets/feedwidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileLightModeBGColor,
      appBar: AppBar(
        title: SvgPicture.asset('assets/logos/iglogoblack.svg', height: 64),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 4),
            child: IconButton(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.facebookMessenger, size: 28),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(itemBuilder: (context, index) => FeedWidget());
        },
      ),
    );
  }
}
