import 'package:flutter/material.dart';
import 'package:igclone/data/constants.dart';

class AddNewPageTry extends StatefulWidget {
  const AddNewPageTry({super.key});

  @override
  State<AddNewPageTry> createState() => _AddNewPageTryState();
}

class _AddNewPageTryState extends State<AddNewPageTry> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet();
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          // MediaQuery.of(context).size.height * 1,
          child: SafeArea(
            child: Container(
              //! child: ElevatedButton.icon(
              //!   onPressed: () => Navigator.pop(context),
              //!   icon: const Icon(Icons.close),
              //!   label: const Text('Close'),
              //! ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.zero),
              onPressed: _showBottomSheet,
              backgroundColor: mobileLightModeBGColor,
              elevation: 0.1,
              child: const Icon(Icons.photo),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      body: Center(child: Column()),
    );
  }
}
