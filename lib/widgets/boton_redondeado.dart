import 'package:flutter/material.dart';
import 'package:signclock/constant/theme.dart';

class BotonRedondeado extends StatelessWidget {
  final String text;
  final Function()? press;
  final Color color, textColor;

  const BotonRedondeado({
    super.key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white10,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * .8,
      child: TextButton(
        onPressed: press,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: const BorderSide(
              color: Colors.black,
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
          textStyle: const TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
          backgroundColor: Colors.white,
          foregroundColor: kPrimaryColor,
          fixedSize: const Size(0, 45.0),
        ),
        child: Text(text),
      ),
    );
  }
}
