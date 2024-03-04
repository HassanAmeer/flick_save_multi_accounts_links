import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flick/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../../provider/auth.dart';
import '../../provider/stngsVm.dart';
import '../../utils/helper.dart';

class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({super.key});

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  ScrollController _scrollController = ScrollController();
  bool _isPasswordVisible = false; // Track the visibility of the password text

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _scrollController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Remove focus from text fields when tapped outside
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Consumer<AuthProviders>(builder: (context, authProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(title: 'Signup'.tr),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formkey,
              child: Container(
                height: height,
                width: width,
                child: Column(
                  children: [
                    Container(
                      height: height * .2,
                      width: width,
                      color: Colors.transparent,
                      child: Center(
                        child: context.watch<StngsVmC>().isDarkMode
                            ? const Image(
                                image: AssetImage(
                                    'lib/photos/images/applogodark.png'),
                                width: 100,
                                height: 100,
                              )
                            : const Image(
                                image: AssetImage(
                                    'lib/photos/images/applogolight.png'),
                                width: 100,
                                height: 100,
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          "Add your Signup details below".tr,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        height: height * .25,
                        width: width,
                        // child: Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              //email TextField
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                validator: (value) {
                                  RegExp emailcharacter = RegExp(r'@');
                                  if (value!.isEmpty) {
                                    return ("Email can not be empty".tr);
                                  }
                                  if (!emailcharacter.hasMatch(value)) {
                                    return ("Add @ character please");
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  errorBorder: InputBorders.error,
                                  focusedErrorBorder: InputBorders.error,
                                  focusedBorder: InputBorders.focused,
                                  border: const OutlineInputBorder(),
                                  labelText: 'Email'.tr,
                                  hintText: "abc@gmail.com",
                                  prefixIcon: Icon(Icons.email_outlined),
                                  hintStyle: TextStyle(
                                      color: Colors.blueGrey.shade200),
                                  labelStyle: TextStyle(
                                      color:
                                          context.watch<StngsVmC>().isDarkMode
                                              ? Colors.blueGrey.shade200
                                              : Colors.black),
                                  floatingLabelStyle:
                                      MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                      final Color color = states
                                              .contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Color.fromRGBO(4, 157, 204, 1);
                                      return TextStyle(
                                          color: color, letterSpacing: 1.3);
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                              ),
                              const SizedBox(height: 10),

                              //password TextField
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Password can not be empty".tr);
                                  }
                                  if (value.contains(" ")) {
                                    return ("Password should not include spaces"
                                        .tr);
                                  }

                                  return null;
                                },
                                obscureText: !_isPasswordVisible,

                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: Colors.blueGrey.shade200),
                                  labelStyle: TextStyle(
                                      color:
                                          context.watch<StngsVmC>().isDarkMode
                                              ? Colors.blueGrey.shade200
                                              : Colors.black),
                                  enabledBorder: InputBorders.enabled,
                                  errorBorder: InputBorders.error,
                                  focusedErrorBorder: InputBorders.error,
                                  focusedBorder: InputBorders.focused,
                                  border: const OutlineInputBorder(),

                                  // border: const OutlineInputBorder(),
                                  labelText: 'Password'.tr,
                                  prefixIcon: Icon(Icons.password_outlined),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),

                                  floatingLabelStyle:
                                      MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                      final Color color = states
                                              .contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Color.fromRGBO(4, 157, 204, 1);
                                      return TextStyle(
                                          color: color, letterSpacing: 1.3);
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                // autovalidateMode: AutovalidateMode.always,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //Repeat password TextField
                              TextFormField(
                                controller: _repeatPasswordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Password can not be empty".tr);
                                  }
                                  if (value.contains(" ")) {
                                    return ("Password should not include spaces"
                                        .tr);
                                  }

                                  return null;
                                },
                                obscureText: !_isPasswordVisible,

                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorders.enabled,
                                  errorBorder: InputBorders.error,
                                  focusedErrorBorder: InputBorders.error,
                                  focusedBorder: InputBorders.focused,
                                  border: const OutlineInputBorder(),
                                  hintStyle: TextStyle(
                                      color: Colors.blueGrey.shade200),
                                  labelStyle: TextStyle(
                                      color:
                                          context.watch<StngsVmC>().isDarkMode
                                              ? Colors.blueGrey.shade200
                                              : Colors.black),
                                  // border: const OutlineInputBorder(),
                                  labelText: 'Repeat Password'.tr,
                                  prefixIcon: Icon(Icons.password_outlined),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                  ),

                                  floatingLabelStyle:
                                      MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                                      final Color color = states
                                              .contains(MaterialState.error)
                                          ? Theme.of(context).colorScheme.error
                                          : Color.fromRGBO(4, 157, 204, 1);
                                      return TextStyle(
                                          color: color, letterSpacing: 1.3);
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                // autovalidateMode: AutovalidateMode.always,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AppButton(
                                title: "Signup".tr,
                                onpress: () async {
                                  if (_formkey.currentState!.validate()) {
                                    if (_passwordController.text
                                            .toString()
                                            .trim() !=
                                        _repeatPasswordController.text
                                            .toString()
                                            .trim()) {
                                      Helper.showSnack(
                                          context, "Enter Same Password");
                                    } else {
                                      await authProvider
                                          .signUpWithEmailAndPassword(
                                              context,
                                              _emailController.text,
                                              _passwordController.text);
                                      // showProgressDialogAndNavigate(context);
                                    }
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppButton(
                                title: "Signup with Mobile Number".tr,
                                onpress: () {
                                  Navigator.pushNamed(
                                      context, "/SignupwithMobileScreen");
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  "Or Signup as".tr,
                                  style: TextStyle(
                                      fontFamily: 'CarosMedium',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                  child: InkWell(
                                onTap: () {
                                  authProvider.signInWithGoogle(context);
                                },
                                child: Image(
                                  image: AssetImage(
                                      'lib/photos/images/google.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              )),
                            ],
                          ),
                        ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
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
