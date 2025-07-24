import 'package:flutter/material.dart';
import 'package:testapp/data/constants.dart';
import 'package:testapp/views/pages/course_page.dart';
import 'package:testapp/widgets/container_widget.dart';
import 'package:testapp/widgets/hero_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> list = [
      KValue.basicLayout,
      KValue.cleanUI,
      KValue.fixBugs,
      KValue.keyConcepts,
      KValue.misc,
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            HeroWidget(title: 'Homepage', nextPage: CoursePage()),
            SizedBox(height: 5),
            ...List.generate(list.length, (index) {
              return ContainerWidget(
                title: list.elementAt(index),
                description: 'This is a description',
              );
            }),
          ],
        ),
      ),
    );
  }
}
