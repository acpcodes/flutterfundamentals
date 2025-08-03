import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igclone/data/constants.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileLightModeBGColor,
        title: const Text('Comments', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      //TODO: Comment widget.
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://static.wikia.nocookie.net/eternal-supreme/images/5/5b/Li_Yunxiao_%282%29.jpg/revision/latest?cb=20230807212958',
                ),
                radius: 36,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, right: 12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Comment as username',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: const Icon(FontAwesomeIcons.paperPlane, size: 28),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
