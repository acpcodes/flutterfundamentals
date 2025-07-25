import 'package:flutter/material.dart';
import 'package:igclone/views/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IG Clone',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color(0xAAE8F0E3))),
      home: HomePage(),
    );
  }
}
