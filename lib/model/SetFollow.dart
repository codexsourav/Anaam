import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../resources/sendNotify.dart';

Future<bool> setFollow({isFolllow, userID}) async {
  final fbDB = FirebaseFirestore.instance.collection('users');
  final myid = FirebaseAuth.instance.currentUser!.uid;
  SendNotify sendNotify = SendNotify();
  if (!isFolllow) {
    await fbDB.doc(userID).update({
      "follower": FieldValue.arrayUnion([myid])
    });
    await fbDB.doc(myid).update({
      "following": FieldValue.arrayUnion([userID])
    });

    await sendNotify.notifyMe(
      uid: myid,
      text: "Start Follow You",
      sendId: userID,
      ismsg: false,
      type: 'follow',
    );

    return true;
  } else {
    await fbDB.doc(userID).update({
      "follower": FieldValue.arrayRemove([myid])
    });
    await fbDB.doc(myid).update({
      "following": FieldValue.arrayRemove([userID])
    });
    return false;
  }
}
