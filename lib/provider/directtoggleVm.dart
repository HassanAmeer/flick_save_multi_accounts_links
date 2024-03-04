import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flick/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../datasource/remote/base/api_response.dart';
// import '../repo/auth_repo.dart';
import '../utils/app_constant.dart';
import 'package:flick/provider/auth.dart';

getUserID() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString(AppConstant.userID) ?? '';
}

class ToggleDirectModeVmC with ChangeNotifier {
  bool isDirect = false;
  bool isStartProfileDirectFromVM = false;
  String socialmediaidis = "";

  // checkDirectModeEnabledOrNotF(context) {
  //   try {
  //     isDirect =
  //         Provider.of<AuthProviders>(context, listen: false).getData!.isDirect!;
  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint(
  //         " 💥 when added is Direct Mode from checkDirectModeEnabledOrNotF  $e");
  //   }
  // }

  void toggleDirect(context, boolvalue, socialmediaid,
      {bool? isFromList = false}) async {
    // isDirect = !isDirect;
    try {
      isStartProfileDirectFromVM = true;
      if (isFromList == false) {
        isDirect = boolvalue;
      } else {
        // socialmediaidis = socialmediaid.toString();
        if (boolvalue) {
          socialmediaidis = socialmediaid.toString();
        } else {
          socialmediaidis = "false";
        }
      }

      final userid = await getUserID();
      String apiUrl =
          '${AppConstant.baseUrl}${AppConstant.toggledirect}$userid';

      final resp = await http.put(Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "socialMediaId": socialmediaid.toString(),
            "directMode": boolvalue.toString()
          }));

      log("ðŸ’¥ response when toggle direct :${jsonDecode(resp.body)} socialmediaid:$socialmediaid");
      if (boolvalue == true) {
        Helper.showSnack(context, "Direct Is Enabled");
      } else {
        Helper.showSnack(context, "Direct Is Disabled");
      }
    } catch (e) {
      debugPrint("ðŸ’¥ try catch when toggle direct :$e");
    }
    notifyListeners();
  }

  bool isbycatg = false;
  void toggleCatgory(context) async {
    isbycatg = !isbycatg;

    final userid = await getUserID();
    String apiUrl =
        '${AppConstant.baseUrl}${AppConstant.catgOnOffFromSetting}$userid';

    final resp = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "isSHareByCatgOn": isbycatg,
      }),
    );
    debugPrint("ðŸ‘‰ when share by category from setting page : $resp ");
    if (isbycatg == true) {
      Helper.showSnack(context, "Share By Category Is Enabled");
    } else {
      Helper.showSnack(context, "Share By Category Is Disabled");
    }
    notifyListeners();
  }

  checkMainCatgOnOffValueF() async {
    try {
      final userid = await getUserID();
      final response =
          await Dio().get('${AppConstant.baseUrl}${AppConstant.user}/$userid');
      // debugPrint('Response:$apiResponse');
      if (response.data == null) {
        debugPrint('error');
      } else {
        Map<String, dynamic> newData = response.data;
        if (response.statusCode == 200) {
          isbycatg = newData['data']['isSHareByCatgOn'];
          debugPrint("ðŸ‘‰ checkMainCatgOnOffValueF:$isbycatg");
        }
      }
    } catch (e) {
      debugPrint(
          "ðŸ’¥ when get profile data in checkMainCatgOnOffValueF : $e ");
    }
    notifyListeners();
  }

  /////////////////////
  bool isLostMode = false;
  void toggleLostMode(context, abledisable, details) async {
    isLostMode = abledisable;

    final userid = await getUserID();
    String apiUrl = '${AppConstant.baseUrl}${AppConstant.userActive}${userid}';
    final resp = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "isLost": abledisable.toString(),
        "lostMassege": details.toString()
      }),
    );

    if (abledisable == true) {
      Helper.showSnack(context, "Lost Mode Is Enabled");
    } else {
      Helper.showSnack(context, "Lost Mode Is Disabled");
    }
    await Provider.of<AuthProviders>(context, listen: false)
        .getUserData(context);
    Navigator.pop(context);

    notifyListeners();
  }

  ///////////////////
  activeflickcodeVMF(context, flickcode) async {
    // final userid = await getUserID();
    try {
      String apiUrl = '${AppConstant.baseUrl}${AppConstant.flickcode}';
      final resp = await http.post(Uri.parse(apiUrl),
          // headers: {'Content-Type': 'application/json'},
          body: {"flickNumber": flickcode.toString()});
      // body: jsonEncode({"flickNumber": flickcode.toString()}));
      // "flickNumber": "FL00435X1"
      // {"exists":true,"message":"Flick Code Exists"}
      final respDecode = jsonDecode(resp.body);
      Helper.showSnack(context, "${respDecode['message'].toString()}");
      return respDecode;
    } catch (e) {
      log("ðŸ‘‰try catch when check flick by code: $e");
    }
    // Navigator.pop(context);
    // notifyListeners();
  }
}
