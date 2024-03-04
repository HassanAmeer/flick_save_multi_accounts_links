import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick/pages/login/login.dart';
import 'package:flick/utils/theme_prefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/changepassword.dart';
import 'package:flick/utils/constants.dart';
import 'package:flick/utils/logout.dart';
import 'package:flick/utils/searchforflick.dart';
import 'package:flick/utils/settingflickbutton.dart';
import 'package:flick/utils/settingsbuttons.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import '../provider/auth.dart';
import '../provider/directtoggleVm.dart';
import '../provider/stngsVm.dart';
import '../services/share.dart';
import '../utils/app_constant.dart';
import '../utils/customAppBar.dart';
import '../utils/helper.dart';
import '../utils/lostmode.dart';
import 'package:provider/provider.dart';
import '../widgets/listtilemode.dart';
import 'package:http/http.dart' as http;
import "package:shared_preferences/shared_preferences.dart";

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final flickCodeController = TextEditingController();

  Color containerColor = const Color.fromARGB(255, 232, 233, 233);
  Color previousColor = const Color.fromARGB(255, 232, 233, 233);
  bool isPrivateModeSwitched = false;
  bool isShareByCategorySwitched = false;
  bool isDarkModeSwitched = false;
  String flickCode = '';
  getUserID() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.userID) ?? '';
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ToggleDirectModeVmC>(context, listen: false)
        .checkMainCatgOnOffValueF();
  }

  void _showFlickCodeModal(BuildContext context) {
    flickCodeController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                // Close the dialog when tapping outside the content
                Navigator.of(context).pop();
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Center(
              child: AlertDialog(
                title: SizedBox(
                    width: double.infinity,
                    child: Align(
                        alignment: Alignment.center,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Enter Flick Code".tr,
                                  style: const TextStyle(
                                      fontSize: 18, fontFamily: 'CarosMedium')),
                              const SizedBox(height: 5),
                              Center(
                                  child: Text(
                                      "Flick code is provided to you in product Package"
                                          .tr,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'CarosMedium'),
                                      textAlign: TextAlign.center))
                            ]))),
                content: TextField(
                    controller: flickCodeController,
                    // keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        flickCode = value;
                      });
                    },
                    decoration: InputDecoration(
                        errorBorder: InputBorders.error,
                        focusedErrorBorder: InputBorders.error,
                        focusedBorder: InputBorders.focused,
                        border: const OutlineInputBorder(),
                        labelText: 'Flick Code'.tr,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2))),
                actions: <Widget>[
                  Center(
                    child: AppButton(
                        title: "Verify".tr,
                        onpress: () async {
                          if (flickCodeController.text.isNotEmpty) {
                            final respDecode = await context
                                .read<ToggleDirectModeVmC>()
                                .activeflickcodeVMF(
                                    context, flickCodeController.text);
                            Navigator.of(context).pop();
                            if (respDecode['exists'].toString() == 'false') {
                              // Helper.showSnack(context, "Flick Code Is Expired");
                            } else {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: const SearchForFlick(),
                                  );
                                },
                              );
                            }
                          } else {
                            Helper.showSnack(context, "Write a Code");
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLanguageCodeModal(BuildContext) {
    showDialog(
      context: context,
      builder: (BuildContext) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                // Close the dialog when tapping outside the content
                Navigator.of(context).pop();
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Center(
              child: AlertDialog(
                title: SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Change Language".tr,
                          style: TextStyle(
                              color: context.watch<StngsVmC>().isDarkMode
                                  ? Colors.white
                                  : Colors.blueGrey.shade900,
                              fontSize: 20,
                              fontFamily: 'CarosMedium'),
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          onPressed: () {
                            Get.updateLocale(const Locale('en', 'US'));
                            Provider.of<StngsVmC>(context, listen: false)
                                .toggleLangVmF(true);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'English'.tr,
                            style: TextStyle(
                                color: context.watch<StngsVmC>().isDarkMode
                                    ? Colors.blueGrey.shade200
                                    : Colors.blueGrey.shade800),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Get.updateLocale(const Locale('ar', 'SA'));
                            Provider.of<StngsVmC>(context, listen: false)
                                .toggleLangVmF(false);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Arabic'.tr,
                            style: TextStyle(
                                color: context.watch<StngsVmC>().isDarkMode
                                    ? Colors.blueGrey.shade200
                                    : Colors.blueGrey.shade800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Center(
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.46,
                    child: const ChangePassword(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogOutModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Center(
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: const LogoutAlert()),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(title: 'Settings'.tr),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(children: [
                  const SizedBox(height: 10),
                  ListTileModeBlue(
                      onTap: () {
                        _showFlickCodeModal(context);
                      },
                      leading: const Image(
                        image: AssetImage(
                          'lib/photos/images/activateflick.png',
                        ),
                        height: 30,
                        width: 30,
                      ),
                      title: "Activate Flick".tr,
                      subtitle: "Activate your Flick product".tr,
                      trailing: IconButton(
                          onPressed: () {
                            _showFlickCodeModal(context);
                          },
                          icon: const Icon(Icons.arrow_forward_ios))),
                  const SizedBox(height: 10),
                  ListTileMode(
                      onTap: () {
                        _showChangePasswordModal(context);
                      },
                      leading: const Image(
                        image:
                            AssetImage('lib/photos/images/changepassword.png'),
                        height: 30,
                        width: 30,
                      ),
                      title: 'Change Password'.tr,
                      subtitle: 'Change your password'.tr,
                      trailing: IconButton(
                          onPressed: () {
                            _showChangePasswordModal(context);
                          },
                          icon: const Icon(Icons.arrow_forward_ios))),
                  const SizedBox(height: 10),
                  ListTileMode(
                    leading: const Image(
                      image: AssetImage('lib/photos/images/privatemode.png'),
                      height: 30,
                      width: 30,
                    ),
                    title: "Private Mode".tr,
                    subtitle:
                        "Share only handles marked in private category".tr,
                    trailing: Switch(
                      value: context.watch<AuthProviders>().isAccountPrivate,
                      // value: isPrivateModeSwitched,
                      onChanged: (value) {
                        // setState(() {
                        //   isPrivateModeSwitched = value;
                        // });
                        final authProvider =
                            Provider.of<AuthProviders>(context, listen: false);
                        authProvider.userActive(value, context, (status) {
                          if (status) {
                            if (authProvider.isAccountPrivate) {
                              Helper.showSnack(
                                  context, 'Your account has been private'.tr);
                            } else {
                              Helper.showSnack(
                                  context, 'Your account has been public'.tr);
                            }
                          } else {
                            Helper.showSnack(context,
                                'There was an issue Please try again'.tr);
                          }
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTileMode(
                    leading: const Image(
                      image:
                          AssetImage('lib/photos/images/sharebycategory.png'),
                      height: 30,
                      width: 30,
                    ),
                    title: "Share by Category".tr,
                    subtitle: "Share profile upon category selection".tr,
                    trailing: Switch(
                      value: context.watch<ToggleDirectModeVmC>().isbycatg,
                      onChanged: (value) {
                        context
                            .read<ToggleDirectModeVmC>()
                            .toggleCatgory(context);
                        // setState(() {
                        //   isShareByCategorySwitched = value;
                        // });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ////////////////////////////////////////////////////////////
                  ListTileMode(
                      onTap: () async {
                        await MultiShare().shareByChooseApp(
                            shareText:
                                AppConstant.profileView + await getUserID());
                      },
                      leading: const Image(
                          image: AssetImage('lib/photos/images/shareqr.png'),
                          height: 30,
                          width: 30),
                      title: "Share QR".tr,
                      subtitle: "Share QR to access your public profile".tr,
                      trailing: IconButton(
                          onPressed: () async {
                            await MultiShare().shareByChooseApp(
                                shareText: AppConstant.profileView +
                                    await getUserID());
                          },
                          icon: const Icon(Icons.arrow_forward_ios_outlined))),
                  const SizedBox(height: 10),
                  ListTileMode(
                    leading: const Image(
                      image: AssetImage('lib/photos/images/darkmode.png'),
                      height: 30,
                      width: 30,
                    ),
                    title: "Dark Mode".tr,
                    subtitle: "View App in Dark Mode".tr,
                    trailing: Switch(
                      value: context.watch<StngsVmC>().isDarkMode,
                      onChanged: (value) {
                        context.read<StngsVmC>().toggleTheme();
                      },
                    ),
                    onTap: () {
                      context.read<StngsVmC>().toggleTheme();
                    },
                  ),
                  const SizedBox(height: 10),
                  ListTileMode(
                    leading: const Image(
                      image: AssetImage('lib/photos/images/language.png'),
                      height: 30,
                      width: 30,
                    ),
                    title: "Language".tr,
                    subtitle: "Change language".tr,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      _showLanguageCodeModal(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  ListTileMode(
                    leading: const Image(
                      image: AssetImage('lib/photos/images/lost.png'),
                      height: 30,
                      width: 30,
                    ),
                    title: "Lost Mode".tr,
                    subtitle: "Disable your tag • Add Custom Message".tr,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: const LostModeModal(),
                          );
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 10),
                  ListTileMode(
                    leading: const Image(
                      image: AssetImage('lib/photos/images/faq.png'),
                      height: 30,
                      width: 30,
                    ),
                    title: "FAQ".tr,
                    // subtitle: "Disable your tag • Add Custom Message".tr,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.pushNamed(context, "/FAQ");
                    },
                  ),

                  // const SizedBox(height: 10),
                  // ListTileMode(
                  //   leading: const Image(
                  //     image: AssetImage('lib/photos/images/faq.png'),
                  //     height: 30,
                  //     width: 30,
                  //   ),
                  //   title: "Contact US".tr,
                  //   // subtitle: "Disable your tag • Add Custom Message".tr,
                  //   trailing: const Icon(Icons.arrow_forward_ios),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, "/ContactScreen");
                  //   },
                  // ),
                  ////////////////////////////////////////////////////////////

                  const SizedBox(height: 10),
                  AppButton(
                      title: "Logout".tr,
                      onpress: () {
                        _showLogOutModal(context);
                      }),
                  const SizedBox(height: 10),
                  AppDeActivateButton(
                      title: "Deactivate Account".tr,
                      onpress: () async {
                        showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text('Want To Deactivate ?'),
                                actions: [
                                  CupertinoButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No')),
                                  CupertinoButton(
                                      onPressed: () async {
                                        await deleteUserAndApi(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text('yes')),
                                ],
                                insetAnimationCurve: Curves.slowMiddle,
                                insetAnimationDuration:
                                    const Duration(seconds: 2),
                              );
                            });
                      })
                ]))));
  }
}

Future<void> deleteUserAndApi(context) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      await user.delete();
      // print('Account deleted from Firebase Authentication');

      String apiUrl = 'https://flickapp.vercel.app/user/delete/${user.uid}';
      var response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Account is Deleted"),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {},
            ),
          ),
        );
        await FirebaseAuth.instance.currentUser!.delete();
        // Provider.of<AuthProviders>(context, listen: false).signOut(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        debugPrint('Error deleting account from API: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$e"),
          duration: const Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {},
          ),
        ),
      );
      debugPrint('Error deleting account: $e');
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("User Not Found"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      ),
    );
  }
}

bool _isProgressDialogShowing = false;
GlobalKey<State<StatefulWidget>> _progressDialogKey =
    GlobalKey<State<StatefulWidget>>();

void showProgressDialogAndNavigate(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Dialog(
            key: _progressDialogKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text('Loading...'.tr),
                ],
              ),
            ),
          );
        },
      );
    },
  );

  Future.delayed(const Duration(seconds: 2), () {
    if (_progressDialogKey.currentContext != null) {
      Navigator.of(_progressDialogKey.currentContext!)
          .pop(); // Dismiss the progress dialog
    }
  });
}
