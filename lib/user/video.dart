import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late List<VideoPlayerController> _controllers;
  late List<Future<void>> _initializeVideoPlayerFutures;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _controllers = [
      VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
      VideoPlayerController.network(
        'https://drive.google.com/uc?export=download&id=1ZihmdkV6DDbnsvgpzGekPt1-BdQs8kad',
      ),
    ];

    _initializeVideoPlayerFutures = List.generate(
        _controllers.length, (index) => _controllers[index].initialize());
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void _playNextVideo() {
    setState(() {
      _controllers[_currentIndex].pause();
      _currentIndex = (_currentIndex + 1) % _controllers.length;
      _controllers[_currentIndex].play();
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (_controllers[_currentIndex].value.isPlaying) {
        _controllers[_currentIndex].pause();
      } else {
        _controllers[_currentIndex].play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFutures[_currentIndex],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controllers[_currentIndex].value.aspectRatio,
                  child: VideoPlayer(_controllers[_currentIndex]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _togglePlayPause,
                child: Icon(
                  _controllers[_currentIndex].value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                ),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: _playNextVideo,
                child: Icon(Icons.skip_next),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
