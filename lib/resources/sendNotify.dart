import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/notifyModel.dart';

class SendNotify {
  final fbDB = FirebaseFirestore.instance;
  notifyMe({uid, text, sendId, ismsg, type}) async {
    NotifyModel newNotic =
        NotifyModel(text: text, uid: uid, ismsg: ismsg, type: type);
    try {
      await fbDB
          .collection('users')
          .doc(sendId)
          .collection('notify')
          .add(newNotic.toJsonData());
    } catch (e) {
      print(e);
    }
  }
}
