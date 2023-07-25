import 'package:flutter/material.dart';

PreferredSizeWidget TitleBar({title, onback}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
    leading: IconButton(
        onPressed: onback,
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          size: 18,
          color: Color.fromARGB(171, 0, 0, 0),
        )),
    title: Text(
      title ?? "AppBar",
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    ),
  );
}
