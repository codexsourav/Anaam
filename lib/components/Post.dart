import 'package:anaam/components/snackbar.dart';
import 'package:anaam/pages/ProfilePage.dart';
import 'package:anaam/utils/ImageLoder.dart';
import 'package:anaam/utils/ShimmerLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../model/setOnline.dart';
import '../pages/Views/CommentView.dart';
import '../resources/sendNotify.dart';

class Post extends StatefulWidget {
  final post;
  final String puid;

  const Post({super.key, required this.post, required this.puid});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool islike = false;
  var thisuserData;
  var post;
  final fbDB = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  bool _isdelete = false;
  SendNotify sendNotify = SendNotify();
  setLike() async {
    final setlike = fbDB.collection('posts').doc(widget.puid);
    final likedata = await setlike.get();
    if (likedata['like'].contains(currentUser)) {
      await setlike.update({
        "like": FieldValue.arrayRemove([currentUser])
      });

      setState(() {
        islike = false;
      });
    } else {
      await setlike.update({
        "like": FieldValue.arrayUnion([currentUser])
      });
      if (likedata['id'] != currentUser) {
        await sendNotify.notifyMe(
            uid: currentUser,
            text: "Like Your Post",
            sendId: likedata['id'],
            ismsg: false,
            type: 'like');
      }
      setState(() {
        islike = true;
      });
    }
  }

// delete user post
  void menuSelect(val) async {
    if (val == 'like') {
      setLike();
    } else if (val == "comment") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              CommentView(postId: widget.puid, postUid: widget.post['id']),
        ),
      );
    } else if (val == 'share') {
    } else if (val == "profile") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfilePage(userId: post['id']),
        ),
      );
    } else if (val == "report") {
    } else if (val == 'delete') {
      try {
        Reference ref =
            FirebaseStorage.instance.refFromURL(post['url'].toString());
        // Delete the file.
        await ref.delete();
        await fbDB.collection('posts').doc(widget.puid).delete();
        showSnackbar(context, text: "Your Post Is Deleted");
        // Print a message to indicate that the file was deleted successfully.
        setState(() {
          _isdelete = true;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    post = widget.post;
    super.initState();
    if (post['like'].contains(currentUser)) {
      setState(() {
        islike = true;
      });
    } else {
      setState(() {
        islike = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isdelete
        ? const SizedBox()
        : FutureBuilder(
            future: fbDB.collection("users").doc(post['id']).get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: ShimmerBox(
                      width: MediaQuery.of(context).size.width - 10.0,
                      height: 400.0),
                );
              }
              Map<String, dynamic>? userData = snapshot.data!.data();
              thisuserData = userData;
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  userId: widget.post['id'],
                                ),
                              ));
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: chackOnline(
                                                onlineTime:
                                                    userData!['online'] ?? "0")
                                            ? const Color.fromARGB(
                                                255, 38, 168, 60)
                                            : const Color.fromARGB(
                                                255, 221, 221, 221),
                                        width: 2),
                                  ),
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: ImageLoder(
                                        imgurl: userData['pic'].toString(),
                                        imgWidget: 30,
                                        imgHeight: 30,
                                        loderHeight: 30,
                                        loderWidget: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userData['uname'] ?? "",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
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
                        ),
                        PopupMenuButton(
                          elevation: 0,
                          color: const Color.fromARGB(255, 250, 250, 250),
                          onSelected: menuSelect,
                          itemBuilder: (context) {
                            List<PopupMenuEntry<Object?>> menuList = [];
                            menuList.add(
                              PopupMenuItem(
                                value: "like",
                                child: Text(islike ? "UnLike" : "Like"),
                              ),
                            );
                            menuList.add(const PopupMenuItem(
                              value: "comment",
                              child: Text('View Comment'),
                            ));
                            menuList.add(const PopupMenuItem(
                              value: "share",
                              child: Text('Share'),
                            ));

                            if (currentUser == post['id']) {
                              menuList.add(
                                const PopupMenuItem(
                                  value: "delete",
                                  child: Text('Delete'),
                                ),
                              );
                            } else {
                              menuList.add(const PopupMenuItem(
                                value: "profile",
                                child: Text('View Profile'),
                              ));
                              menuList.add(
                                const PopupMenuItem(
                                  value: "report",
                                  child: Text('Report'),
                                ),
                              );
                            }
                            return menuList;
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            child: Icon(
                              Ionicons.ellipsis_vertical_outline,
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GestureDetector(
                        onDoubleTap: islike ? null : setLike,
                        child: ImageLoder(
                          imgurl: post['url'].toString(),
                          imgHeight: 400,
                          imgWidget: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          loderHeight: 400,
                          loderWidget: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setLike();
                                },
                                icon: Icon(
                                  islike
                                      ? Ionicons.heart
                                      : Ionicons.heart_outline,
                                  color: islike ? Colors.pink : null,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CommentView(
                                        postId: widget.puid,
                                        postUid: widget.post['id']),
                                  ));
                                },
                                icon: const Icon(Ionicons.chatbubble_outline)),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Ionicons.share_social_outline)),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          "${post['like'].length} Likes",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                          post['desc'],
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
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
                          post['time'].toString(),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
            });
  }
}
