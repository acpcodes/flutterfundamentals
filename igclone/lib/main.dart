import 'package:flutter/material.dart';
import 'package:igclone/views/pages/maintree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
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
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color(0xAAE8F0E3))),
      home: MainTree(),
    );
  }
}
