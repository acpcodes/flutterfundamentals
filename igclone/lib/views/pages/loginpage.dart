import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/data/globalvariables.dart';
import 'package:igclone/data/utils.dart';
import 'package:igclone/views/pages/registerpage.dart';
import 'package:igclone/widgets/textfieldinput.dart';
import 'package:igclone/data/classes/authclass.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController
  _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthClass().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (!mounted) return;
    if (res == 'Success!') {
      showSnackBar(res, context);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         const ResponsiveLayout(
      //           webScreenLayout:
      //               WebScreenLayout(),
      //           mobileScreenLayout:
      //               MobileScreenLayout(),
      //         ),
      //   ),
      // );
      context.goNamed('home');
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              MediaQuery.of(context).size.width >
                  webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal:
                      MediaQuery.of(
                        context,
                      ).size.width /
                      3,
                )
              : EdgeInsets.symmetric(
                  horizontal: 32,
                ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              //!instagram logo
              SvgPicture.asset(
                'assets/logos/logoblacktext.svg',
                height: 64,
              ),
              const SizedBox(height: 64),
              //!text field input for email
              TextFieldInput(
                hintText: 'Enter Email',
                textInputType:
                    TextInputType.emailAddress,
                textEditingController:
                    _emailController,
              ),
              const SizedBox(height: 8),
              //!text field input for password
              //register button
              TextFieldInput(
                hintText: 'Enter Password',
                textInputType: TextInputType.text,
                textEditingController:
                    _passwordController,
                isPass: true,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: loginUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(
                            Radius.circular(8),
                          ),
                    ),
                    color: lavenderColor,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color:
                                mobileLightModeBGColor,
                          ),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                    child: const Text(
                      "Don't have an account? ",
                    ),
                  ),
                  GestureDetector(
                    onTap: navigateToRegister,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                      child: const Text(
                        "Sign Up.",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
