import 'package:anaam/utils/ImageLoder.dart';
import 'package:anaam/utils/ShimmerLoading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  CommentTile({super.key, this.comdata});
  final comdata;

  final fbDB = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    DocumentReference<Map<String, dynamic>> userData =
        fbDB.collection('users').doc(comdata['id']);
    return FutureBuilder(
      future: userData.get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic>? userInfo = snapshot.data!.data();
          return ListTile(
            leading: Container(
              width: 35,
              height: 35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: ImageLoder(imgurl: userInfo!['pic']),
              ),
            ),
            title: Text(userInfo['uname'].toString()),
            subtitle: Text(comdata['text']),
            trailing: Text(
              comdata['time'],
              style: const TextStyle(fontSize: 10),
            ),
          );
        } else {
          return ShimmerBox(
              width: MediaQuery.of(context).size.width - 10.0, height: 40.0);
        }
      },
    );
  }
}
