import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFB01A24);
const kPrimaryLightColor = Color(0xFFFABFAC);

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xffB01A24, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff701117), //10%
      100: Color(0xffb74c3a), //20%
      200: Color(0xffFC2634), //30%
      300: Color(0xff89392b), //40%
      400: Color(0xffB01A24), //50%
      500: Color(0xff5c261d), //60%
      600: Color(0xff451c16), //70%
      700: Color(0xffBD1C27), //80%
      800: Color(0xff96171F), //90%
      900: Color(0xff000000), //100%
    },
  );
}

// Paleta de color del chat
class PaletteCh {
  static Color primaryColor = Colors.white;
  static Color accentColor = const Color.fromARGB(255, 247, 79, 79);
  static Color secondaryColor = Colors.black;

  static Color gradientStartColor = accentColor;
  static Color gradientEndColor = const Color.fromARGB(255, 253, 106, 106);
  static Color errorGradientStartColor = const Color(0xffd50000);
  static Color errorGradientEndColor = const Color(0xff9b0000);

  static Color primaryTextColorLight = Colors.white;
  static Color secondaryTextColorLight = Colors.white70;
  static Color hintTextColorLight = Colors.white70;

  static Color selfMessageBackgroundColor =
      const Color.fromARGB(255, 247, 79, 79);
  static Color otherMessageBackgroundColor = Colors.white;

  static Color selfMessageColor = Colors.white;
  static Color otherMessageColor = const Color(0xff3f3f3f);

  static Color greyColor = Colors.grey;

  static Color primaryTextColor = Colors.black;
  static Color secondaryTextColor = Colors.black87;
  static Color primaryBackgroundColor = Colors.white;
}
