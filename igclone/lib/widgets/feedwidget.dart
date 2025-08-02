import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igclone/data/constants.dart';
// import 'package:igclone/data/constants.dart';

class FeedWidget extends StatelessWidget {
  const FeedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16).copyWith(right: 0),
            child: Row(
              children: [
                //!Header Section
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(
                    'https://thumbs.dreamstime.com/b/businessman-hands-overwhelmed-documents-office-stress-multitasking-project-person-crisis-time-management-chaos-367483579.jpg?w=992',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('UserName', style: TextStyle(fontWeight: FontWeight.bold))],
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
                                  onTap: () {},
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              'https://thumbs.dreamstime.com/b/autumn-nature-landscape-colorful-forest-autumn-nature-landscape-colorful-forest-morning-sunlight-131400332.jpg?w=992',
              fit: BoxFit.cover,
            ),
          ),
          //!Footer Section
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.solidHeart, color: Colors.red, size: 26),
              ),
              IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.comment, size: 26)),
              IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.paperPlane, size: 23.5)),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.bookmark)),
                ),
              ),
            ],
          ),
          //! Caption and comments.
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
                  child: Text('999 likes', style: Theme.of(context).textTheme.bodyMedium),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: mobileDarkModeBGColor),
                      children: [
                        TextSpan(
                          text: 'username',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' Caption here'),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      'View All 3 comments',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    '02/08/2025',
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
