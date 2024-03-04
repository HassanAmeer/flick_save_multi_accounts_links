import 'package:flick/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import '../../utils/customAppBar.dart';
import 'package:provider/provider.dart';

class MobileSignUpVerificationScreen extends StatefulWidget {
  const MobileSignUpVerificationScreen({super.key});

  @override
  State<MobileSignUpVerificationScreen> createState() =>
      _MobileSignUpVerificationScreenState();
}

class _MobileSignUpVerificationScreenState
    extends State<MobileSignUpVerificationScreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer<AuthProviders>(builder: (context, authProviders, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false, // Set this to false
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(title: 'Verification Code'.tr),
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
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Enter 6 digit code sent to your registered mobile number"
                            .tr,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 124, 122, 122)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          PinCodeTextField(
                            appContext: context,
                            length: 6, // Length of the code
                            onChanged: (value) {
                              // Handle code changes
                              authProviders.updateNumber(value);
                            },
                            onCompleted: (value) {},
                            validator: (v) {
                              if (v!.length < 6) {
                                return 'write valid code'.tr;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              debugPrint(
                                  'verification code is${authProviders.phoneNo}');
                              authProviders.signInWithPhoneNumber(
                                  authProviders.verficationid,
                                  authProviders.phoneNo,
                                  context);
                            },
                            child: Container(
                              height: height * 0.065,
                              width: width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 139, 138, 138),
                                    offset: Offset(0, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(56, 199, 243, 1),
                                    Color.fromRGBO(4, 157, 204, 1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Verify".tr,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'CarosMedium',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
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
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text('Loading...'.tr),
              ],
            ),
          ),
        );
      },
    );

    // Simulate a delay of 5 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Dismiss the progress dialog
      Navigator.pushNamed(context, "/AddUserFirstDetails");
    });
  }
}
