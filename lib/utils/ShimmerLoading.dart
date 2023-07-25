import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget ShimmerBox({double width = 100.0, double height = 100.0}) {
  return SizedBox(
    width: width,
    height: height,
    child: Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 248, 248, 248),
      highlightColor: const Color.fromARGB(255, 255, 255, 255),
      child: Container(
        width: width,
        color: Colors.white,
        height: height,
      ),
    ),
  );
}
