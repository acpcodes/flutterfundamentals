import 'package:flutter/material.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/widgets/feedwidget.dart';
import 'package:igclone/widgets/storieswidget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _posts = ['post 1', 'post 2', 'post 3', 'post 4', 'post 5'];
  final List _stories = ['story 1', 'story 2', 'story 3', 'story 4', 'story 5', 'story 6'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileLightModeBGColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, // status bar height
              left: 16,
              right: 5,
            ),
            height: MediaQuery.of(context).padding.top + 50,
            color: mobileLightModeBGColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/logos/logoblacktext.svg', height: 35),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.favorite, size: 28, color: Colors.grey[800]),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.send, size: 28, color: Colors.grey[800]),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: _stories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return StoriesWidget(child: _stories[index]);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return FeedWidget(child: _posts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
