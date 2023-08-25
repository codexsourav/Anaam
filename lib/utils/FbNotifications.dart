import 'package:firebase_messaging/firebase_messaging.dart';

class FbNotifications {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  InitDb() async {
    NotificationSettings settings = await messaging.getNotificationSettings();

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      NotificationSettings status = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      print('User granted permission: ${status.authorizationStatus}');
    }
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
  }
}
