import 'package:flutter/material.dart';
import 'package:testapp/views/pages/register_page.dart';
import 'package:testapp/views/pages/widget_tree.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(30),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/welcome.json'),
            FittedBox(
              child: Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0, letterSpacing: 50.0),
              ),
            ),
            SizedBox(height: 20.0),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return RegisterPage();
                    },
                  ),
                );
              },
              style: FilledButton.styleFrom(minimumSize: Size(double.infinity, 40.0)),
              child: Text('Get Started'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WidgetTree();
                    },
                  ),
                );
              },
              style: TextButton.styleFrom(minimumSize: Size(double.infinity, 40.0)),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
