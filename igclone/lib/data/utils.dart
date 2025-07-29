// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//!image upload
Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
  return null;
}

//!snackbar notifs
showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(duration: const Duration(milliseconds: 2500), content: Text(content)));
}
