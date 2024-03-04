import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/helper.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import 'package:flick/utils/constants.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordContrOld = TextEditingController();
  TextEditingController passwordContr1 = TextEditingController();
  TextEditingController passwordContr2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Change Password".tr,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'CarosMedium'),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: passwordContrOld,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            errorBorder: InputBorders.error,
            focusedErrorBorder: InputBorders.error,
            focusedBorder: InputBorders.focused,
            border: const OutlineInputBorder(),
            labelText: 'Current Password'.tr,
            floatingLabelStyle: MaterialStateTextStyle.resolveWith(
              (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? Theme.of(context).colorScheme.error
                    : const Color.fromRGBO(4, 157, 204, 1);
                return TextStyle(color: color, letterSpacing: 1.3);
              },
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: passwordContr1,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            errorBorder: InputBorders.error,
            focusedErrorBorder: InputBorders.error,
            focusedBorder: InputBorders.focused,
            border: const OutlineInputBorder(),
            labelText: 'New Password'.tr,
            floatingLabelStyle: MaterialStateTextStyle.resolveWith(
              (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? Theme.of(context).colorScheme.error
                    : const Color.fromRGBO(4, 157, 204, 1);
                return TextStyle(color: color, letterSpacing: 1.3);
              },
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: passwordContr2,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            errorBorder: InputBorders.error,
            focusedErrorBorder: InputBorders.error,
            focusedBorder: InputBorders.focused,
            border: const OutlineInputBorder(),
            labelText: 'Repeat new Password'.tr,
            floatingLabelStyle: MaterialStateTextStyle.resolveWith(
              (Set<MaterialState> states) {
                final Color color = states.contains(MaterialState.error)
                    ? Theme.of(context).colorScheme.error
                    : const Color.fromRGBO(4, 157, 204, 1);
                return TextStyle(color: color, letterSpacing: 1.3);
              },
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        AppButton(
          title: "Update Password".tr,
          onpress: () async {
            if (passwordContrOld.text.trim().isEmpty) {
              Helper.showSnack(context, "Enter Old Password");
            } else if (passwordContr1.text == passwordContr2.text &&
                passwordContr1.text.trim().isNotEmpty &&
                passwordContr2.text.trim().isNotEmpty) {
              User user = FirebaseAuth.instance.currentUser!;
              await user.updatePassword(passwordContr2.text).then((value) {
                Helper.showSnack(context, "Password Is Updated");
                Navigator.pop(context);
              }).onError((error, stackTrace) {
                Helper.showSnack(context, "$error");
                Navigator.pop(context);
              });
            } else {
              Helper.showSnack(context, "Please Enter Same Password");
            }
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
