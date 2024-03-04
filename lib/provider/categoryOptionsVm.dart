import 'dart:convert';

import 'package:flick/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_constant.dart';

getUserID() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString(AppConstant.userID) ?? '';
}

class CategoryChooseModeVmC with ChangeNotifier {
  addTokenVmF(tokenId) async {
    final userid = await getUserID();
    try {
      String apiUrl =
          '${AppConstant.baseUrl}${AppConstant.adddevicetoken}$userid';
      final resp = await http.post(
        Uri.parse(apiUrl),
        // headers: {'Content-Type': 'application/json'},
        body: {"deviceToken": tokenId.toString()},
      );
      // debugPrint("👉 when addTokenVmF: ${jsonDecode(resp.body)}");
    } catch (error) {
      debugPrint("💥 try catch addTokenVmF: $error");
    }
  }

  ////////////
  // closeCatgChoosedVmF() async {
  //   try {
  //     final userid = await getUserID();
  //     String apiUrl =
  //         '${AppConstant.baseUrl}${AppConstant.closesharebycategory}$userid';
  //     final resp = await http.post(
  //       Uri.parse(apiUrl),
  //       // headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({"userSharebyGategorey": false}),
  //     );
  //     // if choosed option then set to false
  //     debugPrint("👉 response closeCatgChoosedVmF: ${jsonDecode(resp.body)}");
  //   } catch (error) {
  //     debugPrint("💥 try catch closeCatgChoosedVmF: $error");
  //   }
  // }

  ////////////
  chooseOptionCatgVmF(option, context) async {
    try {
      final userid = await getUserID();
      String apiUrl =
          '${AppConstant.baseUrl}${AppConstant.updatesharebycategoreyoption}$userid';
      final resp = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "isChoosedCatgBtnOptions": true,
          "selectedCatgBtnOptionValue": option.toString(),
        }),
      );
      // await closeCatgChoosedVmF();
      Helper.showSnack(
          context, "⚫ Selected: ${option.toString().toUpperCase()}");
      // debugPrint("👉 response chooseOptionCatgVmF: ${jsonDecode(resp.body)}");
    } catch (error) {
      Helper.showSnack(context, "$error");
      // debugPrint("💥 try catch chooseOptionCatgVmF: $error");
    }
  }
}
