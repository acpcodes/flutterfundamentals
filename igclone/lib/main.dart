import 'package:flutter/material.dart';
import 'package:igclone/views/pages/maintree.dart';

void main() {
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
