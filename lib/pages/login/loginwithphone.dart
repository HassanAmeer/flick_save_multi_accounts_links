import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../provider/auth.dart';
import '../../provider/stngsVm.dart';
import '../../utils/customAppBar.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flick/utils/constants.dart';

class LoginwithPhoneScreen extends StatefulWidget {
  const LoginwithPhoneScreen({super.key});

  @override
  State<LoginwithPhoneScreen> createState() => _LoginwithPhoneScreenState();
}

class _LoginwithPhoneScreenState extends State<LoginwithPhoneScreen> {
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
            child: CustomAppBar(title: 'Login with Mobile Number'.tr),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
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
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Enter your Registered Mobile Number Below".tr,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              width: width,
                              height: 75,
                              child: InternationalPhoneNumberInput(
                                validator: (v) {
                                  // Check if the provided phone number matches the defined format
                                  if (v!.length < 9) {
                                    return 'Please write valid number'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                onInputChanged: (PhoneNumber number) {
                                  authProvider.updateNumber(
                                      number.phoneNumber.toString());
                                },
                                hintText: '',
                                textStyle: TextStyle(
                                    color: context.watch<StngsVmC>().isDarkMode
                                        ? Colors.blueGrey.shade300
                                        : Colors.blueGrey.shade800),
                                selectorTextStyle: TextStyle(
                                    color: context.watch<StngsVmC>().isDarkMode
                                        ? Colors.blueGrey.shade300
                                        : Colors.blueGrey.shade800),
                                selectorConfig: const SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DROPDOWN,
                                  leadingPadding: 0,
                                  trailingSpace: false,
                                ),
                                countries: const [
                                  'SA',
                                  'QA',
                                  'AE',
                                  'KW',
                                  'BH',
                                  'OM',
                                  'PK'
                                ], // GCC countries
                                textFieldController: TextEditingController(),
                                inputBorder: const OutlineInputBorder(),
                                onSaved: (PhoneNumber number) {
                                  // Save the phone number
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            // TextFormField(
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return ("Password can not be empty".tr);
                            //     }
                            //     if (value.contains(" ")) {
                            //       return ("Password should not include spaces".tr);
                            //     }

                            //     return null;
                            //   },
                            //   obscureText: !_isPasswordVisible,
                            //   autovalidateMode: AutovalidateMode.onUserInteraction,
                            //   decoration: InputDecoration(
                            //     enabledBorder: InputBorders.enabled,
                            //     errorBorder: InputBorders.error,
                            //     focusedErrorBorder: InputBorders.error,
                            //     focusedBorder: InputBorders.focused,
                            //     border: const OutlineInputBorder(),

                            //     // border: const OutlineInputBorder(),
                            //     labelText: 'Password'.tr,
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
                            // ),
                            const SizedBox(height: 10),
                            Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/RecoveryByMobileNumber");
                                    },
                                    child: Text("Forgot Password?".tr,
                                        style: TextStyle(
                                            fontFamily: 'CarosMedium',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)))),
                            const SizedBox(height: 20),
                            AppButton(
                              title: "Login".tr,
                              onpress: () {
                                if (_formkey.currentState!.validate()) {
                                  Provider.of<AuthProviders>(context,
                                          listen: false)
                                      .verifyPhone(
                                          authProvider.phoneNo, context);
                                }
                                // Navigator.pushNamed(
                                //     context, "/VerificationCodeScreen");
                              },
                            ),
                            const SizedBox(height: 10),
                            AppWhiteButton(
                              title: "Login with Email".tr,
                              onpress: () {
                                Navigator.pushReplacementNamed(
                                    context, "/LoginScreen");
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
