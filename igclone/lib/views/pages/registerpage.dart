import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igclone/data/classes/auth_classs.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/widgets/textfieldinput.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              SvgPicture.asset('assets/logos/logoblacktext.svg', height: 64),
              const SizedBox(height: 64),
              Stack(
                children: [
                  CircleAvatar(
                    foregroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg',
                    ),
                    radius: 64,
                  ),
                  Positioned(
                    bottom: -10,
                    left: 78,
                    child: IconButton(onPressed: () {}, icon: const Icon(Icons.add_a_photo)),
                  ),
                ],
              ),
              SizedBox(height: 28),
              TextFieldInput(
                hintText: 'Enter Username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(height: 8),
              TextFieldInput(
                hintText: 'Enter Email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(height: 8),
              //register button
              TextFieldInput(
                hintText: 'Enter Password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  String res = await AuthMethods().signUpUser(
                    email: _emailController.text,
                    password: _passwordController.text,
                    username: _usernameController.text,
                  );
                  print(res);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    color: lavenderColor,
                  ),
                  child: const Text('Sign up', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.symmetric(vertical: 16),
              //       child: const Text("Don't have an account? "),
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(vertical: 16),
              //         child: const Text("Sign Up.", style: TextStyle(fontWeight: FontWeight.bold)),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
