import 'package:flutter/material.dart';
import 'package:signclock/constant/theme.dart';

class TopScreenStt extends StatelessWidget {
  const TopScreenStt({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            color: Color(0xfff1f1f1),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.settings,
                      color: kPrimaryColor, size: 100.0),
                ),
                //Positioned(
                //  bottom: 0,
                //  right: 0,
                //  child: CircleAvatar(
                //    radius: 20,
                //    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                //    child: Container(
                //      margin: const EdgeInsets.all(8.0),
                //      decoration: const BoxDecoration(
                //          color: Colors.green, shape: BoxShape.circle),
                //    ),
                //  ),
                //),
              ],
            ),
          ),
        )
      ],
    );
  }
}
