import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  FocusNode _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false; // Track the visibility of the password text
  bool _isrepeatPasswordVisible = false;
  FocusNode _repeatpasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Reset Password'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Container(
          height: height,
          width: width,
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
                      "Please enter your new password below",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _updateTextFieldFocus(_passwordFocusNode);
                },
                child: TextFormField(
                  focusNode: _passwordFocusNode,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Enter new Password".tr,
                    helperText: "please do not use spaces".tr,
                    prefixIcon: const Icon(Icons.password_sharp),
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: _passwordFocusNode.hasFocus
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(4, 157, 204, 1),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _updateTextFieldFocus(_repeatpasswordFocusNode);
                },
                child: TextFormField(
                  focusNode: _repeatpasswordFocusNode,
                  obscureText: !_isrepeatPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Repeat new Password".tr,
                    helperText: "please do not use spaces".tr,
                    prefixIcon: const Icon(Icons.password_sharp),
                    suffixIcon: IconButton(
                      icon: Icon(_isrepeatPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isrepeatPasswordVisible = !_isrepeatPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: _repeatpasswordFocusNode.hasFocus
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(4, 157, 204, 1),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                title: "Reset Password".tr,
                onpress: () {
                  showProgressDialogAndNavigate(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateTextFieldFocus(FocusNode focusNode) {
    if (!focusNode.hasFocus) {
      setState(() {
        focusNode.requestFocus();
      });
    }
  }
}

void showProgressDialogAndNavigate(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Please wait...'.tr),
            ],
          ),
        ),
      );
    },
  );

  // Simulate a delay of 5 seconds
  Future.delayed(Duration(seconds: 5), () {
    Navigator.pop(context); // Dismiss the progress dialog

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Password changed successfully'.tr),
                SizedBox(height: 20),
                AppButton(
                  title: "go to Login".tr,
                  onpress: () {
                    Navigator.pushNamed(context, "/LoginScreen");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  });
}
