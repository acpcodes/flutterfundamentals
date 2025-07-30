import 'package:flutter/material.dart';
import 'package:igclone/data/constants.dart';

class AddNewPage extends StatefulWidget {
  const AddNewPage({super.key});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileLightModeBGColor,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Text(
          'Post to',
          style: TextStyle(color: mobileDarkModeBGColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          // TextButton(
          //   onPressed: () {},
          //   child: const Text(
          //     'Story',
          //     style: TextStyle(
          //       color: mobileDarkModeBGColor,
          //       fontSize: 16,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Feed',
              style: TextStyle(
                color: mobileDarkModeBGColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(
                    'https://static.wikia.nocookie.net/timberborn/images/7/70/Folktails_Portrait.png/revision/latest?cb=20210401105132',
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Caption Here', border: InputBorder.none),
                    maxLines: 8,
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://wallpaper.dog/large/20628130.jpg'),

                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
