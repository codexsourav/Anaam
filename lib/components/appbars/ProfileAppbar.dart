import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

PreferredSizeWidget ProfileAppbar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Ionicons.settings_outline,
          color: Colors.black,
        )),
    centerTitle: true,
    title: const Text(
      "Profile",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Ionicons.exit_outline,
            color: Colors.black,
          )),
    ],
  );
}
