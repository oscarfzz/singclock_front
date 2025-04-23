import 'package:flutter/material.dart';
import 'package:signclock/constant/theme.dart';

class SignButton extends StatelessWidget {
  const SignButton(
      {super.key,
      required this.voidCallback,
      required this.sizeWH,
      required this.icono});

  final VoidCallback voidCallback;
  final double sizeWH;
  final IconData icono;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: IconButton(
          onPressed: voidCallback,
          iconSize: sizeWH,
          icon: Icon(icono),
          color: kPrimaryColor,
        ),
        /*Ink.image(
          image: AssetImage(imagen),
          fit: BoxFit.cover,
          width: sizeWH,
          height: sizeWH,
          child: InkWell(
            onTap: voidCallback,
          ),*/
      ),
    );
  }
}
