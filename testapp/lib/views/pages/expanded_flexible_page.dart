import 'package:flutter/material.dart';

class ExpandedFlexiblePage extends StatelessWidget {
  const ExpandedFlexiblePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(color: Colors.teal, height: 20, child: Text('Hello')),
                ),
                Flexible(
                  child: Container(color: Colors.yellow, height: 20, child: Text('Hello')),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: Container(color: Colors.yellow, height: 20, child: Text('Hello')),
                ),
                Expanded(
                  child: Container(color: Colors.teal, height: 20, child: Text('Hello')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
