import 'package:flutter/material.dart';

class CalculateProvider extends ChangeNotifier {
  int count;
  CalculateProvider({this.count = 0});

  void incrementCount() {
    count++;
    notifyListeners();
  }

  void decrementCount() {
    count--;
    notifyListeners();
  }
}
