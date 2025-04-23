import 'package:flutter/material.dart';
import 'package:signclock/constant/assets.dart';

class HeaderLogoTitleLayout extends StatelessWidget {
  final String title;
  final Widget child;

  const HeaderLogoTitleLayout(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          padding: const EdgeInsets.all(20),
          color: const Color.fromARGB(255, 241, 241, 241),
          child: Column(
            children: [
              Container(
                height: 40,
                color: const Color.fromARGB(0, 241, 241, 241),
                child: Image.asset(Assets.logoRojoS),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: child)
      ],
    );
  }
}
