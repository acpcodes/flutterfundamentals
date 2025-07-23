import 'package:flutter/material.dart';
import 'package:testapp/widgets/hero_widgets.dart';
import 'widget_tree.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String confirmedEmail = '123';
  String confirmedPassword = '12345';

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            HeroWidget(title: 'Login'),
            SizedBox(height: 20.0),
            TextField(
              controller: controllerEmail,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              ),
              onEditingComplete: () => setState(() {}),
            ),
            SizedBox(height: 12),
            TextField(
              controller: controllerPassword,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                hintText: 'Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              ),
              onEditingComplete: () => setState(() {}),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                onLoginPressed();
              },
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 40.0)),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void onLoginPressed() {
    if (confirmedEmail == controllerEmail.text && confirmedPassword == controllerPassword.text) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
      );
    }
  }
}
