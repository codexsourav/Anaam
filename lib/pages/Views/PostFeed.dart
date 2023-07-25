import 'package:anaam/components/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostFeed extends StatefulWidget {
  PostFeed({super.key});

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  final fbDB = FirebaseFirestore.instance;
  var postData = null;
  bool _isLoading = false;
  Future loadPost() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var data = await fbDB
          .collection("posts")
          .orderBy("uploadtime", descending: true)
          .get();
      setState(() {
        postData = data.docs;
      });
    } catch (e) {
      postData = null;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await loadPost();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Builder(
              builder: (context) {
                if (postData != null) {
                  return RefreshIndicator(
                    onRefresh: () async {},
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: postData.length,
                      itemBuilder: (context, index) {
                        String pid = postData[index].id;
                        return Post(post: postData[index].data(), puid: pid);
                      },
                    ),
                  );
                } else if (_isLoading) {
                  return const Center(
                    child: SizedBox(
                      height: 300,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      )),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
