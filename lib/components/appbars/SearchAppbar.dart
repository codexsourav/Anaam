import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

PreferredSizeWidget SearchAppbar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: TextField(
      decoration: new InputDecoration.collapsed(hintText: 'Search...'),
      cursorColor: Colors.black,
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Ionicons.search,
            color: const Color.fromARGB(255, 80, 80, 80),
          ))
    ],
  );
}
