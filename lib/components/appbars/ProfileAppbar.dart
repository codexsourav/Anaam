import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

PreferredSizeWidget ProfileAppbar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Ionicons.settings_outline,
          color: Colors.black,
        )),
    centerTitle: true,
    title: Text(
      "Profile",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Ionicons.exit_outline,
            color: Colors.black,
          )),
    ],
  );
}
