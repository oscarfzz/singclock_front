import 'package:flutter/material.dart';
import 'package:signclock/constant/assets.dart';

import '../constant/theme.dart';

class HeaderLogoLayout extends StatelessWidget {
  final Widget child;

  const HeaderLogoLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 86,
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 105, 102, 102),
                    width: 3.0,
                  ),
                )),
            child: Center(
              child: Container(
                height: 56,
                color: kPrimaryColor,
                child: Image.asset(Assets.logoBlancoS),
              ),
            )),
        Expanded(child: child)
      ],
    );
  }
}
