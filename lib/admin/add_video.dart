import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final _formKey = GlobalKey<FormState>();
  final _addItemController = TextEditingController();
  final _descriptionController = TextEditingController();
  late CollectionReference<Map<String, dynamic>> linkRef;
  List<DocumentSnapshot> videos = [];
  bool showItem = false;
  final utube = RegExp(
      r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");

  @override
  void initState() {
    linkRef = FirebaseFirestore.instance.collection('links');
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Video URL'),
        backgroundColor: Colors.redAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _addItemController,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Your Video URL',
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.add, size: 32),
                    onTap: _addItemFunction,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _descriptionController,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: showItem
                  ? ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index].data() as Map<String, dynamic>;
                        return VideoItem(
                          videoUrl: video['url'],
                          videoDescription: video['description'],
                          onDelete: () => deleteVideo(videos[index].id),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  _addItemFunction() {
    if (utube.hasMatch(_addItemController.text)) {
      _saveItem();
    } else {
      _showErrorMessage('Please provide a valid link');
    }
  }

  _saveItem() async {
    try {
      await linkRef.add({
        'url': _addItemController.text,
        'description': _descriptionController.text,
      });
      _showSuccessMessage('Video added successfully');
      _addItemController.clear();
      _descriptionController.clear();
      getData(); // Refresh data after adding
    } catch (error) {
      _showErrorMessage('Error adding video: $error');
    }
  }

  deleteVideo(String videoID) async {
    try {
      await linkRef.doc(videoID).delete();
      _showSuccessMessage('Video deleted successfully');
      getData(); // Refresh data after deleting
    } catch (error) {
      _showErrorMessage('Error deleting video: $error');
    }
  }

  getData() async {
    try {
      final querySnapshot = await linkRef.get();
      setState(() {
        videos = querySnapshot.docs;
        showItem = true;
      });
      _showSuccessMessage('Data retrieved successfully');
    } catch (error) {
      _showErrorMessage('Error retrieving data: $error');
    }
  }
}

class VideoItem extends StatelessWidget {
  final String videoUrl;
  final String videoDescription;
  final VoidCallback onDelete;

  const VideoItem({
    required this.videoUrl,
    required this.videoDescription,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(videoDescription),
      subtitle: VideoWidget(videoUrl: videoUrl),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  const VideoWidget({required this.videoUrl});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl, trimWhitespaces: true);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blue,
      progressColors: const ProgressBarColors(
        playedColor: Colors.blue,
        handleColor: Colors.blueAccent,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}