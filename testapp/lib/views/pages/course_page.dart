import 'package:flutter/material.dart';
import 'package:testapp/views/pages/onboarding_page.dart';
import 'package:testapp/widgets/hero_widgets.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [HeroWidget(title: 'Course', nextPage: OnboardingPage())],
          ),
        ),
      ),
    );
  }
}
