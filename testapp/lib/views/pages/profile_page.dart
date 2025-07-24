import 'package:flutter/material.dart';
import 'package:testapp/data/constants.dart';
import 'package:testapp/data/notifiers.dart';
import 'package:testapp/views/pages/welcome_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ListTile(
            title: Text('logout', style: KTextStyle.titleTealText),
            onTap: () {
              selectedPageNotifier.value = 1;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WelcomePage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
