import 'package:flick/pages/widgets/borderfield2.dart';
import 'package:flick/pages/widgets/social_media_input.dart';
import 'package:flick/pages/widgets/link_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../navbar.dart';
import '../provider/stngsVm.dart';
import '../provider/user_social_info.dart';
import '../utils/customAppBar.dart';
import '../utils/custom_inkwell_btn.dart';
import '../utils/custom_text.dart';
import '../utils/helper.dart';
import 'package:provider/provider.dart';

import 'widgets/borderfield.dart';
import 'widgets/chipWidget.dart';

class AddLinkScreen extends StatefulWidget {
  const AddLinkScreen({Key? key}) : super(key: key);

  @override
  _AddLinkScreenState createState() => _AddLinkScreenState();
}

class _AddLinkScreenState extends State<AddLinkScreen> {
  // bool isChecked = false;
  // bool isCheckedTwo = true;
  bool isBusinessCheckBox = false;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<UserSocialInfo>(builder: (context, userSocialInfo, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              title: 'Applications'.tr), // Pass the desired title here
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                // height: 48,
                // width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        onChanged: (query) {
                          setState(() {
                            searchQuery = query;
                          });
                        },
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .transparent), // Border color when focused
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors
                                      .transparent), // Border color when not focused
                            ),
                            hintText: "Search".tr,
                            fillColor: Colors
                                .transparent, // Background color when not focused
                            filled: false,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10)),
                      ),
                    )
                  ],
                )),
          ), //text form field

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      child: CustomText(
                        title: "Contact Info".tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChipWidget(
                                  imgPath: "lib/photos/images/phone.png",
                                  label: "Phone".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Phone"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Phone",
                                        headerImgPath:
                                            "lib/photos/images/phone.png",
                                        title: "Phone".tr,
                                        labelText1: "Call",
                                        hintText1: "Link Title",
                                        labelText2: "Phone Number",
                                        hintText2: "+973 12345678");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/whatsapp.png",
                                  label: "WhatsApp".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "WhatsApp"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "WhatsApp",
                                        headerImgPath:
                                            "lib/photos/images/whatsapp.png",
                                        title: "WhatsApp".tr,
                                        labelText1: "WhatsApp",
                                        hintText1: "Link Title",
                                        labelText2: "WhatsApp",
                                        hintText2: "Number");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/wechat.png",
                                  label: "Wechat".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Wechat"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Wechat",
                                        headerImgPath:
                                            "lib/photos/images/wechat.png",
                                        title: "Wechat".tr,
                                        labelText1: "Wechat",
                                        hintText1: "Link Title",
                                        labelText2: "Wechat User Name",
                                        hintText2: "User Name");
                                  }),
                              const SizedBox(width: 15),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChipWidget(
                                  imgPath: "lib/photos/images/contact.png",
                                  label: "Contact Card".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Contact Card"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Contact Card",
                                        headerImgPath:
                                            "lib/photos/images/contact.png",
                                        title: "Contact Card".tr,
                                        labelText1: "Contact Card",
                                        hintText1: "Link Title",
                                        labelText2: "Contact Info",
                                        hintText2: "Number");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/location.png",
                                  label: "Address".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Address"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Address",
                                        headerImgPath:
                                            "lib/photos/images/location.png",
                                        title: "Address".tr,
                                        labelText1: "Link Title",
                                        hintText1: "Title",
                                        labelText2: "Link",
                                        hintText2: "Address Url");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/facetime.png",
                                  label: "Face Time".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Face Time"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Face Time",
                                        headerImgPath:
                                            "lib/photos/images/facetime.png",
                                        title: "Face Time".tr,
                                        labelText1: "Link Title",
                                        hintText1: "Face Time",
                                        labelText2: "Username",
                                        hintText2: "Face Time Username");
                                  }),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ChipWidget(
                                  imgPath: "lib/photos/images/gmail.png",
                                  label: "Email".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Email"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Email",
                                        headerImgPath:
                                            "lib/photos/images/gmail.png",
                                        title: "Email".tr,
                                        labelText1: "Email Title",
                                        hintText1: "Email",
                                        labelText2: "Email ID",
                                        hintText2: "Email ID");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/viber.png",
                                  label: "Viber".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Viber"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Viber",
                                        headerImgPath:
                                            "lib/photos/images/viber.png",
                                        title: "Viber".tr,
                                        labelText1: "Link Title",
                                        hintText1: "Title",
                                        labelText2: "Viber Number",
                                        hintText2: " Number");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/messages.png",
                                  label: "Messages".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Messages"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Messages",
                                        headerImgPath:
                                            "lib/photos/images/messages.png",
                                        title: "Messages".tr,
                                        labelText1: "Link Title",
                                        hintText1: "Title",
                                        labelText2: "Text",
                                        hintText2: " Text");
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: CustomText(
                          title: "Social Media".tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // "Social Media".tr,
                          Row(
                            children: [
                              ChipWidget(
                                  imgPath: "lib/photos/images/instagram.png",
                                  label: "Instagram".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Instagram"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Instagram",
                                        headerImgPath:
                                            "lib/photos/images/instagram.png",
                                        title: "Instagram".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "Instagram Username");
                                  }),

                              ChipWidget(
                                  imgPath: "lib/photos/images/linkedin.png",
                                  label: "LinkedIn".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "linkedin"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "linkedin",
                                        headerImgPath:
                                            "lib/photos/images/linkedin.png",
                                        title: "LinkedIn".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "linkedin Username");
                                  }),

                              ChipWidget(
                                  imgPath: "lib/photos/images/line.png",
                                  label: "Line".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Line"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Line",
                                        headerImgPath:
                                            "lib/photos/images/line.png",
                                        title: "Line".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "Line Username");
                                  }),

                              ChipWidget(
                                  imgPath: "lib/photos/images/reddit.png",
                                  label: "Reddit".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Reddit"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Reddit",
                                        headerImgPath:
                                            "lib/photos/images/reddit.png",
                                        title: "Reddit".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "Reddit Username");
                                  }),
                              const SizedBox(width: 15),
                              // Add the fifth widget here with its data
                            ],
                          ),

                          Row(
                            children: [
                              ChipWidget(
                                  imgPath: "lib/photos/images/facebook.png",
                                  label: "Facebook".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "facebook"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "facebook",
                                        headerImgPath:
                                            "lib/photos/images/facebook.png",
                                        title: "Facebook".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "facebook Username");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/snapchat.png",
                                  label: "Snapchat".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Snapchat"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "snapchat",
                                        headerImgPath:
                                            "lib/photos/images/snapchat.png",
                                        title: "Snapchat".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "Snapchat Username");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/whatsapp.png",
                                  label: "WhatsApp".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "WhatsApp"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "WhatsApp",
                                        headerImgPath:
                                            "lib/photos/images/whatsapp.png",
                                        title: "WhatsApp".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "WhatsApp Username");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/meetme.png",
                                  label: "Meetme".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Meetme"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "meetme",
                                        headerImgPath:
                                            "lib/photos/images/meetme.png",
                                        title: "Meetme".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "Meetme Username");
                                  }),
                            ],
                          ),

                          Row(
                            children: [
                              ChipWidget(
                                  imgPath: "lib/photos/images/youtube.png",
                                  label: "Youtube".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "YouTube"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "youtube",
                                        headerImgPath:
                                            "lib/photos/images/youtube.png",
                                        title: "YouTube".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "YouTube Username");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/twitterr.png",
                                  label: "X".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Twitter"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "twitter",
                                        headerImgPath:
                                            "lib/photos/images/twitterr.png",
                                        title: "X".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "X Username");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/tiktok.png",
                                  label: "TikTok".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "TikTok"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "TikTok",
                                        headerImgPath:
                                            "lib/photos/images/tiktok.png",
                                        title: "TikTok".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "TikTok Username");
                                  }),
                              ChipWidget(
                                  imgPath: "lib/photos/images/tumblr.png",
                                  label: "Tumblr".tr,
                                  visibility: searchQuery.isEmpty ||
                                      "Tumblr"
                                          .toLowerCase()
                                          .contains(searchQuery.toLowerCase()),
                                  onTap: () {
                                    addLinkSheetF(
                                        addLinkFrom: "Tumblr",
                                        headerImgPath:
                                            "lib/photos/images/tumblr.png",
                                        title: "Tumblr".tr,
                                        labelText1: "Link Title",
                                        hintText1: "title",
                                        labelText2: "Username",
                                        hintText2: "TikTok Username");
                                  }),
                              const SizedBox(width: 15),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: CustomText(
                        title: "Business".tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ChipWidget(
                                    imgPath: "lib/photos/images/website.png",
                                    label: "Website".tr,
                                    visibility: searchQuery.isEmpty ||
                                        "Website".toLowerCase().contains(
                                            searchQuery.toLowerCase()),
                                    onTap: () {
                                      addLinkSheetF(
                                          addLinkFrom: "Website",
                                          headerImgPath:
                                              "lib/photos/images/website.png",
                                          title: "Website".tr,
                                          labelText1: "Link Title",
                                          hintText1: "title",
                                          labelText2: "url",
                                          hintText2: "Website url");
                                    }),
                                ChipWidget(
                                    imgPath:
                                        "lib/photos/images/AndroidAppLink.png",
                                    label: "Play Store".tr,
                                    visibility: searchQuery.isEmpty ||
                                        "Play Store".toLowerCase().contains(
                                            searchQuery.toLowerCase()),
                                    onTap: () {
                                      addLinkSheetF(
                                          addLinkFrom: "Play Store",
                                          headerImgPath:
                                              "lib/photos/images/AndroidAppLink.png",
                                          title: "Play Store".tr,
                                          labelText1: "App Name Title",
                                          hintText1: "App Name",
                                          labelText2: "url",
                                          hintText2: "Play Store url");
                                    }),
                                ChipWidget(
                                    imgPath: "lib/photos/images/foodmenu.png",
                                    label: "Food Menu".tr,
                                    visibility: searchQuery.isEmpty ||
                                        "Food Menu".toLowerCase().contains(
                                            searchQuery.toLowerCase()),
                                    onTap: () {
                                      addLinkSheetF(
                                          addLinkFrom: "Food Menu",
                                          headerImgPath:
                                              "lib/photos/images/foodmenu.png",
                                          title: "Food Menu".tr,
                                          labelText1: "Link Title",
                                          hintText1: "Title",
                                          labelText2: "url",
                                          hintText2: "Food Menu url");
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ChipWidget(
                                    imgPath:
                                        "lib/photos/images/GoogleReview.png",
                                    label: "Google Review".tr,
                                    visibility: searchQuery.isEmpty ||
                                        "Google Review".toLowerCase().contains(
                                            searchQuery.toLowerCase()),
                                    onTap: () {
                                      addLinkSheetF(
                                          addLinkFrom: "Google Review",
                                          headerImgPath:
                                              "lib/photos/images/GoogleReview.png",
                                          title: "Google Review".tr,
                                          labelText1: "Link Title",
                                          hintText1: "Title",
                                          labelText2: "url",
                                          hintText2: "Google Review url");
                                    }),
                                ChipWidget(
                                    imgPath:
                                        "lib/photos/images/HuaweiAppLink.png",
                                    label: "Huawei App".tr,
                                    visibility: searchQuery.isEmpty ||
                                        "Huawei App".toLowerCase().contains(
                                            searchQuery.toLowerCase()),
                                    onTap: () {
                                      addLinkSheetF(
                                          addLinkFrom: "Huawei App",
                                          headerImgPath:
                                              "lib/photos/images/HuaweiAppLink.png",
                                          title: "Huawei App".tr,
                                          labelText1: "Application Name",
                                          hintText1: "Application Name",
                                          labelText2: "url",
                                          hintText2: "Huawei App url");
                                    }),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ChipWidget(
                                    imgPath: "lib/photos/images/IOSAppLink.png",
                                    label: "IOS App".tr,
                                    visibility: searchQuery.isEmpty ||
                                        "IOS App".toLowerCase().contains(
                                            searchQuery.toLowerCase()),
                                    onTap: () {
                                      addLinkSheetF(
                                          addLinkFrom: "IOS App",
                                          headerImgPath:
                                              "lib/photos/images/IOSAppLink.png",
                                          title: "IOS App".tr,
                                          labelText1: "Application Name",
                                          hintText1: "Application Name",
                                          labelText2: "url",
                                          hintText2: "IOS App url");
                                    }),
                                ChipWidget(
                                    imgPath:
                                        "lib/photos/images/tripadvisor.png",
                                    label: "Tripadvisor".tr,
                                    visibility: searchQuery.isEmpty ||
                                        "Tripadvisor".toLowerCase().contains(
                                            searchQuery.toLowerCase()),
                                    onTap: () {
                                      addLinkSheetF(
                                          addLinkFrom: "Tripadvisor",
                                          headerImgPath:
                                              "lib/photos/images/tripadvisor.png",
                                          title: "Tripadvisor".tr,
                                          labelText1: "Link Title",
                                          hintText1: "Title",
                                          labelText2: "url",
                                          hintText2: "Tripadvisor url");
                                    }),
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(height: 20),
                    Container(
                      child: CustomText(
                        title: "Payments".tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChipWidget(
                              imgPath: "lib/photos/images/benefitPay.png",
                              label: "BenefitPay".tr,
                              visibility: searchQuery.isEmpty ||
                                  "BenefitPay"
                                      .toLowerCase()
                                      .contains(searchQuery.toLowerCase()),
                              onTap: () {
                                addLinkSheetF(
                                    addLinkFrom: "BenefitPay",
                                    headerImgPath:
                                        "lib/photos/images/benefitPay.png",
                                    title: "BenefitPay".tr,
                                    labelText1: "Link Title",
                                    hintText1: "Title",
                                    labelText2: "Number",
                                    hintText2: "Number");
                              }),
                          ChipWidget(
                              imgPath: "lib/photos/images/paypal.png",
                              label: "Paypal".tr,
                              visibility: searchQuery.isEmpty ||
                                  "Paypal"
                                      .toLowerCase()
                                      .contains(searchQuery.toLowerCase()),
                              onTap: () {
                                addLinkSheetF(
                                    addLinkFrom: "Paypal",
                                    headerImgPath:
                                        "lib/photos/images/paypal.png",
                                    title: "Paypal".tr,
                                    labelText1: "Link Title",
                                    hintText1: "Title",
                                    labelText2: "Link url",
                                    hintText2: "Link url");
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: CustomText(
                        title: "Music".tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ChipWidget(
                                      imgPath:
                                          "lib/photos/images/applemusic.png",
                                      label: "Apple Music".tr,
                                      visibility: searchQuery.isEmpty ||
                                          "Apple Music".toLowerCase().contains(
                                              searchQuery.toLowerCase()),
                                      onTap: () {
                                        addLinkSheetF(
                                            addLinkFrom: "Apple Music",
                                            headerImgPath:
                                                "lib/photos/images/applemusic.png",
                                            title: "Apple Music".tr,
                                            labelText1: "Link Title",
                                            hintText1: "Title",
                                            labelText2: "Link url",
                                            hintText2: "Link url");
                                      }),
                                  ChipWidget(
                                      imgPath: "lib/photos/images/spotify.png",
                                      label: "Spotify".tr,
                                      visibility: searchQuery.isEmpty ||
                                          "Spotify".toLowerCase().contains(
                                              searchQuery.toLowerCase()),
                                      onTap: () {
                                        addLinkSheetF(
                                            addLinkFrom: "Spotify",
                                            headerImgPath:
                                                "lib/photos/images/spotify.png",
                                            title: "Spotify".tr,
                                            labelText1: "Link Title",
                                            hintText1: "Title",
                                            labelText2: "Link url",
                                            hintText2: "Link url");
                                      }),
                                  ChipWidget(
                                      imgPath:
                                          "lib/photos/images/soundcloud.png",
                                      label: "SoundCloud".tr,
                                      visibility: searchQuery.isEmpty ||
                                          "SoundCloud".toLowerCase().contains(
                                              searchQuery.toLowerCase()),
                                      onTap: () {
                                        addLinkSheetF(
                                            addLinkFrom: "SoundCloud",
                                            headerImgPath:
                                                "lib/photos/images/soundcloud.png",
                                            title: "SoundCloud".tr,
                                            labelText1: "Link Title",
                                            hintText1: "Title",
                                            labelText2: "Link url",
                                            hintText2: "Link url");
                                      }),
                                ])
                          ],
                        )),
                    const SizedBox(height: 20),
                    Container(
                      child: CustomText(
                        title: "Other".tr,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ChipWidget(
                                    imgPath:
                                        "lib/photos/images/Microsoft Teams.png",
                                    label: "Microsoft Teams".tr,
                                    visibility: searchQuery.isEmpty ||
                                        "Microsoft Teams"
                                            .toLowerCase()
                                            .contains(
                                                searchQuery.toLowerCase()),
                                    onTap: () {
                                      addLinkSheetF(
                                          addLinkFrom: "Microsoft Teams",
                                          headerImgPath:
                                              "lib/photos/images/Microsoft Teams.png",
                                          title: "Microsoft Teams".tr,
                                          labelText1: "Link Title",
                                          hintText1: "Title",
                                          labelText2: "Link url",
                                          hintText2: "Link url");
                                    }),
                                ChipWidget(
                                    imgPath: "lib/photos/images/Podcast.png",
                                    label: "Podcast".tr,
                                    visibility: searchQuery.isEmpty ||
                                        "Podcast".toLowerCase().contains(
                                            searchQuery.toLowerCase()),
                                    onTap: () {
                                      addLinkSheetF(
                                          addLinkFrom: "Podcast",
                                          headerImgPath:
                                              "lib/photos/images/Podcast.png",
                                          title: "Podcast".tr,
                                          labelText1: "Link Title",
                                          hintText1: "Title",
                                          labelText2: "Link url",
                                          hintText2: "Link url");
                                    }),
                              ],
                            ),
                            ChipWidget(
                                imgPath: "lib/photos/images/Zoom Meeting.png",
                                label: "Zoom Meeting".tr,
                                visibility: searchQuery.isEmpty ||
                                    "Zoom Meeting"
                                        .toLowerCase()
                                        .contains(searchQuery.toLowerCase()),
                                onTap: () {
                                  addLinkSheetF(
                                      addLinkFrom: "Zoom Meeting",
                                      headerImgPath:
                                          "lib/photos/images/Zoom Meeting.png",
                                      title: "Zoom Meeting".tr,
                                      labelText1: "Link Title",
                                      hintText1: "Title",
                                      labelText2: "Link url",
                                      hintText2: "Link url");
                                }),
                          ],
                        )),
                    const SizedBox(height: 100),
                  ],
                ),
              ), //this single child SV have list view builder
            ),
          ),
        ]),
      );
    });
  }

