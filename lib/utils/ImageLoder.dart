import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'ShimmerLoading.dart';

Widget ImageLoder({
  required String imgurl,
  double? imgWidget,
  double? imgHeight,
  double loderWidget = 300,
  double loderHeight = 300,
  BoxFit? fit,
}) {
  return CachedNetworkImage(
    fit: fit,
    imageUrl: imgurl,
    height: imgHeight,
    width: imgWidget,
    placeholder: (context, url) =>
        ShimmerBox(width: loderWidget, height: loderHeight),
    errorWidget: (context, url, error) => const Center(
      child: Icon(
        Icons.error,
        color: Color.fromARGB(255, 168, 74, 67),
      ),
    ),
  );
}
