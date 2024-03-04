import 'package:flick/provider/auth.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import 'appButtons.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class LogoutAlert extends StatefulWidget {
  const LogoutAlert({super.key});

  @override
  State<LogoutAlert> createState() => _LogoutAlertState();
}

class _LogoutAlertState extends State<LogoutAlert> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        FittedBox(
          child: Text(
            "Are you sure you want to Logout?".tr,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'CarosMedium'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        AppButton(
          title: "Logout".tr,
          onpress: () {
            Provider.of<AuthProviders>(context, listen: false).signOut(context);
          },
        ),
        const SizedBox(
          height: 10,
        ),
        AppDeActivateButton(
            title: "Cancel".tr,
            onpress: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
