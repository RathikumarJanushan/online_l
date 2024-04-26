import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen2 extends StatefulWidget {
  @override
  _ImageUploadScreen2State createState() => _ImageUploadScreen2State();
}

class _ImageUploadScreen2State extends State<ImageUploadScreen2> {
  File? _imageFile;
  String _imageUrl = '';
  String _question = '';
  bool? _selection;
  bool _isLoading = false;

  final picker = ImagePicker();

  Future<void> _uploadImageToStorage() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_imageFile != null) {
        final Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('images')
            .child('${DateTime.now()}.jpg');
        await storageRef.putFile(_imageFile!);
        _imageUrl = await storageRef.getDownloadURL();
      } else {
        throw Exception('No image file to upload.');
      }
    } catch (e) {
      _showErrorSnackbar('Error uploading image: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _addDataToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('ToFGame').add({
        'imageUrl': _imageUrl,
        'question': _question,
        'selection': _selection,
      });
      _showSuccessSnackbar('Data added to Firestore');
    } catch (e) {
      _showErrorSnackbar('Error adding data to Firestore: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        _showErrorSnackbar('No image selected.');
      }
    });
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image and Question'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _imageFile == null
                        ? Text('No image selected.')
                        : Image.file(_imageFile!),
                    ElevatedButton(
                      onPressed: _pickImageFromGallery,
                      child: Text('Select Image'),
                    ),
                    TextField(
                      onChanged: (value) {
                        _question = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your question',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('True'),
                        Radio(
                          value: true,
                          groupValue: _selection,
                          onChanged: (value) {
                            setState(() {
                              _selection = value as bool?;
                            });
                          },
                        ),
                        Text('False'),
                        Radio(
                          value: false,
                          groupValue: _selection,
                          onChanged: (value) {
                            setState(() {
                              _selection = value as bool?;
                            });
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_imageFile != null &&
                            _question.isNotEmpty &&
                            _selection != null) {
                          await _uploadImageToStorage();
                          await _addDataToFirestore();
                          setState(() {
                            _imageFile = null;
                            _question = '';
                            _selection = null;
                          });
                        } else {
                          _showErrorSnackbar(
                              'Please select an image, enter a question, and choose an option.');
                        }
                      },
                      child: Text('Upload Data'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
