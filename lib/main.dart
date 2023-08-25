import 'package:anaam/pages/MainPage.dart';
import 'package:anaam/pages/Views/Auth/LoginPage.dart';
import 'package:anaam/resources/sendNotify.dart';
import 'package:anaam/utils/FbNotifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'model/setOnline.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  InitNotic() async {
    await FbNotifications().InitDb();
  }

  @override
  void initState() {
    super.initState();
    InitNotic();
  }

  @override
  Widget build(BuildContext context) {
    setOnline();
    SendNotify().setDeviceToken();
    return MaterialApp(
      title: "Anaam",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      // home: MainPage(),
      home: FirebaseAuth.instance.currentUser == null
          ? LoginPage()
          : const MainPage(),
    );
  }
}
