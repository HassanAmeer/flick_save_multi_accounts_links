import 'package:flick/provider/auth.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../provider/stngsVm.dart';
import '../../utils/customAppBar.dart';
import 'package:flick/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../utils/helper.dart';

class RecoveryByEmail extends StatefulWidget {
  const RecoveryByEmail({super.key});

  @override
  State<RecoveryByEmail> createState() => _RecoveryByEmailState();
}

class _RecoveryByEmailState extends State<RecoveryByEmail> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer<AuthProviders>(builder: (context, authProviders, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(title: 'Forgot Password'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            height: height,
            width: width,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: height * 0.1,
                    width: width,
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          "Please enter your registered email id below".tr,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      RegExp emailcharacter = RegExp(r'@');

                      if (value!.isEmpty) {
                        return ("Please write valid email".tr);
                      }
                      if (!emailcharacter.hasMatch(value)) {
                        return ("Add @ character please".tr);
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      enabledBorder: InputBorders.enabled,
                      errorBorder: InputBorders.error,
                      focusedErrorBorder: InputBorders.error,
                      focusedBorder: InputBorders.focused,
                      border: const OutlineInputBorder(),
                      labelText: 'Email'.tr,
                      hintText: "abc@gmail.com",
                      prefixIcon: const Icon(Icons.email_outlined),
                      hintStyle: TextStyle(color: Colors.blueGrey.shade200),
                      labelStyle: TextStyle(
                          color: context.watch<StngsVmC>().isDarkMode
                              ? Colors.blueGrey.shade200
                              : Colors.black),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : const Color.fromRGBO(4, 157, 204, 1);
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                      title: "Send Verification Link".tr,
                      onpress: () {
                        if (_formKey.currentState!.validate()) {
                          authProviders.sendPasswordResetEmail(
                              _emailController.text, (status) {
                            if (status) {
                              Navigator.pop(context);
                              Helper.showSnack(context,
                                  'Password reset link has been send to ${_emailController.text}');
                            } else {
                              Helper.showSnack(context,
                                  'The email address is already in use by another account ');
                            }
                          }, context);
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _updateTextFieldFocus(FocusNode focusNode) {
    if (!focusNode.hasFocus) {
      setState(() {
        focusNode.requestFocus();
      });
    }
  }
}
