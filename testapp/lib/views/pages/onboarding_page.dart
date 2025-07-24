import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:testapp/data/constants.dart';
import 'package:testapp/views/pages/register_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lotties/register.json'),
                  SizedBox(height: 12),
                  Text('Hello World', style: KTextStyle.titleTealText),
                  SizedBox(height: 50),
                  FilledButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RegisterPage(title: 'Register');
                          },
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(minimumSize: Size(double.infinity, 40.0)),
                    child: Text('Next'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
