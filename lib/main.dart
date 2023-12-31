import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:labs/firebase_options.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image upload'),
        ),
        body: UserImageUpload(),
      ),
    );
  }
}

class UserImageUpload extends StatefulWidget {
  @override
  _UserImageUploadState createState() => _UserImageUploadState();
}

class _UserImageUploadState extends State<UserImageUpload> {
  File? _imageFile; // User-selected image file
  final String userName = 'John Doe'; // User's name
  final String userEmail = 'john@example.com'; // User's email

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImageToFirebase() async {
    if (_imageFile == null) {
      // Handle the case where the user hasn't picked an image
      return;
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference =
        storage.ref().child('user_images/${DateTime.now()}.png');

    UploadTask uploadTask = storageReference.putFile(_imageFile!);

    await uploadTask.whenComplete(() async {
      String imageUrl = await storageReference.getDownloadURL();
      print('Image uploaded to Firebase: $imageUrl');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_imageFile != null)
          Image.file(
            _imageFile!,
            height: 150,
          ),
        ElevatedButton(
          onPressed: () {
            _pickImage();
          },
          child: Text('Pick Image'),
        ),
        ElevatedButton(
          onPressed: () {
            _uploadImageToFirebase();
          },
          child: Text('Upload Image to Firebase'),
        ),
      ],
    );
  }
}
