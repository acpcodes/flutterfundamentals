import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igclone/data/classes/firestoreclass.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/models/usermodel.dart';
import 'package:igclone/providers/userprovider.dart';
import 'package:igclone/widgets/commentwidget.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  final snap;
  const CommentsPage({super.key, required this.snap});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController _commentController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileLightModeBGColor,
        title: const Text('Comments', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.snap()['postID'])
            .collection('comments')
            .orderBy('datePublished', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemBuilder: (context, index) =>
                CommentWidget(snap: (snapshot.data! as dynamic).docs[index].data()),
            itemCount: (snapshot.data! as dynamic).docs.length,
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(user!.photoUrl), radius: 28),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, right: 12),
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Comment as ${user.username}',
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () async {
                    await FirestoreClass().postComment(
                      widget.snap()['postID'],
                      _commentController.text,
                      user.uid,
                      user.username,
                      user.photoUrl,
                    );
                    setState(() {
                      _commentController.text = '';
                    });
                  },
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
