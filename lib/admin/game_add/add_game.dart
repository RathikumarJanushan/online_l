import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddImagePage(),
    );
  }
}

class AddImagePage extends StatefulWidget {
  @override
  _AddImagePageState createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  final _formKey = GlobalKey<FormState>();
  final _option1Controller = TextEditingController();
  final _option2Controller = TextEditingController();
  final _option3Controller = TextEditingController();
  final _option4Controller = TextEditingController();
  final _correctOptionController = TextEditingController();
  late String _imageUrl;

  File? _image;

  final picker = ImagePicker();

  String _generateRandomName() {
    String alphabet = 'abcdefghijklmnopqrstuvwxyz';
    Random random = Random();
    String randomName = '';

    for (int i = 0; i < 10; i++) {
      randomName += alphabet[random.nextInt(alphabet.length)];
    }

    return randomName;
  }

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage() async {
    try {
      if (_image != null) {
        FirebaseStorage storage = FirebaseStorage.instance;
        String randomName = _generateRandomName();
        String fileName = '$randomName.jpg';
        Reference ref = storage.ref().child(fileName);
        await ref.putFile(_image!);
        _imageUrl = await ref.getDownloadURL();
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _addImage() async {
    try {
      await _uploadImage();

      if (_imageUrl.isNotEmpty &&
          _option1Controller.text.isNotEmpty &&
          _option2Controller.text.isNotEmpty &&
          _option3Controller.text.isNotEmpty &&
          _option4Controller.text.isNotEmpty &&
          _correctOptionController.text.isNotEmpty) {
        await FirebaseFirestore.instance.collection('game').add({
          'imageUrl': _imageUrl,
          'options': [
            _option1Controller.text,
            _option2Controller.text,
            _option3Controller.text,
            _option4Controller.text,
          ],
          'correctOption': _correctOptionController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image added successfully!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill in all fields.'),
          ),
        );
      }
    } catch (e) {
      print('Error adding image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add image. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image'),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _image != null
                      ? Image.file(
                          _image!,
                          height: 200,
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  ElevatedButton(
                    onPressed: _getImage,
                    child: Text('Select Image'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _option1Controller,
                    decoration: InputDecoration(labelText: 'Option 1'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter option 1';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _option2Controller,
                    decoration: InputDecoration(labelText: 'Option 2'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter option 2';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _option3Controller,
                    decoration: InputDecoration(labelText: 'Option 3'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter option 3';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _option4Controller,
                    decoration: InputDecoration(labelText: 'Option 4'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter option 4';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _correctOptionController,
                    decoration: InputDecoration(labelText: 'Correct Option'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter correct option';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addImage();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
