import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoUploader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video URL to Firestore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoForm(),
    );
  }
}

class VideoForm extends StatefulWidget {
  @override
  _VideoFormState createState() => _VideoFormState();
}

class _VideoFormState extends State<VideoForm> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _saveVideoUrl() async {
    try {
      await FirebaseFirestore.instance.collection('videos').add({
        'videoUrl': _controller.text.trim(),
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Video URL saved successfully!'),
      ));
    } catch (e) {
      print('Error saving video URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save video URL. Please try again.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Video URL to Firestore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Video URL',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveVideoUrl,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
