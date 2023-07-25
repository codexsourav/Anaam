import 'package:anaam/components/CommentTile.dart';
import 'package:anaam/components/snackbar.dart';
import 'package:anaam/resources/AddComment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/appbars/TitleBar.dart';

class CommentView extends StatefulWidget {
  final postId;
  final String collectionName;
  final String postUid;

  const CommentView(
      {super.key,
      required this.postId,
      required this.postUid,
      this.collectionName = "posts"});

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  AddComment commentAction = AddComment();

  TextEditingController commentController = TextEditingController();

  final fbDB = FirebaseFirestore.instance;

  bool isloading = false;

  addToComment() async {
    if (commentController.text.isEmpty) {
      showSnackbar(context, color: Colors.red, text: "Please Add Some Text..");
      return false;
    } else {
      setState(() {
        isloading = true;
      });
      bool res = await commentAction.newComment(
        docId: widget.postId,
        text: commentController.text,
        collectionName: widget.collectionName,
        uid: FirebaseAuth.instance.currentUser!.uid,
        postuid: widget.postUid,
      );
      print(res);
      if (res == true) {
        commentController.clear();
      } else {
        // ignore: use_build_context_synchronously
        showSnackbar(context,
            color: Colors.red, text: "Some Error! Comment Not Post");
      }
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference<Map<String, dynamic>> comments = fbDB
        .collection(widget.collectionName)
        .doc(widget.postId)
        .collection('comments');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleBar(
          title: "Comments", onback: () => Navigator.of(context).pop()),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: comments.orderBy("time", descending: false).snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot<Object?>> data =
                        snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var cmdata = data[index].data();
                        return CommentTile(comdata: cmdata);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: SizedBox(
                        height: 300,
                        child: Center(
                            child:
                                Text("Data Not Load Error ! Contact Devloper")),
                      ),
                    );
                  } else {
                    return const Center(
                      child: SizedBox(
                        height: 300,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        )),
                      ),
                    );
                  }
                }),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                          hintText: "Write Your Comment...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: isloading ? null : addToComment,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    child: const Icon(
                      Ionicons.send,
                      color: Color.fromARGB(255, 70, 69, 69),
                      size: 20,
                    ),
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
