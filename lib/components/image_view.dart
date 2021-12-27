import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageUrlView extends StatelessWidget {
  final String url;
  const ImageUrlView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) =>
          Image.asset("assets/images/default-image.png"),
      errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.fill,
    );
  }
}
