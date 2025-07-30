import 'package:flutter/material.dart';
import 'package:igclone/data/classes/authclass.dart';
import 'package:igclone/models/usermodel.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    refreshUser();
  }
  User? _user;
  final AuthClass _authClass = AuthClass();
  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authClass.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
