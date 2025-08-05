import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  // int _selectedIndex = 0;
  // final List<Widget> _pages = homeScreenItems;
  // void _onNavBarTap(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/logos/iglogoblack.svg', height: 64),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 4),
            child: IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.house, size: 28)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 4),
            child: IconButton(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.magnifyingGlass, size: 28),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 4),
            child: IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.upload, size: 28)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 4),
            child: IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.video, size: 28)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 4),
            child: IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.circleUser, size: 28)),
          ),
        ],
      ),
    );
  }
}
