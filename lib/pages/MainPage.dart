import 'dart:async';

import 'package:anaam/components/BottamBar.dart';
import 'package:anaam/model/setOnline.dart';
import 'package:anaam/pages/ProfilePage.dart';
import 'package:anaam/pages/SearchPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'NotificationPage.dart';
import 'UploadPage/AddPostView.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  int tabindex = 0;

  setTab(index) {
    if (index == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AddPostView(),
        ),
      );
    } else {
      setState(() {
        tabindex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      setState(() {
        tabindex == 3;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    Timer.periodic(const Duration(seconds: 50), (time) async {
      if (state == AppLifecycleState.resumed) {
        await setOnline();
      }
    });
    if (state == AppLifecycleState.resumed) {
      await setOnline();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      await setOffline();
    } else {
      await setOffline();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomePage(),
      const SearchPage(),
      const Placeholder(),
      NotificationPage(),
      ProfilePage(userId: FirebaseAuth.instance.currentUser!.uid)
    ];

    return WillPopScope(
      onWillPop: () async {
        if (tabindex != 0) {
          setState(() {
            tabindex = 0;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[tabindex],
        bottomNavigationBar: BottamBar(index: tabindex, setindex: setTab),
      ),
    );
  }
}
