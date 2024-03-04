import 'package:flick/provider/stngsVm.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../provider/auth.dart';

class RecoverbyMobileNumber extends StatefulWidget {
  const RecoverbyMobileNumber({super.key});

  @override
  State<RecoverbyMobileNumber> createState() => _RecoverbyMobileNumberState();
}

class _RecoverbyMobileNumberState extends State<RecoverbyMobileNumber> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final _formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Forgot Password'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SizedBox(
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
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Please enter your registered Mobile Number below".tr,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formkey,
                child: SizedBox(
                  width: width,
                  height: 50,
                  child: InternationalPhoneNumberInput(
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
                      'PK',
                      'OM'
                    ], // GCC countries
                    textFieldController: TextEditingController(),
                    inputBorder: const OutlineInputBorder(),
                    onSaved: (PhoneNumber number) {
                      // Save the phone number
                    },
                    onInputChanged: (PhoneNumber number) {
                      Provider.of<AuthProviders>(context, listen: false)
                          .updateNumber(number.phoneNumber.toString());
                    },
                    validator: (v) {
                      if (v!.length < 6) {
                        return 'Enter Valid Phone'.tr;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                  title: "Verify".tr,
                  onpress: () {
                    if (_formkey.currentState!.validate()) {
                      showProgressDialogAndNavigate(context);
                      AuthProviders authProviderVar =
                          Provider.of<AuthProviders>(context, listen: false);
                      authProviderVar.verifyPhone(
                          authProviderVar.phoneNo, context);
                    }
                  })
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
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pop(context); // Dismiss the progress dialog
      Navigator.pushNamed(context, "/ResetVerificationCodeScreen");
    });
  }
}
