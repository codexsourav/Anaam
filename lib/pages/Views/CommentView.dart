import 'package:anaam/data/user.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/appbars/CommentAppbar.dart';

class CommentView extends StatelessWidget {
  final postinfo;
  const CommentView({super.key, required this.postinfo});

  @override
  Widget build(BuildContext context) {
    print(postinfo);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommentAppbar(context),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: ListView.builder(
              itemCount: postinfo["comment"].length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 35,
                    height: 35,
                    child: ClipRRect(
                      child: Image.network(
                        users[postinfo["comment"][index]["user"]]['pic'],
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  title:
                      Text(users[postinfo["comment"][index]["user"]]['name']),
                  subtitle: Text(postinfo["comment"][index]['text']),
                  trailing: Text(
                    postinfo["comment"][index]['time'],
                    style: TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write Your Comment...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Ionicons.send,
                      color: const Color.fromARGB(255, 70, 69, 69),
                      size: 20,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
