import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerchallenge/classes/calculateprovider.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Challenge',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          context.watch<CalculateProvider>().count.toString(),
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              context.read<CalculateProvider>().incrementCount();
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              context.read<CalculateProvider>().decrementCount();
            },
          ),
        ],
      ),
    );
  }
}
