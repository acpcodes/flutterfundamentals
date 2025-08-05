import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igclone/data/classes/authclass.dart';
import 'package:igclone/data/classes/firestoreclass.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/views/pages/editprofilepage.dart';
import 'package:igclone/views/pages/loginpage.dart';
import 'package:igclone/widgets/followwidget.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: currentUserId)
          .get();
      postLength = postSnap.docs.length;
      userData = userSnap.data()! as Map<String, dynamic>;
      followers = (userSnap.data()! as Map<String, dynamic>)['followers'].length;
      following = (userSnap.data()! as Map<String, dynamic>)['following'].length;
      isFollowing = (userSnap.data()! as Map<String, dynamic>)['followers'].contains(
        FirebaseAuth.instance.currentUser!.uid,
      );
      setState(() {});
    } catch (e) {
      // if (mounted) {
      //   showSnackBar(e.toString(), context);
      // }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userData.isEmpty || isLoading == true) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileLightModeBGColor,
        title: Text(userData['username']),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.solidMoon)),
          IconButton(
            onPressed: () {
              showAlertDialog(context);
            },
            icon: Icon(FontAwesomeIcons.arrowRightFromBracket),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(userData['photoUrl']),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildStatColumn(postLength, "posts"),
                              buildStatColumn(followers, "followers"),
                              buildStatColumn(following, "following"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FirebaseAuth.instance.currentUser?.uid == widget.uid
                                  ? FollowWidget(
                                      text: 'Edit Profile',
                                      backgroundColor: mobileLightModeBGColor,
                                      textColor: Colors.black,
                                      borderColor: Colors.grey,
                                      function: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const EditProfilePage(),
                                          ),
                                        );
                                      },
                                    )
                                  : isFollowing
                                  ? FollowWidget(
                                      text: 'Unfollow',
                                      backgroundColor: mobileLightModeBGColor,
                                      textColor: Colors.black,
                                      borderColor: Colors.grey,
                                      function: () async {
                                        await FirestoreClass().followUser(
                                          FirebaseAuth.instance.currentUser!.uid,
                                          userData['uid'],
                                        );
                                        setState(() {
                                          isFollowing = false;
                                          followers--;
                                        });
                                      },
                                    )
                                  : FollowWidget(
                                      text: 'Follow',
                                      backgroundColor: Colors.blueAccent,
                                      textColor: Colors.white,
                                      borderColor: Colors.blueAccent,
                                      function: () async {
                                        await FirestoreClass().followUser(
                                          FirebaseAuth.instance.currentUser!.uid,
                                          userData['uid'],
                                        );
                                        setState(() {
                                          isFollowing = true;
                                          followers++;
                                        });
                                      },
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    userData['username'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 1),
                  //!Implement Bio for user. userData['bio']
                  child: Text(
                    userData['bio'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('posts')
                .where('uid', isEqualTo: widget.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 1.5,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                  return Image(image: NetworkImage(snap['photoUrl']), fit: BoxFit.cover);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(num.toString(), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Container(
          margin: EdgeInsets.only(top: 1),
          child: Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Signout"),
      onPressed: () {
        AuthClass().signOut();
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Signout"),
      content: Text("Are you sure you wanna signout"),
      actions: [cancelButton, continueButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
