import 'package:flutter/material.dart';
import 'package:igclone/data/constants.dart';

class StoriesWidget extends StatelessWidget {
  const StoriesWidget({super.key, required this.child});
  final String child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileLightModeBGColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
          child: Center(child: Text(child, style: TextStyle(fontSize: 20))),
        ),
      ),
    );
  }
}
