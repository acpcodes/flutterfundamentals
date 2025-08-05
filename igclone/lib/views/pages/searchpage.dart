import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/views/pages/profilepage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;

  @override
  void initState() {
    super.initState();
    // Add a listener to the controller to handle real-time UI changes
    searchController.addListener(() {
      setState(() {
        isShowUser = searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileLightModeBGColor,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search for a user',
            border: InputBorder.none,
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUser = true;
            });
          },
        ),
      ),
      body: isShowUser
          ? FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('username', isGreaterThanOrEqualTo: searchController.text)
                  .where('username', isLessThan: '${searchController.text}\uf8ff')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No users found.'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final userData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfilePage(uid: userData['uid'])),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(userData['photoUrl'])),
                        title: Text(userData['username']),
                      ),
                    );
                  },
                );
              },
            )
          : FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final posts = snapshot.data!.docs;

                return StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  children: List.generate(posts.length, (index) {
                    final post = posts[index];
                    final imageUrl = post['photoUrl'];

                    final patternIndex = index % 10;

                    int crossAxisCellCount;
                    int mainAxisCellCount;

                    switch (patternIndex) {
                      case 4:
                        crossAxisCellCount = 2;
                        mainAxisCellCount = 2;
                        break;
                      case 5:
                        crossAxisCellCount = 1;
                        mainAxisCellCount = 2;
                        break;
                      default:
                        crossAxisCellCount = 1;
                        mainAxisCellCount = 1;
                    }

                    return StaggeredGridTile.count(
                      crossAxisCellCount: crossAxisCellCount,
                      mainAxisCellCount: mainAxisCellCount,
                      child: Image.network(imageUrl, fit: BoxFit.cover),
                    );
                  }),
                );
              },
            ),
    );
  }
}
