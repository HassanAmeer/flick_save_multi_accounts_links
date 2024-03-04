import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../provider/user_social_info.dart';
import '../../utils/custom_inkwell_btn.dart';
import '../../utils/custom_text.dart';
import '../../utils/helper.dart';
import 'link_validators.dart';
import 'package:provider/provider.dart';

class SocialMediaLinkInput extends StatelessWidget {
  final String iconImagePath;
  final String socialMediaName;

  SocialMediaLinkInput({
    Key? key,
    required this.iconImagePath,
    required this.socialMediaName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(27.0),
              topRight: Radius.circular(27.0),
            ),
          ),
          builder: (BuildContext context) {
            return _bottomSheet();
          },
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.grey.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Image.asset(
              iconImagePath,
              scale: 18,
            ),
            const SizedBox(width: 10),
            CustomText(
              title: socialMediaName,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            const Spacer(),
            Container(
              padding: Get.locale?.languageCode == 'ar'
                  ? EdgeInsets.only(left: 9)
                  : EdgeInsets.only(right: 9),
              child: const Icon(
                Icons.add_circle,
                color: Colors.grey,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  final linkTitleController = TextEditingController();
  final usernameController = TextEditingController();

  String selectedCategory = 'Public';
  Consumer<UserSocialInfo> _bottomSheet() {
    return Consumer<UserSocialInfo>(builder: (context, userSocialInfo, child) {
      bool isChecked = false;
      bool isCheckedTwo = false;
      return StatefulBuilder(builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: MediaQuery.of(context).padding.top + 20,
          ),
          child: SingleChildScrollView(
            primary: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            iconImagePath,
                            scale: 6,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  title: socialMediaName,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'CarosMedium',
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Your input fields and validation can go here
                            Builder(builder: (context) {
                              return LinkInputValidation(
                                key: ValueKey('linkTitleKey'),
                                hintText: 'Link Title'.tr,
                                labelText: 'Link Title'.tr,
                                controller: linkTitleController,
                                errorText: '',
                                validationRegex: '',
                              );
                            }),
                            const SizedBox(height: 7),
                            Builder(builder: (context) {
                              return LinkInputValidation(
                                key: ValueKey('userNameTitleKey'),
                                hintText: '$socialMediaName ${"Username".tr}',
                                labelText: 'Username'.tr,
                                validationRegex: r'.+',
                                errorText: 'this field is required'.tr,
                                controller: usernameController,
                              );
                            }),
                            const SizedBox(height: 7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  title: 'Choose Category'.tr,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  title:
                                      "Please choose category for this application.\nnot choosing any category will make this handle as public\nautomatically"
                                          .tr,
                                  fontSize: 11,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                      color: Colors.blue, width: 1.5),
                                  value: selectedCategory == 'Business'.tr,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedCategory = 'Business'.tr;
                                      } else {
                                        selectedCategory = '';
                                      }
                                      debugPrint(selectedCategory);
                                    });
                                  },
                                ),
                                CustomText(title: 'Business'.tr),
                                const SizedBox(width: 15),
                                Checkbox(
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                      color: Colors.blue, width: 1.5),
                                  value: selectedCategory == 'Public'.tr,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        selectedCategory = 'Public'.tr;
                                      } else {
                                        selectedCategory = '';
                                      }
                                      debugPrint(selectedCategory);
                                    });
                                  },
                                ),
                                CustomText(title: 'Public'.tr),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    userSocialInfo.addSocialMedia(
                                        usernameController.text,
                                        '',
                                        linkTitleController.text,
                                        selectedCategory,
                                        true, (status) {
                                      if (status) {
                                        Navigator.pop(context);
                                        Helper.showSnack(
                                            context,
                                            'Social media link added successfully'
                                                .tr);
                                      } else {
                                        Helper.showSnack(
                                            context,
                                            'Social media link could not be added'
                                                .tr);
                                      }
                                    }, context);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 48,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(56, 199, 243, 1),
                                        Color.fromRGBO(4, 157, 204, 1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: CustomText(
                                    title: "Continue".tr,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 9),

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: CustomInkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 48,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: CustomText(
                                    title: "Cancel".tr,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                        // Continue and Cancel buttons
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
