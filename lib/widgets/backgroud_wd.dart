import 'package:flutter/material.dart';

class BackgroundWg extends StatelessWidget {
  final Widget child;

  const BackgroundWg({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              "assets/trazado_1.png",
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: const Alignment(0, 1.48),
            ),
          ),
          Positioned(
            child: Image.asset(
              "assets/intro_2.png",
              width: size.width * .7,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
