import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled1/models/video.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:get/get.dart';

class VideoPlayerScreen extends StatefulWidget {
  //
  VideoPlayerScreen({this.videoItem});
  final VideoItem videoItem;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  //
  YoutubePlayerController _controller;
  bool _isPlayerReady;

  @override
  void initState() {
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoItem.video.resourceId.videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      //
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoItem.video.title),
      ),
      body:SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Card(
                elevation: 7,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.videoItem.video.channelTitle,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                              widget.videoItem.video.publishedAt.toString()
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => HomeScreen());
                        },
                        child: Text("Go Back"),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  onReady: () {
                    print('Player is ready.');
                    _isPlayerReady = true;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*

Container(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            print('Player is ready.');
            _isPlayerReady = true;
          },
        ),
      ),

*/