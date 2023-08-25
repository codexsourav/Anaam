import 'package:anaam/model/UserModel.dart';
import 'package:anaam/resources/sendNotify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Autharize {
  final fbAuth = FirebaseAuth.instance;
  final fbDB = FirebaseFirestore.instance;

  Future signUpUser({name, uname, email, pass}) async {
    String res = "";
    try {
      QuerySnapshot<Map<String, dynamic>> chackUname =
          await fbDB.collection('users').where('uname', isEqualTo: uname).get();

      if (chackUname.docs.isEmpty) {
        UserCredential data = await fbAuth.createUserWithEmailAndPassword(
            email: email, password: pass);

        UserModel userEntry = UserModel(
          name: name,
          email: email,
          id: data.user!.uid,
          uname: uname,
          follower: [],
          following: [],
        );

        fbDB
            .collection('users')
            .doc(data.user!.uid)
            .set(userEntry.toJsonData());
        await data.user!.sendEmailVerification();
        res = "account-crated";
      } else {
        res = "uname-exist";
      }
    } on FirebaseAuthException catch (e) {
      res = e.code;
    }
    return res;
  }

// Login account
  Future loginAccount({email, pass}) async {
    String res = "";
    try {
      UserCredential userInfo =
          await fbAuth.signInWithEmailAndPassword(email: email, password: pass);
      if (!userInfo.user!.emailVerified) {
        await userInfo.user!.sendEmailVerification();
      }
      await SendNotify().setDeviceToken();
      res = "login-true";
    } on FirebaseAuthException catch (e) {
      print(e);
      res = e.code;
    }
    return res;
  }
}
