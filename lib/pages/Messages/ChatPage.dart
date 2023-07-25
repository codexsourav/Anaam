import 'package:anaam/pages/Messages/MessagePage.dart';
import 'package:anaam/pages/SearchPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/setOnline.dart';
import '../../utils/ImageLoder.dart';
import '../../utils/ShimmerLoading.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  final fbDb = FirebaseFirestore.instance.collection('users');
  final myId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: const Text(
          "Chats",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Color.fromARGB(255, 63, 63, 63),
            )),
      ),
      body: StreamBuilder(
          stream: fbDb
              .doc(myId)
              .collection('chats')
              .orderBy("time", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Sunthing Error!'),
              );
            }
            var chatData = snapshot.data!.docs;
            if (chatData.isEmpty) {
              return const Center(
                child: Text('No Chats Found'),
              );
            }
            print(chatData[0].data());
            // return Text("work");
            return ListView.builder(
              itemCount: chatData.length,
              itemBuilder: (context, index) {
                var msgdata = chatData[index].data();
                return StreamBuilder(
                    stream: fbDb.doc(chatData[index].id).snapshots(),
                    builder: (context, usersnapshot) {
                      if (!usersnapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShimmerBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 10),
                        );
                      }
                      if (usersnapshot.hasError) {
                        return const Center(
                          child: Text('Sunthing Error!'),
                        );
                      }
                      var userData = usersnapshot.data!.data();
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MessagePage(userId: usersnapshot.data!.id),
                            ),
                          );
                        },
                        leading: Container(
                          width: 35,
                          height: 35,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                                color: chackOnline(
                                        onlineTime: userData!['online'] ?? "0")
                                    ? const Color.fromARGB(255, 38, 168, 60)
                                    : const Color.fromARGB(255, 221, 221, 221),
                                width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: ImageLoder(
                                imgHeight: 35,
                                imgWidget: 35,
                                fit: BoxFit.cover,
                                imgurl: userData['pic']),
                          ),
                        ),
                        title: Text(
                          userData['name'],
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          msgdata['lastmsg'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: const Icon(
                          Icons.message_rounded,
                          color: Color.fromARGB(255, 104, 104, 104),
                        ),
                      );
                    });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SearchPage(),
            ));
          },
          child: const Icon(
            Icons.message_rounded,
            color: Colors.white,
          )),
    );
  }
}
