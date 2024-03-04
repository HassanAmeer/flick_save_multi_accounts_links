import 'package:flick/provider/auth.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../provider/stngsVm.dart';
import '../../utils/customAppBar.dart';
import 'package:provider/provider.dart';
import 'package:flick/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(title: 'Login'.tr),
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
                          "Add your Login details below".tr,
                          style: const TextStyle(fontSize: 18),
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
                              const SizedBox(
                                height: 10,
                              ),

                              //email TextField
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                validator: (value) {
                                  RegExp emailcharacter = RegExp(r'@');

                                  if (value!.isEmpty) {
                                    return ("");
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
                                  prefixIcon: const Icon(Icons.email_outlined),
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
                                          : const Color.fromRGBO(
                                              4, 157, 204, 1);
                                      return TextStyle(
                                          color: color, letterSpacing: 1.3);
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              //password textfield
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
                                  labelText: 'Password'.tr,
                                  prefixIcon:
                                      const Icon(Icons.password_outlined),
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
                                          : const Color.fromRGBO(
                                              4, 157, 204, 1);
                                      return TextStyle(
                                          color: color, letterSpacing: 1.3);
                                    },
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                ),
                                // autovalidateMode: AutovalidateMode.always,
                              ),
                              const SizedBox(height: 5),
                              const SizedBox(
                                height: 5,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    _showBottomModal(context);
                                  },
                                  child: Text(
                                    "Forgot Password?".tr,
                                    style: const TextStyle(
                                      fontFamily: 'CarosMedium',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppButton(
                                title: "Login".tr,
                                onpress: () async {
                                  await authProvider.signInWithEmailAndPassword(
                                      context,
                                      _emailController.text,
                                      _passwordController.text);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppButton(
                                title: "Login with Phone Number".tr,
                                onpress: () {
                                  Navigator.pushNamed(
                                      context, "/LoginwithPhoneScreen");
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  "Or Login in as".tr,
                                  style: const TextStyle(
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
                                child: const Image(
                                  image: AssetImage(
                                      'lib/photos/images/google.png'),
                                  width: 40,
                                  height: 40,
                                ),
                              )),
                            ],
                          ),
                        ),
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

void _showBottomModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double.infinity,
                    child: const Text(
                      "Choose Password Recovery Method",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppButton(
                  title: "Recovery By Email",
                  onpress: () {
                    Navigator.pushNamed(context, "/RecoveryByEmail");
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                AppWhiteButton(
                  title: "Recovery By Mobile Number",
                  onpress: () {
                    Navigator.pushNamed(context, "/RecoveryByMobileNumber");
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// void showProgressDialogAndNavigate(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return const Dialog(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 20),
//               Text('Loading...'),
//             ],
//           ),
//         ),
//       );
//     },
//   );

//   // Simulate a delay of 5 seconds
//   Future.delayed(Duration(seconds: 1), () {
//     Navigator.pop(context); // Dismiss the progress dialog
//     Navigator.pushNamed(context, "/NavBar");
//   });
// }
