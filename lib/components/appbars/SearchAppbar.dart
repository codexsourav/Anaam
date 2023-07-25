import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

PreferredSizeWidget SearchAppbar({controller, onSearch}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    title: TextField(
      controller: controller,
      decoration: const InputDecoration.collapsed(hintText: 'Search...'),
      cursorColor: Colors.black,
    ),
    actions: [
      IconButton(
          onPressed: onSearch,
          icon: const Icon(
            Ionicons.search,
            color: Color.fromARGB(255, 80, 80, 80),
          ))
    ],
  );
}
