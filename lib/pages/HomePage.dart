import 'package:anaam/components/StoriesBox.dart';
import 'package:flutter/material.dart';

import 'Views/PostBox.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StoriesBox(),
            PostBox(),
          ],
        ),
      ),
    );
  }
}
