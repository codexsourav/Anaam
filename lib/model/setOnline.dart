import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

int now = DateTime.now().millisecondsSinceEpoch;
setOnline() async {
  final fbDB = FirebaseFirestore.instance;
  if (FirebaseAuth.instance.currentUser != null) {
    int now = DateTime.now().millisecondsSinceEpoch;

    await fbDB
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "online": (now + 50000).toString(),
    });
  }
}

chackOnline({onlineTime = 0}) {
  int online = int.parse(onlineTime);
  if (online >= now) {
    return true;
  } else {
    return false;
  }
}
