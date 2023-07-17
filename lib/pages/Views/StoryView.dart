import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:story_view/story_view.dart';

class StorypageView extends StatefulWidget {
  @override
  _StorypageViewState createState() => _StorypageViewState();
}

class _StorypageViewState extends State<StorypageView> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: [
          StoryItem.pageImage(
            url:
                "https://cdn.pixabay.com/photo/2019/11/05/16/03/man-4603859_1280.jpg",
            controller: storyController,
          ),
          StoryItem.pageImage(
            url:
                "https://cdn.pixabay.com/photo/2019/11/05/16/03/man-4603859_1280.jpg",
            controller: storyController,
          ),
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          Navigator.of(context).pop();
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}
