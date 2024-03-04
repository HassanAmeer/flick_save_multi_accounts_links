// ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick/Dialog/progress_dialog.dart';
import 'package:flick/provider/user_social_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Model/Auth/get_user_data.dart';
import '../Model/Auth/user.dart';
import '../datasource/remote/base/api_response.dart';
import 'package:provider/provider.dart';
import '../pages/chooseonnotify.dart';
import '../repo/auth_repo.dart';
import '../utils/helper.dart';

class AuthProviders extends ChangeNotifier {
  final AuthRepo authRepo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthProviders({required this.authRepo});
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verficationid = '';

  //sign up and sign with email and password
  Future<String?> signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    final _pr = ProgressDialog(context);
    _pr.show();
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = _auth.currentUser;
      debugPrint('User:$firebaseUser');
      clearUserID();
      authRepo.saveUserID(_auth.currentUser!.uid.toString());
      _pr.hide();

      Helper.showSnack(context, 'Account created successfully!');
      Navigator.pushNamed(context, "/AddUserFirstDetails");
      userModel = UserModel(
        email: firebaseUser!.email,
        phone: firebaseUser!.phoneNumber,
        isActive: true,
      );
      return null;
    } catch (e) {
      _pr.hide();
      Helper.showSnack(context, 'Account creation failed');
      return e.toString();
    }
  }

  Future<String?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    final _pr = ProgressDialog(context);
    _pr.show();
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        _pr.hide();
        clearUserID();
        authRepo.saveUserID(_auth.currentUser!.uid.toString());

        Helper.showSnack(context, 'logged in successfully!');
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/NavBar",
          (route) => false, // Removes all previous routes from the stack
        );
      });
      return null;
    } catch (e) {
      _pr.hide();
      Helper.showSnack(context, 'Logged in failed check credentails please');
      return e.toString();
    }
  }

