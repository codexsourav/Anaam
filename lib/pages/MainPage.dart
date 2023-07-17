import 'package:anaam/components/BottamBar.dart';
import 'package:anaam/components/StoriesBox.dart';
import 'package:anaam/components/appbars/HomeAppbar.dart';
import 'package:anaam/components/appbars/ProfileAppbar.dart';
import 'package:anaam/pages/ProfilePage.dart';
import 'package:anaam/pages/SearchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/appbars/SearchAppbar.dart';
import 'HomePage.dart';
import 'Views/PostBox.dart';
import 'VideoPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int tabindex = 0;

  setTab(index) {
    setState(() {
      tabindex = index;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor:
            tabindex == 3 ? Colors.black : Colors.white, // navigation bar color
        statusBarColor:
            tabindex == 3 ? Colors.black : Colors.white, // status bar color
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(),
      SearchPage(),
      Placeholder(),
      VideoApp(),
      ProfilePage()
    ];
    List appbars = [
      HomeAppbar(),
      SearchAppbar(),
      null,
      HomeAppbar(isdark: tabindex == 3),
      ProfileAppbar(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbars[tabindex],
      body: pages[tabindex],
      bottomNavigationBar:
          BottamBar(index: tabindex, setindex: setTab, isdark: tabindex == 3),
    );
  }
}
