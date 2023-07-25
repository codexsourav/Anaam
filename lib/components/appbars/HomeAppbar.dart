import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

PreferredSizeWidget HomeAppbar(
    {isdark = false, onCamaraPress, onChatPress, title = "Anaam"}) {
  return AppBar(
    elevation: 0,
    backgroundColor: isdark ? Colors.black : Colors.white,
    surfaceTintColor: Colors.transparent,
    leading: IconButton(
        onPressed: onCamaraPress,
        icon: Icon(
          Ionicons.camera_outline,
          color: isdark ? Colors.white : Colors.black,
        )),
    centerTitle: true,
    title: Text(
      title.toString(),
      style: TextStyle(
          color: isdark ? Colors.white : Colors.black,
          fontWeight: FontWeight.w300),
    ),
    actions: [
      IconButton(
          onPressed: onChatPress,
          icon: Icon(
            Ionicons.chatbox_outline,
            color: isdark ? Colors.white : Colors.black,
          )),
    ],
  );
}
