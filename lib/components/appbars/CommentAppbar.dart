import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

PreferredSizeWidget CommentAppbar(context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          size: 18,
          color: const Color.fromARGB(171, 0, 0, 0),
        )),
    title: Text(
      "Comments",
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    ),
  );
}
