import 'package:flick/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/theme_prefrences.dart';

class StngsVmC with ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    await StorageC.saveThemeMode(isDarkMode);
    notifyListeners();
  }

  void checkThemeF() async {
    isDarkMode = await StorageC.getThemeMode();
    notifyListeners();
  }

/////////////////////
  bool isLanIsEngMode = true;
  void toggleLangVmF(bool value) async {
    isLanIsEngMode = value;
    await StorageC.saveLangMode(value);
    notifyListeners();
    getLangModeVmF();
  }

  void getLangModeVmF() async {
    isLanIsEngMode = await StorageC.getLangMode();
    debugPrint("👉 language is:$isLanIsEngMode");
    notifyListeners();
  }

  //////////////
  String profilePath = '';
  void setProfilePathVmF(String value) async {
    profilePath = value;
    await StorageC.setProfilePath(value);
    notifyListeners();
    // getLangModeVmF();
  }

  void getProfilePathVmF() async {
    profilePath = await StorageC.getProfilePath();
    notifyListeners();
  }
}
// import 'package:flick/utils/colors.dart';
// import 'package:flutter/material.dart';

// class ThemeVmC with ChangeNotifier {
//   ThemeData _themeData = ThemeData(
//     // fontFamily: 'CarosMedium',
//     // colorScheme: ColorScheme.fromSeed(
//     //     seedColor: const Color.fromRGBO(4, 157, 204, 1)),
//     progressIndicatorTheme: ProgressIndicatorThemeData(
//         color: Colors.blueGrey.shade700, linearTrackColor: Colors.black),
//     outlinedButtonTheme: OutlinedButtonThemeData(
//         style: ButtonStyle(
//             textStyle: MaterialStateProperty.all(
//                 TextStyle(color: Colors.blueGrey.shade200)))),
//     iconTheme: const IconThemeData(color: MaterialColors.lightBlueAccent),
//     bottomSheetTheme:
//         BottomSheetThemeData(backgroundColor: Colors.blueGrey.shade800),
//     primarySwatch: MaterialColors.blue,
//     scaffoldBackgroundColor: Colors.blueGrey.shade900,
//     dialogTheme: DialogTheme(backgroundColor: Colors.blueGrey.shade800),
//     textTheme: const TextTheme(
//         bodyText1: TextStyle(color: Colors.white),
//         bodyText2: TextStyle(color: Colors.white)),
//     inputDecorationTheme: InputDecorationTheme(
//         fillColor: Colors.blueGrey.shade800,
//         labelStyle: const TextStyle(color: Colors.blueGrey),
//         prefixIconColor: Colors.blueGrey.shade400,
//         hintStyle: const TextStyle(color: Colors.blueGrey)),
//     dividerColor: Colors.black,
//     listTileTheme: ListTileThemeData(
//         // titleTextStyle: TextStyle(color: Colors.white),
//         // subtitleTextStyle: TextStyle(color: Colors.blueGrey.shade200),
//         tileColor: Colors.blueGrey.shade700,
//         iconColor: Colors.blueGrey.shade300),
//     appBarTheme: AppBarTheme(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: Colors.blueGrey.shade800,
//         titleTextStyle: const TextStyle(color: Colors.white)),
//   );

//   // ----------------------------------------------------------------------- //
//   ///////////// end of by default theme variables
//   ThemeData get themeData => _themeData;
//   bool isDarkMode = true;

//   void toggleTheme() {
//     _themeData = isDarkMode
//         ?
//         ///// light mode
//         ThemeData(
//             primarySwatch: MaterialColors.blue,
//             scaffoldBackgroundColor: MaterialColors.blue.shade50,
//             iconTheme: const IconThemeData(color: MaterialColors.blue),
//             progressIndicatorTheme: const ProgressIndicatorThemeData(
//                 color: MaterialColors.blue, linearTrackColor: Colors.black),
//             appBarTheme: AppBarTheme(
//                 backgroundColor: Colors.white,
//                 titleTextStyle: TextStyle(color: Colors.blueGrey.shade800),
//                 iconTheme: const IconThemeData(color: Colors.black)),
//             textTheme: const TextTheme(
//               // bodySmall: const TextStyle(color: Colors.white),
//               // bodyMedium: const TextStyle(color: Colors.white),
//               // bodyLarge: const TextStyle(color: Colors.white),
//               bodyText1: TextStyle(color: Colors.black),
//               bodyText2: TextStyle(color: Colors.black),
//             ),
//             inputDecorationTheme: InputDecorationTheme(
//                 fillColor: Colors.blueGrey.shade100,
//                 hintStyle: const TextStyle(color: Colors.white)),
//             listTileTheme: ListTileThemeData(
//                 tileColor: Colors.blueGrey.shade50,
//                 iconColor: Colors.blueGrey.shade800),
//           )
//         //// dark mode
//         : ThemeData(
//             // fontFamily: 'CarosMedium',
//             // colorScheme: ColorScheme.fromSeed(
//             //     seedColor: const Color.fromRGBO(4, 157, 204, 1)),
//             progressIndicatorTheme: ProgressIndicatorThemeData(
//                 color: Colors.blueGrey.shade700,
//                 linearTrackColor: Colors.black),
//             outlinedButtonTheme: OutlinedButtonThemeData(
//                 style: ButtonStyle(
//                     textStyle: MaterialStateProperty.all(
//                         TextStyle(color: Colors.blueGrey.shade200)))),
//             iconTheme:
//                 const IconThemeData(color: MaterialColors.lightBlueAccent),
//             bottomSheetTheme:
//                 BottomSheetThemeData(backgroundColor: Colors.blueGrey.shade800),
//             primarySwatch: MaterialColors.blue,
//             scaffoldBackgroundColor: Colors.blueGrey.shade900,
//             dialogTheme: DialogTheme(backgroundColor: Colors.blueGrey.shade800),
//             textTheme: const TextTheme(
//                 bodyText1: TextStyle(color: Colors.white),
//                 bodyText2: TextStyle(color: Colors.white)),
//             inputDecorationTheme: InputDecorationTheme(
//                 fillColor: Colors.blueGrey.shade800,
//                 labelStyle: const TextStyle(color: Colors.blueGrey),
//                 prefixIconColor: Colors.blueGrey.shade400,
//                 hintStyle: const TextStyle(color: Colors.blueGrey)),
//             dividerColor: Colors.black,
//             listTileTheme: ListTileThemeData(
//                 // titleTextStyle: TextStyle(color: Colors.white),
//                 // subtitleTextStyle: TextStyle(color: Colors.blueGrey.shade200),
//                 tileColor: Colors.blueGrey.shade700,
//                 iconColor: Colors.blueGrey.shade300),
//             appBarTheme: AppBarTheme(
//                 iconTheme: const IconThemeData(color: Colors.white),
//                 backgroundColor: Colors.blueGrey.shade800,
//                 titleTextStyle: const TextStyle(color: Colors.white)),
//           );
//     isDarkMode = !isDarkMode;
//     notifyListeners();
//   }
// }
