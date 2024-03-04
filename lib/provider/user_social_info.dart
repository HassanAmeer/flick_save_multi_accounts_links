import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dialog/progress_dialog.dart';
import '../datasource/remote/base/api_response.dart';
import '../repo/user_social_info_repo.dart';
import '../utils/app_constant.dart';
import '../utils/helper.dart';
import "package:http/http.dart" as http;

class UserSocialInfo extends ChangeNotifier {
  final UserSocialInfoRepo userSocialInfoRepo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserSocialInfo({required this.userSocialInfoRepo});
  String category = '';
  updateCategory(String value) {
    category = value;
    notifyListeners();
  }

  bool _isSocialAccountPrivate = false;

  bool get isSocialAccountPrivate => _isSocialAccountPrivate;

  set isSocialAccountPrivate(bool value) {
    _isSocialAccountPrivate = value;
    notifyListeners();
  }

  //  API METHODS ARE GIVEN BELOW
//POST AND PUT METHODs
  Future addSocialMedia(
      String socialMediaName,
      String? socialMediaType,
      String? socialMediaLink,
      String? category,
      bool isActive,
      Function callback,
      BuildContext context) async {
    _isLoading = true;
    var _pr = ProgressDialog(context);
    _pr.show();
    notifyListeners();
    ApiResponse apiResponse = await userSocialInfoRepo.addSocialMedia(
        socialMediaName,
        socialMediaType,
        socialMediaLink,
        category,
        isActive,
        context);
    if (apiResponse.response.data == null) {
      debugPrint('Response:${apiResponse.response}');
      callback(false);
      _pr.hide();

      notifyListeners();
    } else {
      Map newData = apiResponse.response.data;
      debugPrint('Response:${newData}');
      // if (newData["code"] == 200) {
      //
      //
      //   debugPrint('Response:${newData}');
      // }
      callback(true);
      _pr.hide();

      notifyListeners();
    }
    // _pr.hide();

    // _isLoading = false;
  }

  Future updateSocialMedia(
      String? socialMediaName,
      String sociaId,
      String? socialMediaType,
      String? socialMediaLink,
      String? category,
      bool? isActive,
      Function callback,
      BuildContext context) async {
    _isLoading = true;
    var _pr = ProgressDialog(context);
    _pr.show();
    notifyListeners();
    ApiResponse apiResponse = await userSocialInfoRepo.updateSocialMedia(
        socialMediaName,
        sociaId,
        socialMediaType,
        socialMediaLink,
        category,
        isActive,
        context);
    if (apiResponse.response.data == null) {
      debugPrint('Response:${apiResponse.response}');
      callback(false);
      _pr.hide();

      notifyListeners();
    } else {
      Map newData = apiResponse.response.data;
      debugPrint('Response:${newData}');

      // if (newData["code"] == 200) {
      //
      //
      //   debugPrint('Response:${newData}');
      // }
      callback(true);
      _pr.hide();

      notifyListeners();
    }
    // _pr.hide();

    // _isLoading = false;
  }

  List<bool> isAccountActive = [];
  Future socialMediaIsActive(String sociaId, bool isActive, Function callback,
      BuildContext context) async {
    _isLoading = true;

    notifyListeners();
    ApiResponse apiResponse = await userSocialInfoRepo.socialMediaIsActive(
        sociaId, isActive, context);
    if (apiResponse.response.data == null) {
      debugPrint('Response:${apiResponse.response}');
      callback(false);
      notifyListeners();
    } else {
      Map newData = apiResponse.response.data;
      debugPrint('Response:$newData');
      final list = newData['data']['socialMedia'];
      for (var data in list) {
        isAccountActive.add(data['isActive']);
        debugPrint('active value${data['isActive']}');
      }
      callback(true);
      notifyListeners();
    }
  }

  getUserID() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.userID) ?? '';
  }

  // bool isLostMode = false;
  // void toggleLostMode(context, abledisable, details) async {
  //   isLostMode = abledisable;

  //   final userid = await getUserID();
  //   String apiUrl = '${AppConstant.baseUrl}${AppConstant.userActive}${userid}';
  //   final resp = await http.put(
  //     Uri.parse(apiUrl),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       "isLost": abledisable.toString(),
  //       "lostMassege": details.toString()
  //     }),
  //   );

  //   if (abledisable == true) {
  //     Helper.showSnack(context, "Lost Mode Is Enabled");
  //   } else {
  //     Helper.showSnack(context, "Lost Mode Is Disabled");
  //   }
  //   Navigator.pop(context);
  //   notifyListeners();
  // }

  // bool isDirect = false;
  // bool isStartProfileDirectFromVM = false;
  // String socialmediaidis = "";

  // void toggleDirect(context, boolvalue, socialmediaid,
  //     {bool? isFromList = false}) async {
  //   // isDirect = !isDirect;
  //   try {
  //     isStartProfileDirectFromVM = true;
  //     if (isFromList == false) {
  //       isDirect = boolvalue;
  //     } else {
  //       // socialmediaidis = socialmediaid.toString();
  //       if (boolvalue) {
  //         socialmediaidis = socialmediaid.toString();
  //       } else {
  //         socialmediaidis = "false";
  //       }
  //     }

  //     final userid = await getUserID();
  //     String apiUrl =
  //         '${AppConstant.baseUrl}${AppConstant.toggledirect}$userid';

  //     final resp = await http.put(Uri.parse(apiUrl),
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode({
  //           "socialMediaId": socialmediaid.toString(),
  //           "directMode": boolvalue.toString()
  //         }));

  //     log("💥 response when toggle direct :${jsonDecode(resp.body)} socialmediaid:$socialmediaid");
  //     if (boolvalue == true) {
  //       Helper.showSnack(context, "Direct Is Enabled");
  //     } else {
  //       Helper.showSnack(context, "Direct Is Disabled");
  //     }
  //   } catch (e) {
  //     debugPrint("💥 try catch when toggle direct :$e");
  //   }
  //   notifyListeners();
  // }

  Future deleteSocialMedia(
      String sociaId, Function callback, BuildContext context) async {
    _isLoading = true;
    var _pr = ProgressDialog(context);
    _pr.show();

    notifyListeners();
    ApiResponse apiResponse =
        await userSocialInfoRepo.deleteSocialMedia(sociaId, context);
    if (apiResponse.response.data == null) {
      debugPrint('Response:${apiResponse.response}');
      callback(false);
      _pr.hide();

      notifyListeners();
    } else {
      Map newData = apiResponse.response.data;
      debugPrint('Response:${newData}');

      callback(true);
      _pr.hide();

      notifyListeners();
    }
    // _pr.hide();

    // _isLoading = false;
  }
}
