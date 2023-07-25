import 'package:anaam/resources/sendNotify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/CommentsModel.dart';

class AddComment {
  final _fbDB = FirebaseFirestore.instance;
  SendNotify sendNotify = SendNotify();
  Future newComment({docId, uid, text, collectionName, postuid}) async {
    try {
      CommentModel newComment = CommentModel(id: uid, text: text);
      await _fbDB
          .collection(collectionName)
          .doc(docId)
          .collection("comments")
          .add(newComment.toJsonData());
      if (postuid != uid) {
        await sendNotify.notifyMe(
            uid: uid,
            text: "Comment Your Post",
            sendId: postuid,
            ismsg: false,
            type: 'comment');
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
