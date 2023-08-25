import 'package:anaam/components/snackbar.dart';
import 'package:anaam/model/setOnline.dart';
import 'package:anaam/pages/ProfilePage.dart';
import 'package:anaam/utils/ImageLoder.dart';
import 'package:anaam/utils/ShimmerLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../resources/managechat.dart';

class MessagePage extends StatefulWidget {
  final userId;
  MessagePage({super.key, required this.userId});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController _textEditingController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  ManageChat managechat = ManageChat();

  final myid = FirebaseAuth.instance.currentUser!.uid;

  final fbDb = FirebaseFirestore.instance.collection('users');
  late Stream stream;
  bool isonline = false;

  onMenuSelect(val) async {
    if (val == 'profile') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProfilePage(userId: widget.userId),
      ));
    } else if (val == 'delete') {
      await managechat.deleteChat(sender: myid, resever: widget.userId);
      showSnackbar(context, text: 'Chats Deleted!');
    }
  }

  @override
  void initState() {
    super.initState();

    stream = fbDb
        .doc(myid)
        .collection('chats')
        .doc(widget.userId)
        .collection('messages')
        .orderBy("time", descending: true)
        .snapshots();
    stream.listen((snapshot) {
      if (_scrollController.hasClients) {
        if (_scrollController.position.minScrollExtent - 500 <=
            _scrollController.position.pixels) {
          _scrollController.animateTo(
              _scrollController.position.minScrollExtent - 70,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromARGB(255, 37, 37, 37),
            size: 18,
          ),
        ),
        flexibleSpace: SafeArea(
          child: StreamBuilder(
              stream: fbDb.doc(widget.userId).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ShimmerBox(height: 30, width: 120);
                }
                // ignore: non_constant_identifier_names
                var UserData = snapshot.data!.data();

                return Container(
                  padding: const EdgeInsets.only(right: 16),
                  margin: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 2,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: ImageLoder(
                            imgurl: UserData!['pic'],
                            imgHeight: 35,
                            imgWidget: 35,
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              UserData['name'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              chackOnline(onlineTime: UserData['online'] ?? "0")
                                  ? "Online"
                                  : "Offline",
                              style: TextStyle(
                                  color: !chackOnline(
                                          onlineTime: UserData['online'] ?? "0")
                                      ? Colors.grey.shade600
                                      : Colors.green,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        elevation: 0,
                        color: const Color.fromARGB(255, 250, 250, 250),
                        onSelected: onMenuSelect,
                        itemBuilder: (context) {
                          List<PopupMenuEntry<Object?>> menuList = [];
                          menuList.add(const PopupMenuItem(
                            value: "profile",
                            child: Text('View Profile'),
                          ));
                          menuList.add(const PopupMenuItem(
                            value: "delete",
                            child: Text('Delete Chats'),
                          ));

                          return menuList;
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Icon(
                            Ionicons.ellipsis_vertical_outline,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return ShimmerBox(height: 30, width: 120);
              }

              var messages = snapshot.data!.docs;

              return ListView.builder(
                itemCount: messages.length,
                controller: _scrollController,
                reverse: true,
                // shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 60),
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index]['issend'] == false
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index]['issend'] == false
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          messages[index]['text'],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
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
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      if (_textEditingController.text.isNotEmpty) {
                        String text = _textEditingController.text;
                        _textEditingController.clear();
                        await managechat.sendNewMessage(
                          issend: true,
                          resever: widget.userId,
                          text: text,
                          sender: myid,
                        );
                      }
                    },
                    backgroundColor: Colors.black,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
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
