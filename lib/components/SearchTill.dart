import 'package:anaam/model/SetFollow.dart';
import 'package:anaam/pages/ProfilePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/ImageLoder.dart';

class SearchTill extends StatefulWidget {
  final userInfo;
  final userID;

  const SearchTill({super.key, this.userInfo, this.userID});

  @override
  State<SearchTill> createState() => _SearchTillState();
}

class _SearchTillState extends State<SearchTill> {
  final fbDB = FirebaseFirestore.instance;
  late bool isFolllow;
  final myid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFolllow = widget.userInfo['follower'].contains(myid);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfilePage(userId: widget.userID),
      )),
      leading: Container(
        width: 30,
        height: 30,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: ImageLoder(imgurl: widget.userInfo['pic']),
        ),
      ),
      title: Text(widget.userInfo['name']),
      subtitle: Text('${widget.userInfo['follower'].length} Follwers'),
      trailing: myid == widget.userID
          ? null
          : GestureDetector(
              onTap: () async {
                bool res = await setFollow(
                    isFolllow: isFolllow, userID: widget.userID);
                setState(() {
                  isFolllow = res;
                });
              },
              child: Chip(
                label: Text(
                  isFolllow ? "Following" : "  Follow  ",
                  style: TextStyle(
                    color: !isFolllow
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : Colors.black,
                  ),
                ),
                backgroundColor: isFolllow
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : Colors.black,
              ),
            ),
    );
  }
}
