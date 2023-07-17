import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../data/user.dart';
import '../pages/Views/CommentView.dart';

class Post extends StatefulWidget {
  final post;
  const Post({super.key, this.post});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool islike = false;
  late Map post;
  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        child: Image.network(
                          users[post['user']]['pic'],
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        users[post['user']]['name'],
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Ionicons.ellipsis_vertical_outline,
                    size: 18,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    islike = true;
                  });
                },
                child: Image.network(post['url'])),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          islike = !islike;
                        });
                      },
                      icon: Icon(
                        islike ? Ionicons.heart : Ionicons.heart_outline,
                        color: islike ? Colors.pink : null,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CommentView(postinfo: post),
                        ));
                      },
                      icon: Icon(Ionicons.chatbubble_outline)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Ionicons.send_outline)),
                ],
              ),
              IconButton(
                  onPressed: () {}, icon: Icon(Ionicons.bookmark_outline)),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                "${post['like']} Likes | ${post['comment'].length} Comments",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 8),
              child: Text(
                post['cap'],
                maxLines: 3,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 5),
              child: Text(
                post['time'],
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
