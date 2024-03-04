import 'package:flutter/material.dart';

class MaterialColors {
  static const MaterialColor blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF049DCC), // Converted color
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

  static const int _bluePrimaryValue = 0xFF049DCC;

  //////////////////// for dark theme
  static const MaterialColor lightBlueAccent = MaterialColor(
    _lightBlueAccentPrimaryValue,
    <int, Color>{
      100: Color(0xFF80D8FF),
      200: Color(_lightBlueAccentPrimaryValue),
      400: Color(0xFF00B0FF),
      700: Color(0xFF0091EA),
    },
  );
  static const int _lightBlueAccentPrimaryValue = 0xFF40C4FF;
}



//  static const MaterialColor cyan = MaterialColor(
//     _cyanPrimaryValue,
//     <int, Color>{
//        50: Color(0xFFE0F7FA),
//       100: Color(0xFFB2EBF2),
//       200: Color(0xFF80DEEA),
//       300: Color(0xFF4DD0E1),
//       400: Color(0xFF26C6DA),
//       500: Color(_cyanPrimaryValue),
//       600: Color(0xFF00ACC1),
//       700: Color(0xFF0097A7),
//       800: Color(0xFF00838F),
//       900: Color(0xFF006064),
//     },
//   );
//   static const int _cyanPrimaryValue = 0xFF00BCD4;