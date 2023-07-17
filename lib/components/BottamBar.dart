import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

class BottamBar extends StatelessWidget {
  final index, setindex, isdark;
  const BottamBar({super.key, this.index, this.setindex, this.isdark = false});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: isdark ? Colors.black : Colors.white,
        elevation: 0,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(
            color: isdark
                ? const Color.fromARGB(255, 139, 139, 139)
                : Color.fromARGB(136, 0, 0, 0),
            fill: 0.5),
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
          color: isdark ? Colors.white : Colors.black,
        ),
        currentIndex: index,
        onTap: (index) {
          setindex(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.search_outline), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.add_circle_outline), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.play_outline), label: "Reels"),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.person_circle_outline), label: "profile"),
        ]);
  }
}
