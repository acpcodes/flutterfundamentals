import 'package:flutter/material.dart';
import 'package:igclone/data/constants.dart';

class FeedWidget1 extends StatelessWidget {
  const FeedWidget1({super.key, required this.child});
  final String child;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileLightModeBGColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Container(
          height: 600,
          width: 320,
          color: Colors.green,
          child: Center(child: Text(child, style: TextStyle(fontSize: 30))),
        ),
      ),
    );
  }
}
