import 'package:flick/provider/auth.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flick/utils/constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../provider/stngsVm.dart';

class SignupwithMobileScreen extends StatefulWidget {
  const SignupwithMobileScreen({super.key});

  @override
  State<SignupwithMobileScreen> createState() => _SignupwithMobileScreenState();
}

class _SignupwithMobileScreenState extends State<SignupwithMobileScreen> {
  ScrollController _scrollController = ScrollController();
  bool _isPasswordVisible = false;
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(onTap: () {
      // Remove focus from text fields when tapped outside
      _emailFocusNode.unfocus();
      _passwordFocusNode.unfocus();
    }, child: Consumer<AuthProviders>(builder: (context, authProvider, child) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(title: 'Signup with Mobile Number'.tr)),
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                  key: _formkey,
                  child: Container(
                      height: height,
                      width: width,
                      child: Column(children: [
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
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "Enter your Signup details Below".tr,
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                            child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Column(children: [
                                  const SizedBox(height: 10),
                                  Container(
                                      width: width,
                                      height: 50,
                                      child: InternationalPhoneNumberInput(
                                          hintText: '',
                                          selectorTextStyle: TextStyle(
                                              color: context
                                                      .watch<StngsVmC>()
                                                      .isDarkMode
                                                  ? Colors.blueGrey.shade200
                                                  : Colors.black),
                                          validator: (v) {
                                            // Check if the provided phone number matches the defined format
                                            if (v!.length < 9) {
                                              return 'Please write valid number'
                                                  .tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                          onInputChanged: (PhoneNumber number) {
                                            // Handle phone number input changes
                                            authProvider.updateNumber(
                                                number.phoneNumber.toString());
                                          },
                                          selectorConfig: const SelectorConfig(
                                              selectorType:
                                                  PhoneInputSelectorType
                                                      .DROPDOWN,
                                              leadingPadding: 0,
                                              trailingSpace: false),
                                          countries: const [
                                            'SA',
                                            'QA',
                                            'AE',
                                            'KW',
                                            'BH',
                                            'OM',
                                            'PK'
                                          ], // GCC countries
                                          textFieldController:
                                              TextEditingController(),
                                          inputBorder:
                                              const OutlineInputBorder(),
                                          onSaved: (PhoneNumber number) {
                                            // Save the phone number
                                          })),
                                  const SizedBox(height: 10),

                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  //password TextField
                                  // TextFormField(
                                  //   validator: (value) {
                                  //     if (value!.isEmpty) {
                                  //       return ("Password can not be empty");
                                  //     }
                                  //     if (value.contains(" ")) {
                                  //       return ("Password should not include spaces");
                                  //     }
                                  //
                                  //     return null;
                                  //   },
                                  //   obscureText: !_isPasswordVisible,
                                  //
                                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                                  //   decoration: InputDecoration(
                                  //     enabledBorder: InputBorders.enabled,
                                  //     errorBorder: InputBorders.error,
                                  //     focusedErrorBorder: InputBorders.error,
                                  //     focusedBorder: InputBorders.focused,
                                  //     border: const OutlineInputBorder(),
                                  //
                                  //     // border: const OutlineInputBorder(),
                                  //     labelText: 'Password',
                                  //     prefixIcon: Icon(Icons.password_outlined),
                                  //     suffixIcon: IconButton(
                                  //       icon: Icon(_isPasswordVisible
                                  //           ? Icons.visibility_off
                                  //           : Icons.visibility),
                                  //       onPressed: () {
                                  //         setState(() {
                                  //           _isPasswordVisible = !_isPasswordVisible;
                                  //         });
                                  //       },
                                  //     ),
                                  //
                                  //     floatingLabelStyle:
                                  //         MaterialStateTextStyle.resolveWith(
                                  //       (Set<MaterialState> states) {
                                  //         final Color color =
                                  //             states.contains(MaterialState.error)
                                  //                 ? Theme.of(context).colorScheme.error
                                  //                 : Color.fromRGBO(4, 157, 204, 1);
                                  //         return TextStyle(
                                  //             color: color, letterSpacing: 1.3);
                                  //       },
                                  //     ),
                                  //     contentPadding: const EdgeInsets.symmetric(
                                  //         vertical: 10, horizontal: 10),
                                  //   ),
                                  //   // autovalidateMode: AutovalidateMode.always,
                                  // ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  // //Repeat password TextField
                                  // TextFormField(
                                  //   validator: (value) {
                                  //     if (value!.isEmpty) {
                                  //       return ("Password can not be empty");
                                  //     }
                                  //     if (value.contains(" ")) {
                                  //       return ("Password should not include spaces");
                                  //     }
                                  //
                                  //     return null;
                                  //   },
                                  //   obscureText: !_isPasswordVisible,
                                  //
                                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                                  //   decoration: InputDecoration(
                                  //     enabledBorder: InputBorders.enabled,
                                  //     errorBorder: InputBorders.error,
                                  //     focusedErrorBorder: InputBorders.error,
                                  //     focusedBorder: InputBorders.focused,
                                  //     border: const OutlineInputBorder(),
                                  //
                                  //     // border: const OutlineInputBorder(),
                                  //     labelText: 'Repeat Password',
                                  //     prefixIcon: Icon(Icons.password_outlined),
                                  //     suffixIcon: IconButton(
                                  //       icon: Icon(_isPasswordVisible
                                  //           ? Icons.visibility_off
                                  //           : Icons.visibility),
                                  //       onPressed: () {
                                  //         setState(() {
                                  //           _isPasswordVisible = !_isPasswordVisible;
                                  //         });
                                  //       },
                                  //     ),
                                  //
                                  //     floatingLabelStyle:
                                  //         MaterialStateTextStyle.resolveWith(
                                  //       (Set<MaterialState> states) {
                                  //         final Color color =
                                  //             states.contains(MaterialState.error)
                                  //                 ? Theme.of(context).colorScheme.error
                                  //                 : Color.fromRGBO(4, 157, 204, 1);
                                  //         return TextStyle(
                                  //             color: color, letterSpacing: 1.3);
                                  //       },
                                  //     ),
                                  //     contentPadding: const EdgeInsets.symmetric(
                                  //         vertical: 10, horizontal: 10),
                                  //   ),
                                  //   // autovalidateMode: AutovalidateMode.always,
                                  // ),
                                  SizedBox(
                                      height: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  const SizedBox(height: 20),
                                  AppButton(
                                      title: "Signup".tr,
                                      onpress: () {
                                        if (_formkey.currentState!.validate()) {
                                          // debugPrint(
                                          //     'phone number is ${authProvider.phoneNo}');
                                          authProvider.verifyPhone(
                                              authProvider.phoneNo, context);
                                        }
                                      })
                                ])))
                      ])))));
    }));
  }

  void _updateTextFieldFocus(FocusNode focusNode) {
    if (!focusNode.hasFocus) {
      setState(() {
        focusNode.requestFocus();
      });
    }
  }
}
