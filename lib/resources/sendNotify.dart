import 'dart:convert';

import 'package:anaam/model/setOnline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import '../model/notifyModel.dart';

class SendNotify {
  final fbDB = FirebaseFirestore.instance;
  setDeviceToken() async {
    final fbDB = FirebaseFirestore.instance;
    if (FirebaseAuth.instance.currentUser != null) {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      await fbDB
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "token": deviceToken.toString(),
      });
    }
  }

  Future<void> sendPushNotification(
      {required String deviceToken,
      required String title,
      required String body,
      Map<String, String>? noticData}) async {
    // Get the Firebase server key.

    String serverKey =
        "AAAA7ZaPUjo:APA91bHqgPLJQ-VrI8CdIV0a1M2CYv7eP1FYYdwugPdyBkf2_p8p-tKFIofZnmBLnmzi4nUdUchQ5240uuPdnoAqNoNtL-saJ2e4UyXGV_YjNZlsCl-t_zzXsMGOR2G94SkXnKuDDcgm";
    // Create the request body.
    Map<String, dynamic> data = {
      "to": deviceToken,
      "notification": {
        "title": title,
        "body": body,
        "data": noticData,
      },
    };

    // Send the request.
    var response = await post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: {
        "Authorization": "key=$serverKey",
        "Content-Type": "application/json",
      },
      body: json.encode(data),
    );
    print(data);
    // Check the response status code.
    if (response.statusCode != 200) {
      throw Exception(
          "Error sending push notification: ${response.statusCode}");
    }
  }

  notifyMe({uid, text, sendId, ismsg, type, noticData}) async {
    var sendDoc = fbDB.collection('users').doc(sendId);
    var userDoc = await fbDB.collection('users').doc(uid).get();

    var data = await sendDoc.get();
    NotifyModel newNotic =
        NotifyModel(text: text, uid: uid, ismsg: ismsg, type: type);
    try {
      await sendDoc.collection('notify').add(newNotic.toJsonData());

      if (type == 'chat' && !chackOnline(onlineTime: data['online'] ?? "0")) {
        await sendPushNotification(
          title: userDoc['name'],
          body: text,
          deviceToken: data['token'],
          noticData: noticData,
        );

        return false;
      } else if (type != 'chat' &&
          !chackOnline(onlineTime: data['online'] ?? "0")) {
        await sendPushNotification(
          title: userDoc['name'],
          body: text,
          deviceToken: data['token'],
          noticData: noticData,
        );
        print('Push notify user send');
      }
    } catch (e) {
      print(e);
    }
  }
}
