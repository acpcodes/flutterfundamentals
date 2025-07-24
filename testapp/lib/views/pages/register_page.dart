import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'widget_tree.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerEmail = TextEditingController(text: '123');
  TextEditingController controllerPassword = TextEditingController(text: '12345');
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
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: LayoutBuilder(
                builder: (context, BoxConstraints constraints) {
                  return FractionallySizedBox(
                    widthFactor: widthScreen > 500 ? 0.5 : 1.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/lotties/register.json'),
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
                        FilledButton(
                          onPressed: () {
                            onLoginPressed();
                          },
                          style: FilledButton.styleFrom(minimumSize: Size(double.infinity, 40.0)),
                          child: Text(widget.title),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onLoginPressed() {
    if (confirmedEmail == controllerEmail.text && confirmedPassword == controllerPassword.text) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WidgetTree();
          },
        ),
        (route) => false,
      );
    }
  }
}
