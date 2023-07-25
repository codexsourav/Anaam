import 'package:flutter/material.dart';

showSnackbar(context, {text = "Hello World!", color = Colors.black}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  var snackdemo = SnackBar(
    content: Text(text.toString()),
    backgroundColor: color,
    elevation: 10,
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
    padding: const EdgeInsets.only(left: 20, top: 2, bottom: 2),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
}
