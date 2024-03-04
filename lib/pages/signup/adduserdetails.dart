import 'package:flick/provider/auth.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/bottomcustommessages.dart';
import 'package:flick/utils/customAppBar.dart';
import 'package:flick/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flick/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class AddUserFirstDetails extends StatefulWidget {
  const AddUserFirstDetails({super.key});

  @override
  State<AddUserFirstDetails> createState() => _AddUserFirstDetailsState();
}

class _AddUserFirstDetailsState extends State<AddUserFirstDetails> {
  final _nameController = TextEditingController();
  final _professionController = TextEditingController();
  final _organizationController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  addUserDetail(BuildContext, AuthProviders authProviders) {
    authProviders.addUser(
        _nameController.text.toString(),
        _professionController.text.toString(),
        _organizationController.text.toString(),
        true,
        context, (status) {
      if (status) {
        Navigator.pop(context); // Dismiss the progress dialog
        Helper.showSnack(context, 'Account created successfully');
        Navigator.pushNamed(context, "/NavBar");
      } else {
        Helper.showSnack(context, 'Failed there was an error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer<AuthProviders>(builder: (context, authProviders, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(title: 'Add Details'.tr),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: height,
            width: width,
            child: Form(
              key: _formkey,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Please enter your Information below".tr,
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              BottomCustomMessage(
                                title:
                                    "This will be shown on your flick profile"
                                        .tr,
                              ),
                            ],
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Name can not be empty".tr);
                      }
                      // if (!emailcharacter.hasMatch(value)) {
                      //   return ("Add @ character please");
                      // }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      errorBorder: InputBorders.error,
                      focusedErrorBorder: InputBorders.error,
                      focusedBorder: InputBorders.focused,
                      border: const OutlineInputBorder(),
                      labelText: 'Name'.tr,
                      hintText: "",
                      // prefixIcon: Icon(Icons.email_outlined),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Color.fromRGBO(4, 157, 204, 1);
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _professionController,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      errorBorder: InputBorders.error,
                      focusedErrorBorder: InputBorders.error,
                      focusedBorder: InputBorders.focused,
                      border: const OutlineInputBorder(),
                      labelText: 'Profession'.tr,

                      hintText: "",
                      // prefixIcon: Icon(Icons.email_outlined),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Color.fromRGBO(4, 157, 204, 1);
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _organizationController,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      errorBorder: InputBorders.error,
                      focusedErrorBorder: InputBorders.error,
                      focusedBorder: InputBorders.focused,
                      border: const OutlineInputBorder(),
                      labelText: 'Organization'.tr,
                      hintText: "",
                      // prefixIcon: Icon(Icons.email_outlined),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Color.fromRGBO(4, 157, 204, 1);
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
                      title: "Save".tr,
                      onpress: () {
                        if (_formkey.currentState!.validate()) {
                          addUserDetail(BuildContext, authProviders);
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
              Text('Loading...'.tr),
            ],
          ),
        ),
      );
    },
  );

  // Simulate a delay of 5 seconds
  Future.delayed(Duration(seconds: 2), () {
    Navigator.pop(context); // Dismiss the progress dialog
    Navigator.pushNamed(context, "/NavBar");
  });
}
