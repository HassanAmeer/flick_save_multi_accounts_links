//constant key

// ignore_for_file: constant_identifier_names

// import 'package:tictic/models/AuthModels/language_model.dart';

class AppConstant {
  // API BASE URL
  // static const String baseUrl = "https://abc.com/api/";
  // old
  // static const String profileView = "https://flick-app-client.vercel.app/";
//  old end
  static const String baseUrl = "https://flickapp.vercel.app/";
  static const String profileView = "https://flicktags.com/";

  static const String user = 'user';

  static const String userActive = 'user/update/';
  static const String socialMedia = 'socialmedia/';
  static const String toggledirect = 'socialmedia/updateDirectMode/';
  static const String flickcode = 'flickCode/verifyFlickCode';

  static const String socialMediaUpdate = 'socialmedia/update/';
  static const String deleteSocialMedia = 'socialmedia/delete/';
  static const String token = 'token';
  static const String userID = 'userID';
  static const String adddevicetoken = 'user/devicetoken/';
  static const String updatesharebycategoreyoption =
      'user/updatesharebycategoreyoption/';
  static const String catgOnOffFromSetting = 'user/isSHareByCatgOn/'; // post
  static const String updateProfileImage =
      'UserImg/uploadImage/'; // post method with/userid
  // static const String userID = 'userID';
// https://flickapp.vercel.app/socialmedia/update/user:id/:socialMediaId
//////////////////////
  static const String apiKey = "156c4675-9608-4591-b2ec-427503464aac";
}

// 2F4AlJrHfYRWy2fYp17jRyJIlom2