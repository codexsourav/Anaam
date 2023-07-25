import 'package:firebase_storage/firebase_storage.dart';

class UploadStorage {
  FirebaseStorage fbStoreage = FirebaseStorage.instance;

  UploadTask uploadFile({file, fileFullpath}) {
    final storageRef = FirebaseStorage.instance.ref();
    final ref = storageRef.child(fileFullpath);
    UploadTask upTask = ref.putFile(file);
    return upTask;
  }
}
