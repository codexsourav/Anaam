import 'package:flutter/material.dart';
import '../components/appbars/HomeAppbar.dart';
import 'Messages/ChatPage.dart';
import 'UploadPage/AddPostView.dart';
import 'Views/PostFeed.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppbar(
        onCamaraPress: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddPostView(),
          ),
        ),
        onChatPress: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatPage(),
          ),
        ),
      ),
      body: PostFeed(),
    );
  }
}
