import 'package:flutter/material.dart';

Color backGroundColor = Colors.white;
Color primary = const Color.fromARGB(255, 181, 74, 190);
// Color primaryColor = const Color.fromARGB(255, 134, 83, 162);
// Color secondaryColor = const Color.fromARGB(255, 227, 67, 217);

Theme myTheme(Widget? child) {
  return Theme(
      data: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.light(
          primary: primary,
          onPrimary: Colors.white,
          surface: Colors.white,
          background: Colors.white,
          onSurface: Colors.black,
          outline: Color.fromARGB(255, 244, 244, 244),
          primaryContainer: primary,
          secondaryContainer: primary,
          tertiaryContainer: primary,
          onPrimaryContainer: Colors.white,
          onSecondaryContainer: Colors.white,
          onTertiaryContainer: Colors.white,
          onSurfaceVariant: Colors.black,
          surfaceVariant: Color.fromARGB(255, 244, 244, 244),
          surfaceTint: Colors.transparent,
        ),
      ),
      child: child!);
}
