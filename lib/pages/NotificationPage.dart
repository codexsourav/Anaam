import 'package:anaam/components/appbars/HomeAppbar.dart';
import 'package:anaam/model/setOnline.dart';
import 'package:anaam/pages/Messages/MessagePage.dart';
import 'package:anaam/utils/ImageLoder.dart';
import 'package:anaam/utils/ShimmerLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Messages/ChatPage.dart';
import 'UploadPage/AddPostView.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});
  final fbDb = FirebaseFirestore.instance.collection('users');
  final myId = FirebaseAuth.instance.currentUser!.uid;
  deleteNofify() async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    var snap = await fbDb.doc(myId).collection('notify').get();
    for (var doc in snap.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppbar(
        title: "Notification",
        onCamaraPress: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddPostView(),
          ),
        ),
        onChatPress: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatPage(),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: fbDb
              .doc(myId)
              .collection('notify')
              .orderBy("datetime", descending: true)
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
            var notDataDoc = snapshot.data!.docs;
            if (notDataDoc.isEmpty) {
              return const Center(
                child: Text('No Notification Found'),
              );
            }
            return ListView.builder(
              itemCount: notDataDoc.length,
              itemBuilder: (context, index) {
                var msgdata = notDataDoc[index].data();
                return StreamBuilder(
                    stream: fbDb.doc(msgdata['uid']).snapshots(),
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
                          if (msgdata['ismsg'] == true) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MessagePage(userId: msgdata['uid']),
                              ),
                            );
                          }
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
                        title: Text('@' + userData['uname']),
                        subtitle: Text(msgdata['text'].toString(), maxLines: 1),
                        trailing: Text(msgdata['time'].toString()),
                      );
                    });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: deleteNofify,
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}