//////////////////
// addLinkSheetF(addLinkFrom, headerImgPath, title, labelText1, hintText1,
//     labelText2, hintText2)
  void addLinkSheetF(
      {String addLinkFrom = '',
      String headerImgPath = '',
      String title = '',
      String labelText1 = '',
      String hintText1 = '',
      String labelText2 = '',
      String hintText2 = ''}) {
    TextEditingController titleContr = TextEditingController();
    TextEditingController linkContr = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(27.0), topRight: Radius.circular(27.0))),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7 / 1,
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          child: Image.asset(headerImgPath, scale: 6)),
                      const SizedBox(height: 12),
                      CustomText(
                          title: title,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'CarosMedium'),
                      const SizedBox(height: 12),
                      ///////////// call field widget here
                      // BorderFieldWidget(
                      //     controller: titleContr,
                      //     labelText: labelText1.tr,
                      //     hintText: hintText1.tr),
                      Builder(builder: (context) {
                        return LinkInputValidation(
                            height: null,
                            // key: const ValueKey('userNameTitleKey'),
                            hintText: hintText1.tr,
                            labelText: labelText1.tr,
                            validationRegex: r'.+',
                            errorText: 'this field is required'.tr,
                            controller: titleContr);
                      }),
                      const SizedBox(height: 8),
                      // BorderFieldWidget(
                      //     controller: linkContr,
                      //     labelText: labelText2.tr,
                      //     hintText: hintText2.tr),
                      Builder(builder: (context) {
                        return BorderField2Widget(
                          height: null,
                          // key: const ValueKey('userNameTitleKey'),
                          hintText: hintText2.tr,
                          labelText: labelText2.tr,
                          validationRegex: r'.+',
                          errorText: 'this field is required'.tr,
                          controller: linkContr,
                          showSuffixIcon: addLinkFrom != 'Phone' &&
                              addLinkFrom != 'WhatsApp' &&
                              addLinkFrom != 'WhatsApp' &&
                              addLinkFrom != 'Wechat' &&
                              addLinkFrom != 'Contact Card' &&
                              addLinkFrom != 'Face Time' &&
                              addLinkFrom != 'Email' &&
                              addLinkFrom != 'Viber' &&
                              addLinkFrom != 'Messages' &&
                              addLinkFrom != 'Line' &&
                              addLinkFrom != 'Meetme' &&
                              addLinkFrom != 'Tumblr' &&
                              addLinkFrom != 'Google Review' &&
                              addLinkFrom != 'Huawei App' &&
                              addLinkFrom != 'IOS App' &&
                              addLinkFrom != 'Paypal' &&
                              addLinkFrom != 'Apple Music' &&
                              addLinkFrom != 'Spotify' &&
                              addLinkFrom != 'SoundCloud' &&
                              addLinkFrom != 'Podcast' &&
                              addLinkFrom != 'Microsoft Teams' &&
                              addLinkFrom != 'Zoom Meeting' &&
                              addLinkFrom != 'Food Menu' &&
                              addLinkFrom != 'Play Store' &&
                              addLinkFrom != 'Website' &&
                              addLinkFrom != 'Tripadvisor',
                          onSuffixIconTap: () {
                            if (addLinkFrom != 'Phone' &&
                                addLinkFrom != 'WhatsApp' &&
                                addLinkFrom != 'Wechat' &&
                                addLinkFrom != 'Contact Card' &&
                                addLinkFrom != 'Face Time' &&
                                addLinkFrom != 'Email' &&
                                addLinkFrom != 'Viber' &&
                                addLinkFrom != 'Messages' &&
                                addLinkFrom != 'Line' &&
                                addLinkFrom != 'Meetme' &&
                                addLinkFrom != 'Tumblr' &&
                                addLinkFrom != 'Google Review' &&
                                addLinkFrom != 'Huawei App' &&
                                addLinkFrom != 'IOS App' &&
                                addLinkFrom != 'Paypal' &&
                                addLinkFrom != 'Apple Music' &&
                                addLinkFrom != 'Spotify' &&
                                addLinkFrom != 'SoundCloud' &&
                                addLinkFrom != 'Podcast' &&
                                addLinkFrom != 'Microsoft Teams' &&
                                addLinkFrom != 'Zoom Meeting' &&
                                addLinkFrom != 'Food Menu' &&
                                addLinkFrom != 'Play Store' &&
                                addLinkFrom != 'Website') {
                              _showFAQBottomModal(addLinkFrom);
                            }
                          },
                        );
                      }),
                      const SizedBox(height: 7),
                      CustomText(
                          title: "Choose Category".tr,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      const SizedBox(height: 5),
                      CustomText(
                          title:
                              "Please choose category for this application.\nnot choosing any category will make this handle as public\nautomatically"
                                  .tr,
                          fontSize: 11,
                          textAlign: TextAlign.center),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.blue, width: 1.5),
                                value: isBusinessCheckBox,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isBusinessCheckBox = !isBusinessCheckBox;
                                  });
                                }),
                            CustomText(title: 'Business'.tr),
                            const SizedBox(width: 15),
                            Checkbox(
                                checkColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.blue, width: 1.5),
                                value: !isBusinessCheckBox,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isBusinessCheckBox = !isBusinessCheckBox;
                                  });
                                }),
                            CustomText(title: 'Public'.tr)
                          ]),
                      const SizedBox(height: 6),
                      const Spacer(),
                      InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await Provider.of<UserSocialInfo>(context,
                                      listen: false)
                                  .addSocialMedia(
                                      titleContr.text,
                                      title,
                                      linkContr.text,
                                      isBusinessCheckBox
                                          ? 'Business'
                                          : 'Public',
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
                            } else {
                              Helper.showSnack(context, 'Required Fields'.tr);
                            }
                          },
                          child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 48,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(28, 159, 199, 1),
                                            Color.fromRGBO(0, 104, 136, 1)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight)),
                                  child: CustomText(
                                      title: "Continue".tr,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 17)))),
                      const SizedBox(height: 7),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: CustomInkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  height: 48,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: context.watch<StngsVmC>().isDarkMode
                                        ? Colors.blueGrey.shade700
                                        : Colors.white,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: CustomText(
                                      title: "Cancel".tr,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 17))))
                    ]),
              ),
            ),
          );
        });
      },
    );
  }

  void _showFAQBottomModal(String addLinkFrom) {
    String question = '';
    String answer = '';

    if (addLinkFrom == 'Instagram') {
      question = 'How to add my instagram profile URL in Flick?';
      answer =
          'To add instagram url, follow these steps: \n1- Open instagram.\n2- Tap on profile picture.\n3- Tap on "Share Profile" button. \n4- Tap on "Copy Link". \n5- Navigate back to Flick application and paste in username field. \n6- Choose either its Public or Business handle. \n7- Tap on Continue button to save your details.';
    } else if (addLinkFrom == 'snapchat') {
      question = 'How to add my snapchat profile URL in Flick?';
      answer =
          '1- Open Snapchat. \n2- Tap on profile picture. \n3- Tap on share button at top right. \n4- Tap on "Copy". \n5- Navigate back to Flick application and paste in username field. \n6- Choose either its Public or Business handle. \n7- Tap on Continue button to save your details.';
    } else if (addLinkFrom == 'linkedin') {
      question = 'How to add my Linkedin profile URL in Flick?';
      answer =
          '1- open Linkedin.\n2- tap on profile picture. \n3- Tap on View profile. \n4- Tap on 3 dot button. \n5- Tap on "Share profile via...". \n6- Tap on "Copy Link". \n7- Navigate back to Flick application and paste in username field. \n8- Choose either its Public or Business handle. \n9- Tap on Continue button to save your details.';
    } else if (addLinkFrom == 'facebook') {
      question = 'How to add my Facebook profile URL in Flick?';
      answer =
          '1- Open Facebook. \n2- Tap on profile picture. \n3- Tap on 3 dots. \n4- Tap on “Your profile link”. \n5- Navigate back to Flick application and paste the copied link in username Text field. \n6- Choose either its Public or Business handle. \n7- Tap on Continue button to save your details.';
    } else if (addLinkFrom == 'Address') {
      question = 'How to add my Address Link in Flick?';
      answer =
          '1- Open Google Maps. \n2- Tap on your current location or tap and hold on your location for dropping pin point. \n3- Tap on share button. \n4- Copy URL link. \n5- Navigate back to Flick application and paste the copied link in Address Url Text field. \n6- Choose either its Public or Business handle. \n7- Tap on Continue button to save your details.';
    } else if (addLinkFrom == 'youtube') {
      question = 'How to add my Youtube channel Link in Flick?';
      answer =
          '1- Open Youtube application. \n2- Tap on profile picture at the bottom right. \n3- Tap on 3 dots at the top right. \n4- Tap on “Share”. \n5- Tap on Copy Link \n6- Navigate back to Flick application and paste the copied link in channel Link Text field.\n7- Choose either its Public or Business handle. \n8- Tap on Continue button to save your details.';
    } else if (addLinkFrom == 'Reddit') {
      question = 'How to add my Reddit profile URL in Flick?';
      answer =
          '1- Open Reddit Application. \n2- Tap on profile picture at the top right. \n3- Tap on My Profile. \n4- Tap on Share Icon at top right. \n5-Select "Share Profile" and copy the link \n6- Navigate back to Flick application and paste the copied link in username Text field.\n7- Choose either its Public or Business handle. \n8- Tap on Continue button to save your details.';
    } else if (addLinkFrom == 'twitter') {
      question = 'How to add my X profile URL in Flick?';
      answer =
          '1- Open X application. \n2- Tap on profile picture. \n3- Tap Profile tab.  \n4- Tap on 3 dots at the top right. \n4- Tap on Share and copy the link.  \n5- Navigate back to Flick application and paste the copied link in username Text field. \n6- Navigate back to Flick application and paste the copied link in username Text field.\n7- Choose either its Public or Business handle. \n8- Tap on Continue button to save your details.';
    } else if (addLinkFrom == 'facebook') {
      question = 'How to add my Facebook profile URL in Flick?';
      answer =
          '1- Open Facebook. \n2- Tap on profile picture. \n3- Tap on 3 dots. \n4- Tap on “Your profile link”. \n5- Navigate back to Flick application and paste the copied link in username Text field.';
    } else if (addLinkFrom == 'facebook') {
      question = 'How to add my Facebook profile URL in Flick?';
      answer =
          '1- Open Facebook. \n2- Tap on profile picture. \n3- Tap on 3 dots. \n4- Tap on “Your profile link”. \n5- Navigate back to Flick application and paste the copied link in username Text field.';
    } else if (addLinkFrom == 'facebook') {
      question = 'How to add my Facebook profile URL in Flick?';
      answer =
          '1- Open Facebook. \n2- Tap on profile picture. \n3- Tap on 3 dots. \n4- Tap on “Your profile link”. \n5- Navigate back to Flick application and paste the copied link in username Text field.';
    } else if (addLinkFrom == 'facebook') {
      question = 'How to add my Facebook profile URL in Flick?';
      answer =
          '1- Open Facebook. \n2- Tap on profile picture. \n3- Tap on 3 dots. \n4- Tap on “Your profile link”. \n5- Navigate back to Flick application and paste the copied link in username Text field.';
    } else if (addLinkFrom == 'facebook') {
      question = 'How to add my Facebook profile URL in Flick?';
      answer =
          '1- Open Facebook. \n2- Tap on profile picture. \n3- Tap on 3 dots. \n4- Tap on “Your profile link”. \n5- Navigate back to Flick application and paste the copied link in username Text field.';
    } else if (addLinkFrom == 'facebook') {
      question = 'How to add my Facebook profile URL in Flick?';
      answer =
          '1- Open Facebook. \n2- Tap on profile picture. \n3- Tap on 3 dots. \n4- Tap on “Your profile link”. \n5- Navigate back to Flick application and paste the copied link in username Text field.';
    }

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
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),

              const SizedBox(height: 12),
              CustomText(
                title: question,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              const SizedBox(height: 5),

              Align(
                alignment: Alignment.topLeft,
                child: CustomText(
                  title: answer,
                  fontSize: 14,
                  textAlign: TextAlign.start,
                ),
              ),
              // Add more questions and answers here...
            ],
          ),
        );
      },
    );
  }
}
