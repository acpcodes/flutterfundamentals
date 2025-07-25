import 'package:flutter/material.dart';

class FeedWidget extends StatelessWidget {
  const FeedWidget({super.key, required this.child});
  final String child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
        height: 500,
        width: 320,
        color: Colors.green,
        child: Center(child: Text(child, style: TextStyle(fontSize: 30))),
      ),
    );
  }
}
