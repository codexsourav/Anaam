import 'package:anaam/components/BottamBar.dart';
import 'package:anaam/pages/ProfilePage.dart';
import 'package:anaam/pages/SearchPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'NotificationPage.dart';
import 'UploadPage/AddPostView.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
