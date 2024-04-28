import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';

class VideoUploadScreen2 extends StatefulWidget {
  @override
  _VideoUploadScreen2State createState() => _VideoUploadScreen2State();
}

class _VideoUploadScreen2State extends State<VideoUploadScreen2> {
  late File _video;
  late VideoPlayerController _videoController;
  final picker = ImagePicker();
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  Future<void> _pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
        _videoController = VideoPlayerController.file(_video)
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_video == null) return; // No video selected
    setState(() {
      _isUploading = true;
    });
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child("videos/${DateTime.now().toString()}");
      UploadTask uploadTask = ref.putFile(_video);
      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          _uploadProgress = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });
      await uploadTask.whenComplete(() {
        setState(() {
          _isUploading = false;
          _uploadProgress = 0.0;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Video uploaded successfully!'),
          ),
        );
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
        _uploadProgress = 0.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading video: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Video'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_videoController != null &&
                _videoController.value.isInitialized)
              AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
            SizedBox(height: 20.0),
            if (_isUploading)
              LinearProgressIndicator(
                value: _uploadProgress,
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Select Video'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _uploadVideo,
              child: Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}