//  Sign in with phone number firebase
  String phoneNo = '';
  updateNumber(String number) {
    phoneNo = number;
    notifyListeners();
  }

  verifyPhone(String phoneNumber, BuildContext context,
      {bool isResendOtp = false}) async {
    var _pr = ProgressDialog(context);
    _pr.show();
    int? forceResendToken;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber.toString().trim(),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically handles verification on some devices
      },
      verificationFailed: (FirebaseAuthException exception) {
        // Handle verification failure
        _pr.hide();
        Helper.showSnack(context, 'verification failed');
        debugPrint('verification failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint('code sent');
        _pr.hide();

        Navigator.pushNamed(context, "/MobileSignUpVerificationScreen");
        Helper.showSnack(context, 'code has been send to your number');

        forceResendToken = resendToken;
        verficationid = verificationId;
        notifyListeners();

        // Save the verification ID somewhere to use it later
        // e.g., in a state variable
        // and show a UI to enter the verification code
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: isResendOtp ? forceResendToken : null,
    );
    notifyListeners();
  }

  Future signInWithPhoneNumber(
      String verificationId, String smsCode, BuildContext context,
      {bool fromLogin = false}) async {
    debugPrint('$smsCode');
    debugPrint('$verificationId');

    ProgressDialog _pr = ProgressDialog(context);
    _pr.show();
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      debugPrint(
          'phone credentials:${credential.verificationId} ${credential.smsCode}');
      final UserCredential? authResult =
          await _signInWithCredential(credential, context, _pr);

      User? firebaseUser = authResult!.user;

      debugPrint('Phone User:$firebaseUser');
      userModel = UserModel(
        email: '${credential.verificationId}@email.com',
        phone: firebaseUser!.phoneNumber,
        isActive: true,
      );
      if (authResult.additionalUserInfo!.isNewUser) {
        Helper.showSnack(context, 'Signed was successful');
        Navigator.pushNamedAndRemoveUntil(
            context, "/AddUserFirstDetails", (route) => false);
        clearUserID();
        authRepo.saveUserID(_auth.currentUser!.uid.toString());
      } else {
        Navigator.pushNamedAndRemoveUntil(context, "/NavBar", (route) => false);
      }
    } catch (e, stk) {
      clearUserID();
      _pr.hide();
      if (e.toString().contains("Null check operator")) {
        if (fromLogin) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/NavBar", (route) => false);
        }
      }
      debugPrint(e.toString());
      debugPrint(stk.toString());

      Helper.showSnack(context, 'verification failed');
    }
  }

  UserModel? userModel;
  UserCredential? userCredential;
  Future<UserCredential?> _signInWithCredential(PhoneAuthCredential credential,
      BuildContext context, ProgressDialog pr) async {
    try {
      userCredential = await _auth.signInWithCredential(credential);
      debugPrint('User :${userCredential?.user}');
      debugPrint('unique key :${_auth.currentUser!.uid.toString()}');
      clearUserID();

      authRepo.saveUserID(_auth.currentUser!.uid.toString());
      pr.hide();
      notifyListeners();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      pr.hide();
      if (e.code ==
          'The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again') {
        Helper.showSnack(context,
            'The verification code from SMS/TOTP is invalid. Please check and enter the correct verification code again');
      }
    }
  }

  deleteUserFromFirebase() async {
    User? user = userCredential?.user;
    if (user != null) {
      try {
        await user.delete();
        print('User deleted successfully.');
      } catch (e) {
        print('Error deleting user: $e');
      }
    } else {
      print('No user currently signed in.');
    }
    notifyListeners();
  }

  // Sign in with Google
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        debugPrint('unique key :${_auth.currentUser!.uid.toString()}');
        clearUserID();

        authRepo.saveUserID(_auth.currentUser!.uid.toString());
        final User? firebaseUser = authResult.user;
        debugPrint('User:$firebaseUser');

        userModel = UserModel(
          email: firebaseUser!.email,
          phone: firebaseUser.phoneNumber,
          isActive: true,
        );

        if (authResult.additionalUserInfo!.isNewUser) {
          if (firebaseUser != null) {
            Helper.showSnack(context, 'Signed up was successful');
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/AddUserFirstDetails",
              (route) => false, // Removes all previous routes from the stack
            );

            final String? profilePictureURL = googleSignInAccount.photoUrl;
          } else {
            Navigator.pop(context);
          }
        } else {
          Helper.showSnack(context, 'Signed in successfully');
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/NavBar",
            (route) => false, // Removes all previous routes from the stack
          );
        }
      } catch (e, stacktrace) {
        // Navigator.pop(context);
        debugPrint('stacktrace $stacktrace');

        Helper.showSnack(context, "Google Sign-In Error: $e");
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        Helper.showSnack(
          context,
          'The account already exists with a different credential',
        );
      } else if (e.code == 'invalid-credential') {
        Helper.showSnack(
          context,
          'Error occurred while accessing credentials. Try again.',
        );
      }
    } catch (e) {
      log("💥 try catch when login with authentication: $e");
      Helper.showSnack(
        context,
        'Error occurred using Google Sign In. Try again.',
      );
    }
  }

  // Sign out
  Future<void> signOut(BuildContext context) async {
    clearUserID();
    await _googleSignIn.signOut();
    await _auth.signOut();

    notifyListeners();

    // Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/WelcomeScreen",
      (route) => false, // Removes all previous routes from the stack
    );
  }

  // Check if the user is signed in
  User? getCurrentUser() {
    return _auth.currentUser;
  }

//  reset password by email

  Future<void> sendPasswordResetEmail(
      String email, Function callback, BuildContext context) async {
    // var _pr = ProgressDialog(context);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // _pr.hide();
      callback(true);
      notifyListeners();
    } catch (e, stk) {
      // _pr.hide();
      callback(false);

      print('Failed to send password reset email: $stk');

      // You can throw an exception or handle the error in a different way
      throw Exception('Failed to send password reset email');
    }
  }

