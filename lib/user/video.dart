import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late DocumentReference<Object?> linkRef;
  List<String> videoID = [];
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
                itemCount: videoID.length,
                itemBuilder: (context, index) {
                  final videoUrl = videoID[index];
                  if (videoUrl != null) {
                    final videoId = YoutubePlayer.convertUrlToId(videoUrl,
                        trimWhitespaces: true);
                    if (videoId != null) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        child: YoutubePlayer(
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
    linkRef = FirebaseFirestore.instance.collection('links').doc('urls');
    super.initState();
    getData();
    print(videoID);
  }

  getData() async {
    await linkRef.get().then((value) {
      final data =
          value.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
      data?.forEach((key, value) {
        if (!videoID.contains(value)) {
          setState(() {
            videoID.add(value);
          });
        }
      });
    }).whenComplete(() => setState(() {
          videoID.shuffle();
          showItem = true;
        }));
  }
}
