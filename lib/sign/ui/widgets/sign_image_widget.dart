import 'package:flutter/material.dart';

class SignImageWidget extends StatelessWidget {
  final String image;
  final double width;
  final double height;

  const SignImageWidget({
    super.key = const Key("SignImageWidget"),
    required this.image,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.white, width: 2.0),
          image: DecorationImage(
              image: NetworkImage(image.toString()), fit: BoxFit.cover)),
    );
  }
}
