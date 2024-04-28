import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _addItemController = TextEditingController();
  late DocumentReference<Object?> linkRef;
  List<String> videoID = [];
  bool showItem = false;
  final utube =
      RegExp(r"^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youtube Player'),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: _addItemController,
              onEditingComplete: () {
                if (utube.hasMatch(_addItemController.text)) {
                  _addItemFuntion();
                } else {
                  FocusScope.of(this.context).unfocus();
                  _addItemController.clear();
                  Flushbar(
                    title: 'Invalid Link',
                    message: 'Please provide a valid link',
                    duration: Duration(seconds: 3),
                    icon: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  )..show(context);
                }
              },
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                  labelText: 'Your Video URL',
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.add, size: 32),
                    onTap: () {
                      if (utube.hasMatch(_addItemController.text)) {
                        _addItemFuntion();
                      } else {
                        FocusScope.of(this.context).unfocus();
                        _addItemController.clear();
                        Flushbar(
                          title: 'Invalid Link',
                          message: 'Please provide a valid link',
                          duration: Duration(seconds: 3),
                          icon: Icon(
                            Icons.error_outline,
                            color: Colors.red,
                          ),
                        )..show(context);
                      }
                    },
                  )),
            ),
          ),
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
                  return SizedBox
                      .shrink(); // Return a small empty widget if videoUrl is null or convertUrlToId returns null
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

  _addItemFuntion() async {
    await linkRef.set({
      _addItemController.text.toString(): _addItemController.text.toString()
    }, SetOptions(merge: true));
    Flushbar(
        title: 'Added',
        message: 'updating...',
        duration: Duration(seconds: 3),
        icon: Icon(Icons.info_outline))
      ..show(context);
    setState(() {
      videoID.add(_addItemController.text);
    });
    print('added');
    FocusScope.of(this.context).unfocus();
    _addItemController.clear();
  }

  getData() async {
    await linkRef.get().then((value) {
      final data =
          value.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
      data?.forEach((key, value) {
        if (!videoID.contains(value)) {
          videoID.add(value);
        }
      });
    }).whenComplete(() => setState(() {
          videoID.shuffle();
          showItem = true;
        }));
  }
}
