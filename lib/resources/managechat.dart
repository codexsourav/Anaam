import 'package:cloud_firestore/cloud_firestore.dart';

class ManageChat {
  final fbDB = FirebaseFirestore.instance.collection('users');

  sendNewMessage({sender, resever, text, issend, isOnline}) async {
    await _sendMessage(
        sender: sender, resever: resever, text: text, issend: issend);
    await _sendMessage(
        sender: resever, resever: sender, text: text, issend: !issend);
    await _setLastMessage(sender: sender, resever: resever, text: text);
    await _setLastMessage(sender: resever, resever: sender, text: text);
  }

  Future _sendMessage({sender, resever, text, issend}) async {
    var messageDb = fbDB
        .doc(sender)
        .collection('chats')
        .doc(resever)
        .collection('messages');
    await messageDb.add({
      'text': text,
      'issend': issend,
      'time': DateTime.now(),
    });
  }

  Future _setLastMessage({sender, resever, text}) async {
    var messageDb = fbDB.doc(sender).collection('chats').doc(resever);
    await messageDb.set({
      'lastmsg': text,
      'time': DateTime.now(),
    });
  }

  Future deleteChat({sender, resever, text}) async {
    var messageDb = fbDB.doc(sender).collection('chats').doc(resever);
    final instance = FirebaseFirestore.instance;

    final batch = instance.batch();
    var collection = instance
        .collection('users')
        .doc(sender)
        .collection('chats')
        .doc(resever)
        .collection('messages');
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
    await messageDb.delete();
  }
}
