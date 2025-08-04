import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igclone/data/classes/firestoreclass.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/data/utils.dart';
import 'package:igclone/models/usermodel.dart';
import 'package:igclone/providers/userprovider.dart';
import 'package:igclone/views/pages/commentspage.dart';
import 'package:igclone/widgets/likeanimationwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final snap;

  const FeedWidget({super.key, required this.snap});

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  bool isLikeAnimating = false;
  int commentLength = 0;
  @override
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap()['postID'])
          .collection('comments')
          .get();
      commentLength = snap.docs.length;
    } catch (e) {
      if (mounted) {
        showSnackBar(e.toString(), context);
      }
    }

    // The key fix is here:
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16).copyWith(right: 0),
            child: Row(
              children: [
                //!Header Section
                CircleAvatar(radius: 32, backgroundImage: NetworkImage(widget.snap()['profImage'])),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap()['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ['Delete']
                              .map(
                                (e) => InkWell(
                                  onTap: () async {
                                    FirestoreClass().deletePost(widget.snap()['postID']);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(FontAwesomeIcons.ellipsisVertical),
                ),
              ],
            ),
            //! Image Section
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FirestoreClass().likePost(
                widget.snap()['postID'],
                user!.uid,
                widget.snap()['likes'],
              );
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: Image.network(widget.snap()['photoUrl'], fit: BoxFit.cover),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimationWidget(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: Icon(FontAwesomeIcons.solidHeart, color: Colors.red.shade500, size: 110),
                  ),
                ),
              ],
            ),
          ),
          //!Footer Section - Like button etc
          Row(
            children: [
              LikeAnimationWidget(
                isAnimating: widget.snap()['likes'].contains(user?.uid),
                smallLike: true,
                child: IconButton(
                  onPressed: () async => await FirestoreClass().likePost(
                    widget.snap()['postID'],
                    user!.uid,
                    widget.snap()['likes'],
                  ),
                  icon: widget.snap()['likes'].contains(user?.uid)
                      ? Icon(FontAwesomeIcons.solidHeart, color: Colors.red.shade500, size: 26)
                      : Icon(FontAwesomeIcons.heart, size: 26),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => CommentsPage(snap: widget.snap))),
                icon: Icon(FontAwesomeIcons.comment, size: 26),
              ),
              IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.paperPlane, size: 23.5)),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.bookmark)),
                ),
              ),
            ],
          ),
          //! Footer section - Caption and comments.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${widget.snap()['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: mobileDarkModeBGColor),
                      children: [
                        TextSpan(
                          text: widget.snap()['username'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${widget.snap()['description']}'),
                      ],
                    ),
                  ),
                ),
                commentLength > 0
                    ? InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'View All $commentLength comments',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    DateFormat.yMMMd().format(widget.snap()['datePublished'].toDate()),
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
