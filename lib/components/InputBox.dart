import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputBox extends StatelessWidget {
  InputBox({
    super.key,
    required this.hint,
    this.controller,
    this.validate,
    this.margin,
    this.ispassword = false,
    this.format,
    this.maxline = 1,
    this.maxlen,
  });

  final String hint;
  final TextEditingController? controller;
  final validate;
  final margin;
  final ispassword;
  final format;
  final maxline;
  final maxlen;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        inputFormatters: format,
        cursorColor: Colors.black,
        obscureText: ispassword,
        maxLength: maxlen,
        maxLines: maxline,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          hintText: hint,
          filled: true,
          hintStyle: const TextStyle(fontWeight: FontWeight.w400),
          contentPadding:
              const EdgeInsets.only(left: 15, bottom: 20, top: 20, right: 15),
          fillColor: const Color.fromARGB(255, 248, 248, 248),
        ),
        validator: validate,
      ),
    );
  }
}
