import 'dart:io';

import 'package:flick/provider/stngsVm.dart';
import 'package:flick/widgets/listtilemode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/share.dart';
import '../utils/appButtons.dart';
import '../utils/app_constant.dart';
import '../utils/customAppBar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../utils/helper.dart';
import 'chooseonnotify.dart';

class ShareScreen extends StatefulWidget {
  ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  // final String link = "www.checking.com/user:?//shabz";

  String userId = "";

  getUserID() async {
    final pref = await SharedPreferences.getInstance();
    userId = pref.getString(AppConstant.userID) ?? '';
    if (mounted) {
      setState(() {});
    }
    return userId;
  }

  Future downloadFile(context, url) async {
    screenshotController.capture().then((image) async {
      final result = await ImageGallerySaver.saveImage(image!);
      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Image saved to gallery"),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to save image"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to capture screenshot"),
          duration: const Duration(seconds: 2),
        ),
      );
      print(onError);
    });
  }

  // Future downloadFile(context, url) async {

  //   screenshotController.capture().then((image) async {
  //     final downloadsDirectory = await getExternalStorageDirectory();
  //     final filePath = '${DateTime.timestamp()}.png';

  //     screenshotController.captureAndSave(downloadsDirectory!.path,
  //         fileName: filePath);
  //     final filepathisforopen = "${downloadsDirectory.path}/$filePath";

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("📁 $filePath"),
  //         duration: const Duration(seconds: 10),
  //         action: SnackBarAction(
  //           label: 'Open',
  //           onPressed: () async {
  //             await OpenFile.open(filepathisforopen);
  //           },
  //         ),
  //       ),
  //     );
  //   }).catchError((onError) {
  //     Helper.showSnack(context, "Try Later");
  //     print(onError);
  //   });
  // }

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    getUserID();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Share'.tr),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
          child: Column(
            children: [
              Screenshot(
                controller: screenshotController,
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Card(
                      color: context.watch<StngsVmC>().isDarkMode
                          ? Colors.blueGrey.shade50
                          : Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: QrImageView(
                          data: AppConstant.profileView + userId,
                          version: QrVersions.auto,
                          size: 200.0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: width * .6,
                  child: AppButton(
                      icon: Icons.download,
                      title: "Download QR".tr,
                      onpress: () async {
                        final _userid = await getUserID();
                        await downloadFile(
                            context, AppConstant.profileView + _userid);
                      })),
              const SizedBox(
                height: 20,
              ),
              ListView(
                shrinkWrap: true,
                controller: ScrollController(),
                children: [
                  ListTileMode(
                    onTap: () async {
                      var message = Uri.encodeComponent(
                          AppConstant.profileView + await getUserID());
                      var url = 'https://wa.me/?text=$message';
                      try {
                        await launchUrl(Uri.parse(url));
                      } catch (e) {
                        debugPrint('👉 WhatsApp is not installed.');
                      }
                    },
                    leading: const Image(
                      image: AssetImage('lib/photos/images/whatsapp.png'),
                      height: 40,
                      width: 40,
                    ),
                    title: 'Share by Whatsapp'.tr,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTileMode(
                    onTap: () async {
                      await MultiShare().shareOnInstagaram(
                          shareText:
                              AppConstant.profileView + await getUserID());
                    },
                    leading: const Image(
                      image: AssetImage('lib/photos/images/instagram.png'),
                      height: 40,
                      width: 40,
                    ),
                    title: 'Share by Instagram'.tr,
                  ),

                  // ListTile(
                  //   onTap: () async {
                  //     final String subject = 'From Flick App';
                  //     final String body =
                  //         AppConstant.profileView + await getUserID();
                  //     final String encodedSubject =
                  //         Uri.encodeComponent(subject);
                  //     final String encodedBody = Uri.encodeComponent(body);
                  //     final Uri emailLaunchUri = Uri(
                  //       scheme: 'mailto',
                  //       path: 'shabirhassani1@gmail.com',
                  //       queryParameters: {
                  //         'subject': encodedSubject,
                  //         'body': encodedBody,
                  //       },
                  //     );

                  //     if (await canLaunch(emailLaunchUri.toString())) {
                  //       await launch(emailLaunchUri.toString());
                  //     } else {
                  //       throw 'Could not launch ${emailLaunchUri.toString()}';
                  //     }
                  //   },
                  //   leading: Image.asset(
                  //     'lib/photos/images/gmail.png',
                  //     height: 40,
                  //     width: 40,
                  //   ),
                  //   title: Text('Share by Gmail'),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTileMode(
                    onTap: () async {
                      await MultiShare().shareOnMessagingApp(
                          message: AppConstant.profileView + await getUserID());
                    },
                    leading: const Image(
                      image: AssetImage('lib/photos/images/chat.png'),
                      height: 40,
                      width: 40,
                    ),
                    title: 'Share by Text'.tr,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTileMode(
                    onTap: () async {
                      await MultiShare().shareByChooseApp(
                          shareText:
                              AppConstant.profileView + await getUserID());
                    },
                    leading: const Image(
                      image: AssetImage('lib/photos/images/more.png'),
                      height: 40,
                      width: 40,
                    ),
                    title: 'Share by Other'.tr,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
