import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerchallenge/pages/challengepage.dart';
import 'package:providerchallenge/classes/calculateprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => CalculateProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
        home: ChallengePage(),
      ),
    );
  }
}
