import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final ontap;
  final text;
  final disable;
  final loading;

  const MyButton({
    super.key,
    this.ontap,
    this.text,
    this.disable = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disable || loading ? null : ontap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: loading ? const Color.fromARGB(255, 34, 34, 34) : Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: loading
              ? const Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              : Text(
                  text.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
        ),
      ),
    );
  }
}