//  API METHODS ARE GIVEN BELOW
//POST AND PUT METHODs
  Future addUser(String name, String profession, String organization,
      bool isActive, BuildContext context, Function callback) async {
    notifyListeners();
    try {
      var _pr = ProgressDialog(context);
      _pr.show();
      ApiResponse apiResponse = await authRepo.addUser(name, userModel!.email,
          userModel!.phone, profession, organization, isActive);
      if (apiResponse.response.data == null) {
        _isLoading = false;
        callback(false);
        _pr.hide();
        notifyListeners();
      } else {
        Map newData = apiResponse.response.data;
        debugPrint('Response:$newData');
        // if (newData["code"] == 200) {
        //
        //
        //   debugPrint('Response:${newData}');
        // }
        callback(true);
        notifyListeners();
      }
    } catch (e, stk) {
      debugPrint(stk.toString());
    }
    // _pr.hide();

    // _isLoading = false;
  }

  bool isAccountPrivate = false;
  // bool isAccountDirect = false;
  bool isStartProfilePrivateFromVM = false;
  Future userActive(
      bool isActive, BuildContext context, Function callback) async {
    notifyListeners();
    ApiResponse apiResponse = await authRepo.userActive(isActive);
    isStartProfilePrivateFromVM = true;
    if (apiResponse.response.data == null) {
      callback(false);
      notifyListeners();
    } else {
      Map newData = apiResponse.response.data;
      debugPrint('Response:$newData');
      isAccountPrivate = isActive;
      // isAccountPrivate = newData['data']['isActive'];
      // isAccountDirect = newData['data']['directMode'];
      callback(true);
      notifyListeners();
    }
    // _pr.hide();
    // _isLoading = false;
  }

  Future userInfoUpdate(
      String? name,
      String? email,
      String? phone,
      String? profession,
      String? organization,
      Function callback,
      BuildContext context) async {
    var _pr = ProgressDialog(context);
    _pr.show();
    notifyListeners();
    ApiResponse apiResponse = await authRepo.userInfoUpdate(
        name, email, phone, profession, organization);
    if (apiResponse.response.data == null) {
      _pr.hide();
      callback(false);
      notifyListeners();
    } else {
      Map newData = apiResponse.response.data;
      debugPrint('Response:$newData');
      _pr.hide();
      callback(true);

      // if (newData["code"] == 200) {
      //
      //
      //   debugPrint('Response:${newData}');
      // }

      notifyListeners();
    }
  }

  String userImage = " ";
  // bool mainCatgOnOff = false;
  GetUserData? getData;
  //GET METHODS
  Future getUserData(BuildContext context) async {
    _isLoading = true;
    getData = null;

    try {
      ApiResponse apiResponse = await authRepo.getUserData();
      debugPrint('Response:$apiResponse');
      if (apiResponse.response.data == null) {
        _isLoading = false;
        debugPrint('error');
      } else {
        Map<String, dynamic> newData = apiResponse.response.data;
        if (apiResponse.response.statusCode == 200) {
          debugPrint('Response:$newData');

          getData = GetUserData.fromJson(newData['data']);
          isAccountPrivate = getData!.isActive!;
          // isAccountDirect = getData!.isDirect!;
          // mainCatgOnOff = newData['data']['isSHareByCatgOn'];
          userImage = newData['data']['userImage'] ?? " ";
          final list = newData['data']['socialMedia'];
          for (var data in list) {
            context
                .read<UserSocialInfo>()
                .isAccountActive
                .add(data['isActive']);
            // debugPrint('active value${data['isActive']}');
          }
        }
        //////
        if (newData['data']['isChoosedCatgBtnOptions']
                .toString()
                .toLowerCase() ==
            "false") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChooseCategoryOnNotifyPage(),
            ),
          );
        }
        //////
      }
    } catch (e, stk) {
      // _isLoading = false;
      debugPrint(stk.toString());
    }
    notifyListeners();
  }

  bool isLoadingProfileDataForDirect = false;
  bool isLoadingProfileDataForPrivate = false;
  //GET METHODS
  Future updateProfileDataOnSwitchBtnF(BuildContext context, loadingFor) async {
    try {
      if (loadingFor == "direct") {
        isLoadingProfileDataForDirect = true;
      } else {
        isLoadingProfileDataForPrivate = true;
      }
      ApiResponse apiResponse = await authRepo.getUserData();
      debugPrint('Response:$apiResponse');
      if (apiResponse.response.data == null) {
      } else {
        Map<String, dynamic> newData = apiResponse.response.data;
        if (apiResponse.response.statusCode == 200) {
          getData = GetUserData.fromJson(newData['data']);
          isAccountPrivate = getData!.isActive!;
          // isAccountDirect = getData!.isDirect!;
          final list = newData['data']['socialMedia'];
          for (var data in list) {
            context
                .read<UserSocialInfo>()
                .isAccountActive
                .add(data['isActive']);
          }
        }
      }
    } catch (e, stk) {
      debugPrint(stk.toString());
    }
    if (loadingFor == "direct") {
      isLoadingProfileDataForDirect = false;
    } else {
      isLoadingProfileDataForPrivate = false;
    }
    notifyListeners();
  }

  String getUserId() {
    return authRepo.getUserID();
  }

  clearUserID() async {
    if (authRepo.isExistsCustomerID()) await authRepo.clearUserID();
  }
}
