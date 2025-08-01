import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:igclone/data/classes/firestoreclass.dart';
import 'package:igclone/data/constants.dart';
import 'package:igclone/data/utils.dart';
import 'package:igclone/models/usermodel.dart';
import 'package:igclone/providers/userprovider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewPage extends StatefulWidget {
  const AddNewPage({super.key});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  void postImage(String uid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreClass().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (!mounted) return;
      if (res == 'Success!') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted!', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create a post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
              child: Text('Take a photo'),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List? file = await pickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
              child: Text('Choose from gallery'),
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: IconButton(
              onPressed: () => _selectImage(context),
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            backgroundColor: mobileLightModeBGColor,
            appBar: AppBar(
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              title: Text(
                'Post to',
                style: TextStyle(color: mobileDarkModeBGColor, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () => postImage(user!.uid, user.username, user.photoUrl),
                  child: const Text(
                    'Feed',
                    style: TextStyle(
                      color: mobileDarkModeBGColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  _isLoading
                      ? const LinearProgressIndicator()
                      : const Padding(padding: EdgeInsets.only(top: 0)),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(radius: 35, backgroundImage: NetworkImage(user!.photoUrl)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Caption Here',
                            border: InputBorder.none,
                          ),
                          maxLines: 8,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(_file!),
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
