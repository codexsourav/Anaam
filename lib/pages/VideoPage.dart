import 'package:anaam/data/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 8,
          itemBuilder: (context, index) {
            return Player(videourl: 'assets/${index}.mp4');
          },
        ),
      ),
    );
  }
}

class Player extends StatefulWidget {
  final videourl;
  const Player({super.key, required this.videourl});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController _controller;
  bool islike = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videourl,
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false))
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
    _controller.addListener(() {
      //custom Listner
      setState(() {
        if (!_controller.value.isPlaying &&
            _controller.value.isInitialized &&
            (_controller.value.duration == _controller.value.position)) {
          setState(() {
            _controller.play();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: _controller.value.isInitialized
          ? Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              islike = true;
                            });
                          },
                          onTap: () {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          },
                          child: VideoPlayer(_controller))),
                ),
                Align(
                  alignment: Alignment.center,
                  child: !_controller.value.isPlaying
                      ? GestureDetector(
                          onTap: () {
                            _controller.play();
                          },
                          child: Icon(
                            Icons.play_arrow_rounded,
                            size: 90,
                            color: Color.fromARGB(171, 201, 201, 201),
                          ),
                        )
                      : null,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 180, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Column(children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  islike = !islike;
                                });
                              },
                              child: Icon(
                                Ionicons.heart,
                                color: islike
                                    ? const Color.fromARGB(209, 233, 30, 98)
                                    : Color.fromARGB(175, 199, 199, 199),
                                size: 40,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '100K',
                              style: TextStyle(
                                  color: Color.fromARGB(218, 223, 222, 222)),
                            )
                          ]),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Column(children: [
                            Icon(
                              Ionicons.chatbubble_outline,
                              color: Color.fromARGB(175, 199, 199, 199),
                              size: 40,
                            ),
                            SizedBox(height: 6),
                            Text(
                              '5K',
                              style: TextStyle(
                                  color: Color.fromARGB(218, 219, 219, 219)),
                            )
                          ]),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Column(children: [
                            Icon(
                              Ionicons.share_social,
                              color: Color.fromARGB(175, 218, 218, 218),
                              size: 40,
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              child: ClipRRect(
                                child: Image.network(
                                  users[0]['pic'],
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                users[0]['name'],
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 247, 247, 247),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Follow',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                        Text(
                          'In this tutorial, we learned how to change status bar color in Flutter with practical examplesIn this tutorial, we learned how to change status bar color in Flutter with practical examples dfgfd  fdg fd gd fg',
                          maxLines: 3,
                          style: TextStyle(
                            color: Color.fromARGB(255, 247, 247, 247),
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.musical_notes_outline,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Song Title Here...',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(
              child: Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
