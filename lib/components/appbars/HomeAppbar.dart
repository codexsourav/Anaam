import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

PreferredSizeWidget HomeAppbar({isdark = false}) {
  return AppBar(
    elevation: 0,
    backgroundColor: isdark ? Colors.black : Colors.white,
    leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Ionicons.camera_outline,
          color: isdark ? Colors.white : Colors.black,
        )),
    centerTitle: true,
    title: Text(
      "Anaam",
      style: TextStyle(
          color: isdark ? Colors.white : Colors.black,
          fontWeight: FontWeight.w300),
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Ionicons.chatbox_outline,
            color: isdark ? Colors.white : Colors.black,
          )),
    ],
  );
}
