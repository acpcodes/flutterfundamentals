import 'package:flutter/material.dart';
import 'package:igclone/providers/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:igclone/models/usermodel.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(body: Center(child: Text(user?.username ?? '1')));
  }
}
