import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideosPage> {
  late CollectionReference<Map<String, dynamic>> linkRef;
  List<Map<String, String>> videos = [];
  bool showItem = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube Player'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoUrl = videos[index]['url'];
                  final videoDescription = videos[index]['description'];
                  if (videoUrl != null) {
                    final videoId = YoutubePlayer.convertUrlToId(videoUrl,
                        trimWhitespaces: true);
                    if (videoId != null) {
                      return Column(
                        children: [
                          YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: videoId,
                              flags: YoutubePlayerFlags(
                                autoPlay: false,
                              ),
                            ),
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.blue,
                            progressColors: ProgressBarColors(
                              playedColor: Colors.blue,
                              handleColor: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            videoDescription ?? 'No description available',
                            style: TextStyle(fontSize: 16),
                          ),
                          Divider(),
                        ],
                      );
                    }
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    linkRef = FirebaseFirestore.instance.collection('links');
    super.initState();
    getData();
  }

  getData() async {
    await linkRef.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final data = doc.data();
        videos.add({
          'url': data['url'],
          'description': data['description'],
        });
      });
      setState(() {
        showItem = true;
      });
    }).catchError((error) {
      print('Error fetching data: $error');
    });
  }
}