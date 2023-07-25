import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/PostModel.dart';

class PostService {
  final fbDB = FirebaseFirestore.instance;
  addNewPost({id, desc, url}) async {
    try {
      PostModel newPost = PostModel(id: id, desc: desc, url: url);

      await fbDB.collection('posts').add(newPost.toJsonData());
      return true;
    } catch (e) {
      return false;
    }
  }
}
