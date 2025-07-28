import 'package:flutter/material.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/views/pages/loginpage.dart';
//! import 'package:igclone/views/pages/maintree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const IgClone());
}

class IgClone extends StatelessWidget {
  const IgClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IG Clone',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: mobileLightModeBGColor)),
      // home: MainTree(),
      home: LoginPage(),
    );
  }
}
