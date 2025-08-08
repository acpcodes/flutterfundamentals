import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:igclone/data/classes/authclass.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/data/utils.dart';
import 'package:igclone/views/pages/loginpage.dart';
import 'package:igclone/widgets/textfieldinput.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {
  final TextEditingController _emailController =
      TextEditingController();
  final TextEditingController
  _passwordController = TextEditingController();
  final TextEditingController
  _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDefaultImage();
  }

  Future<void> _loadDefaultImage() async {
    final ByteData bytes = await rootBundle.load(
      'assets/default_images/default.png',
    );
    setState(() {
      _image = bytes.buffer.asUint8List();
    });
  }

  bool _isPickingImage = false;

  void selectImage() async {
    if (_isPickingImage) {
      return;
    }

    _isPickingImage = true;

    try {
      Uint8List? im = await pickImage(
        ImageSource.gallery,
      );

      if (im != null) {
        setState(() {
          _image = im;
        });
      } else {
        print('user didn’t choose image.');
      }
    } catch (e) {
      print('Image picker error: $e');
    } finally {
      _isPickingImage = false;
    }
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthClass().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      file: _image!,
      bio: '',
    );
    setState(() {
      _isLoading = false;
    });
    if (!mounted) return;
    if (res != 'Success!') {
      showSnackBar(res, context);
    } else {
      showSnackBar(
        'Account created successfully!',
        context,
      );
      navigateToLogin();
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

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
          padding: EdgeInsets.symmetric(
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
              SvgPicture.asset(
                'assets/logos/logoblacktext.svg',
                height: 64,
              ),
              const SizedBox(height: 64),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          backgroundImage:
                              MemoryImage(
                                _image!,
                              ),
                          radius: 64,
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/default_images/default.png',
                          ),
                          backgroundColor:
                              Colors.white,
                          foregroundColor:
                              Colors.white,
                          radius: 64,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 78,
                    child: IconButton(
                      onPressed: () =>
                          selectImage(),
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              TextFieldInput(
                hintText: 'Enter Username',
                textInputType: TextInputType.text,
                textEditingController:
                    _usernameController,
              ),
              const SizedBox(height: 8),
              TextFieldInput(
                hintText: 'Enter Email',
                textInputType:
                    TextInputType.emailAddress,
                textEditingController:
                    _emailController,
              ),
              const SizedBox(height: 8),
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
                onTap: signUpUser,
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
                          'Sign-up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                flex: 1,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                      ),
                      GestureDetector(
                        onTap: navigateToLogin,
                        child: Text(
                          'Sign-in.',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
