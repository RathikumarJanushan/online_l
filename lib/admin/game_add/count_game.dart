import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController questionController = TextEditingController();
  TextEditingController correctOptionController = TextEditingController();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> uploadImageToFirebase() async {
    if (_image == null) return null;

    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    UploadTask uploadTask = storageReference.putFile(_image!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }

  void saveDataToFirestore(String? imageUrl) {
    if (imageUrl == null) return;

    String question = questionController.text;
    String correctOption = correctOptionController.text;

    FirebaseFirestore.instance.collection('game2').add({
      'question': question,
      'correctOption': correctOption,
      'imageUrl': imageUrl,
    }).then((value) {
      print("Data added successfully");
      // Show toast message indicating data added successfully
      Fluttertoast.showToast(
        msg: "Data added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }).catchError((error) {
      print("Failed to add data: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image and Question'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/PMSbackground.png'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(
                      _image!,
                      height: 200,
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: getImageFromGallery,
                child: Text('Select Image'),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: questionController,
                  decoration: InputDecoration(
                    labelText: 'Enter Question',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: correctOptionController,
                  decoration: InputDecoration(
                    labelText: 'Enter Correct Option',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String? imageUrl = await uploadImageToFirebase();
                  saveDataToFirestore(imageUrl);
                },
                child: Text('Upload Image and Save Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
