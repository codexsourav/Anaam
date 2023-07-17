import 'package:anaam/components/Post.dart';
import 'package:anaam/data/user.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PostBox extends StatelessWidget {
  const PostBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Post(post: posts[index]);
      },
    );
  }
}
