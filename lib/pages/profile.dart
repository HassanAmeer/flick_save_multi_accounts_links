import 'package:flick/pages/chooseonnotify.dart';
import 'package:flick/pages/widgets/borderfield2.dart';
import 'package:flick/pages/widgets/link_validators.dart';
import 'package:flick/provider/auth.dart';
import 'package:flick/provider/stngsVm.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/colors.dart';
import 'package:flick/utils/customAppBar.dart';
import 'package:flick/utils/imageAssets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import '../provider/directtoggleVm.dart';
import '../provider/homePageProvider.dart';

import 'package:url_launcher/url_launcher.dart';
import '../provider/user_social_info.dart';
import '../utils/IconWithVertTitle.dart';
import '../utils/app_constant.dart';
import '../utils/custom_inkwell_btn.dart';
import '../utils/custom_text.dart';
import '../utils/helper.dart';
import 'edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  int activePageIndex = 0;
  final PageController pageController = PageController(initialPage: 0);
  void initState() {
    super.initState();
    context.read<AuthProviders>().getUserData(context);
    Provider.of<StngsVmC>(context, listen: false).getProfilePathVmF();
    Provider.of<HomePageProvider>(context, listen: false).tabFuncation(this);
    // Listen to page changes and update the activePageIndex accordingly
    pageController.addListener(() {
      setState(() {
        activePageIndex = pageController.page!.round();
      });
    });
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    iconRotation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  late int colorCondition = 0;
  bool firstContainerVisible = true;
  late AnimationController controller;
  late Animation<double> iconRotation;

  void toggleContainers() {
    if (firstContainerVisible) {
      firstContainerVisible = false;
    } else {
      firstContainerVisible = true;
    }
    setState(() {});

    if (controller.isCompleted || controller.isDismissed) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  getUserID() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.userID) ?? '';
  }

  // FHvC8EbudWNaR0fzt2Fqy5KTXyu1
// esLGG4QMTp2BpHgoCjDJ1D:APA91bFrqxMgWY07T4CNZC6T_kc9y8k98SrJaRAIdmACzYbhoNXCFaX1NZ7jXGY-cLGfpBSwe8X0NsZwwBBJ1chDRcJ1PPR-hVPNwelpY7BLSzY5-g1jBck2XyZGvuXaHZHnNlBWvoXl
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    Locale currentLocale = Get.locale!;
    bool isArabic = currentLocale.languageCode == 'ar';

    double containerHeight = screenHeight <= 451
        ? MediaQuery.of(context).size.height * 0.31
        : MediaQuery.of(context).size.height * 0.33;

    return Consumer3<HomePageProvider, AuthProviders, UserSocialInfo>(builder:
        (context, homePageProvider, authProvider, userSocialInfo, child) {
      // if (authProvider.getData!.isChoosedCatgBtnOptions == true) {
      //   Navigator.push(j
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const ChooseCategoryOnNotifyPage(),
      //     ),
      //   );
      // }

      return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(title: 'Profile'.tr)),
          body: authProvider.getData != null
              ? Stack(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        // ElevatedButton(onPressed: (){
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const ChooseCategoryOnNotifyPage()
                        //     )
                        //   );
                        // }, child: const Text("notify")),
                        Container(
                            height: 10,
                            decoration: BoxDecoration(
                                color: context.watch<StngsVmC>().isDarkMode
                                    ? Colors.blueGrey.shade900
                                    : MaterialColors.blue.shade50)),
                        Container(
                            height:
                                MediaQuery.of(context).size.height * 0.3 / 1,
                            decoration: BoxDecoration(
                                color: context.watch<StngsVmC>().isDarkMode
                                    ? Colors.blueGrey.shade900
                                    : MaterialColors.blue.shade50),
                            child: Stack(children: [
                              Column(
                                children: [
                                  const SizedBox(height: 53),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      // height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                          color: context
                                                  .watch<StngsVmC>()
                                                  .isDarkMode
                                              ? Colors.blueGrey.shade700
                                              : Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: context
                                                      .watch<StngsVmC>()
                                                      .isDarkMode
                                                  ? Colors.black
                                                      .withOpacity(0.6)
                                                  : Colors.grey
                                                      .withOpacity(0.6),
                                              offset: const Offset(0, 0),
                                              blurRadius: 7,
                                              spreadRadius: 1,
                                            )
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: isArabic
                                                ? Alignment.centerLeft
                                                : Alignment.centerRight,
                                            padding: const EdgeInsets.only(
                                                left: 25, right: 25, top: 5),
                                            // color: greyColor,
                                            //  height: 25,
                                            child: CustomInkWell(
                                              onTap: () {
                                                Helper.toScreen(
                                                    context,
                                                    EditProfile(
                                                        profileImageLink:
                                                            authProvider
                                                                .userImage
                                                                .toString()));
                                              },
                                              child: CircleAvatar(
                                                  backgroundColor: context
                                                          .watch<StngsVmC>()
                                                          .isDarkMode
                                                      ? Colors.blueGrey.shade600
                                                      : Colors.blueGrey.shade50,
                                                  child: Icon(
                                                      Icons.edit_outlined,
                                                      color: MaterialColors
                                                          .blue.shade400)),
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              alignment: Alignment.center,
                                              child: CustomText(
                                                  title: authProvider
                                                              .getData!.name !=
                                                          null
                                                      ? "${authProvider.getData!.name}"
                                                      : 'Demo Name'.tr,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Container(
                                              padding:
                                                  const EdgeInsets.only(top: 2),
                                              alignment: Alignment.center,
                                              child: CustomText(
                                                  title: authProvider.getData!
                                                              .profession !=
                                                          null
                                                      ? "${authProvider.getData!.profession}"
                                                      : 'Demo Profession'.tr,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: 14)),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 0),
                                            alignment: Alignment.center,
                                            child: CustomText(
                                              title: authProvider.getData!
                                                          .organization !=
                                                      null
                                                  ? "${authProvider.getData!.organization}"
                                                  : 'Demo Organization'.tr,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 14,
                                            ),
                                          ),
                                          Divider(
                                              color: Colors.blueGrey.shade400,
                                              height: 7),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  if (!await launchUrl(
                                                      mode: LaunchMode
                                                          .externalApplication,
                                                      Uri.parse(AppConstant
                                                              .profileView +
                                                          await getUserID()))) {
                                                    throw Exception(
                                                        'Could not launch "');
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.remove_red_eye),
                                                    const SizedBox(width: 3),
                                                    CustomText(
                                                      title: "Preview".tr,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(children: [
                                                authProvider.isLoadingProfileDataForDirect ==
                                                        true
                                                    ? const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10.0),
                                                        child: SizedBox(
                                                            width: 15,
                                                            height: 15,
                                                            child: CircularProgressIndicator(
                                                                color:
                                                                    MaterialColors
                                                                        .blue,
                                                                strokeWidth:
                                                                    2)))
                                                    : CustomText(
                                                        title: "Direct".tr,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                const SizedBox(width: 8),
                                                SizedBox(
                                                    height: 30,
                                                    width: 40,
                                                    child: Switch(
                                                        value: context
                                                                .watch<
                                                                    ToggleDirectModeVmC>()
                                                                .isStartProfileDirectFromVM
                                                            ? context
                                                                .watch<
                                                                    ToggleDirectModeVmC>()
                                                                .isDirect
                                                            : authProvider
                                                                    .getData!
                                                                    .isDirect ??
                                                                false,
                                                        // authProvider
                                                        //     .isAccountDirect,
                                                        onChanged: (v) {
                                                          context
                                                              .read<
                                                                  ToggleDirectModeVmC>()
                                                              .toggleDirect(
                                                                  context,
                                                                  v,
                                                                  authProvider
                                                                          .getData!
                                                                          .socialMedia![
                                                                              0]
                                                                          .id ??
                                                                      "xyz");
///// check if isprivate then private off
                                                          if (v == true &&
                                                              authProvider
                                                                  .isAccountPrivate) {
                                                            authProvider
                                                                .userActive(
                                                                    false,
                                                                    context,
                                                                    (status) {});
                                                          }
                                                          if (v == true) {
                                                            firstContainerVisible =
                                                                false;
                                                            setState(() {});
                                                          }
                                                          context
                                                              .read<
                                                                  AuthProviders>()
                                                              .updateProfileDataOnSwitchBtnF(
                                                                  context,
                                                                  "direct");
                                                        }))
                                              ]),
                                              Row(
                                                children: [
                                                  authProvider.isLoadingProfileDataForPrivate ==
                                                          true
                                                      ? const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10.0),
                                                          child: SizedBox(
                                                              width: 15,
                                                              height: 15,
                                                              child: CircularProgressIndicator(
                                                                  color:
                                                                      MaterialColors
                                                                          .blue,
                                                                  strokeWidth:
                                                                      2)))
                                                      : CustomText(
                                                          title: "Private".tr,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  const SizedBox(width: 8),
                                                  SizedBox(
                                                    height: 30,
                                                    width: 40,
                                                    // color: Colors.red,
                                                    child: Switch(
                                                      value:
                                                          // authProvider
                                                          //                 .getData!
                                                          //                 .isActive ==
                                                          //             false &&
                                                          //         authProvider
                                                          //             .isStartProfilePrivateFromVM
                                                          //     ? authProvider
                                                          //         .isAccountPrivate
                                                          //     :

                                                          authProvider
                                                              .isAccountPrivate,
                                                      onChanged: (value) {
                                                        authProvider.userActive(
                                                            value, context,
                                                            (status) {
                                                          if (status) {
                                                            if (authProvider
                                                                .isAccountPrivate) {
                                                              Helper.showSnack(
                                                                  context,
                                                                  'Your account has been private'
                                                                      .tr);
                                                              var checksdirect =
                                                                  context
                                                                      .read<
                                                                          ToggleDirectModeVmC>()
                                                                      .isDirect;

                                                              if (checksdirect) {
                                                                context
                                                                    .read<
                                                                        ToggleDirectModeVmC>()
                                                                    .toggleDirect(
                                                                        context,
                                                                        false,
                                                                        "xyz");
                                                              }
                                                            } else {
                                                              Helper.showSnack(
                                                                  context,
                                                                  'Your account has been public'
                                                                      .tr);
                                                            }
                                                          } else {
                                                            Helper.showSnack(
                                                                context,
                                                                'There was an issue Please try again'
                                                                    .tr);
                                                          }
                                                        });
                                                        context
                                                            .read<
                                                                AuthProviders>()
                                                            .updateProfileDataOnSwitchBtnF(
                                                                context,
                                                                "private");
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 7)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                  left: MediaQuery.of(context).size.width / 2.7,
                                  top: 5,
                                  child: Consumer<StngsVmC>(
                                      builder: (context, stngVm, child) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfile(
                                                          profileImageLink:
                                                              authProvider
                                                                  .userImage
                                                                  .toString())));
                                        },
                                        child: Container(
                                            height: 90,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 3),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.6),
                                                      offset:
                                                          const Offset(0, 0),
                                                      blurRadius: 20.0,
                                                      spreadRadius: 1)
                                                ]),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: Image.network(
                                                    authProvider.userImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                            'lib/photos/images/user1.png',
                                                            fit: BoxFit
                                                                .cover)))));
                                  }))
                            ])),
                        CustomInkWell(
                            onTap: toggleContainers,
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 0),
                                alignment: Alignment.centerRight,
                                child: RotationTransition(
                                    turns: iconRotation,
                                    child: AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        child: firstContainerVisible
                                            ? const Icon(
                                                CupertinoIcons.list_bullet,
                                                key: ValueKey('list'))
                                            : const Icon(
                                                CupertinoIcons.square_grid_2x2,
                                                key: ValueKey('arrow')))))),
                        if (firstContainerVisible)
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              height:
                                  MediaQuery.of(context).size.height * 0.31 / 1,
                              width: double.infinity,
                              child: authProvider
                                      .getData!.socialMedia!.isNotEmpty
                                  ? GridView.count(
                                      shrinkWrap: true,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5,
                                      controller: ScrollController(),
                                      physics: const ScrollPhysics(),
                                      crossAxisCount: 3,
                                      childAspectRatio: (0.5 / 0.5),
                                      children: List.generate(
                                          authProvider.getData!.socialMedia!
                                              .length, (index) {
                                        final data = authProvider
                                            .getData!.socialMedia![index];
                                        return CustomInkWell(
                                            onTap: () {
                                              _bottomSheet(
                                                  getImagePathByTitle(data
                                                      .socialMediaType
                                                      .toString()),
                                                  '${data.socialMediaName}',
                                                  data.id.toString(),
                                                  data.socialMediaType,
                                                  data.socialMediaLink,
                                                  data.category);
                                            },
                                            child: Container(
                                                padding: const EdgeInsets.only(
                                                    top: 3),
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: IconWithVertTitle(
                                                  imgSrc: getImagePathByTitle(
                                                      data.socialMediaType
                                                          .toString()),
                                                  height: 55,
                                                  title: data.socialMediaName
                                                              .toString()
                                                              .length >=
                                                          25
                                                      ? "${data.socialMediaName.toString().substring(0, 24)}.."
                                                      : data.socialMediaName
                                                          .toString(),
                                                )));
                                      }))
                                  : Center(
                                      child: CustomText(
                                          title: 'No link is added'.tr,
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14))),
                        if (!firstContainerVisible)
                          Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.4 / 1,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child:
                                      authProvider
                                              .getData!.socialMedia!.isNotEmpty
                                          ? ListView.builder(
                                              controller: ScrollController(),
                                              // physics: const ScrollPhysics(),
                                              // childAspectRatio: (0.9 / 0.16),
                                              itemCount: authProvider
                                                  .getData!.socialMedia!.length,
                                              itemBuilder: (context, index) {
                                                final data = authProvider
                                                    .getData!
                                                    .socialMedia![index];
                                                return Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 4,
                                                        left: 4,
                                                        right: 4,
                                                        bottom: index == authProvider.getData!.socialMedia!.length - 1
                                                            ? 80
                                                            : 1),
                                                    child: ListTile(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(
                                                                15)),
                                                        leading: InkWell(
                                                            onTap: () {
                                                              _bottomSheet(
                                                                  getImagePathByTitle(data
                                                                      .socialMediaType
                                                                      .toString()),
                                                                  '${data.socialMediaName}',
                                                                  data.id
                                                                      .toString(),
                                                                  data.socialMediaType,
                                                                  data.socialMediaLink,
                                                                  data.category);
                                                            },
                                                            child: const Icon(
                                                                Icons.more_vert,
                                                                size: 20)),
                                                        title: Row(
                                                            mainAxisSize: MainAxisSize
                                                                .min,
                                                            children: [
                                                              Image.asset(
                                                                  getImagePathByTitle(data
                                                                      .socialMediaType
                                                                      .toString()),
                                                                  scale: 15),
                                                              const SizedBox(
                                                                  width: 14),
                                                              CustomText(
                                                                title: data.socialMediaName
                                                                            .toString()
                                                                            .length >=
                                                                        14
                                                                    ? "${data.socialMediaName.toString().substring(0, 13)}..."
                                                                    : data
                                                                        .socialMediaName
                                                                        .toString(),
                                                              )
                                                              // "${authProvider.getData!.socialMedia![index].socialMediaName}")
                                                            ]),
                                                        // subtitle: Text(
                                                        //     userSocialInfo.isAccountActive[index]
                                                        //         .toString()),
                                                        trailing:
                                                            context.watch<ToggleDirectModeVmC>().isDirect ==
                                                                        true &&
                                                                    userSocialInfo.isAccountActive[index]
                                                                            .toString() ==
                                                                        "false"
                                                                ? Opacity(
                                                                    opacity: userSocialInfo.isAccountActive[index].toString() ==
                                                                            "false"
                                                                        ? 0.4
                                                                        : 1,
                                                                    child: Switch(
                                                                        value:
                                                                            false,
                                                                        onChanged:
                                                                            (value) {}))
                                                                : context.watch<ToggleDirectModeVmC>().isDirect ==
                                                                        true
                                                                    ? Switch(
                                                                        value: context.read<ToggleDirectModeVmC>().socialmediaidis.isNotEmpty
                                                                            ? context.read<ToggleDirectModeVmC>().socialmediaidis.toString().toLowerCase() == authProvider.getData!.socialMedia![index].id.toString().toLowerCase()
                                                                                ? true
                                                                                : false
                                                                            : context.read<ToggleDirectModeVmC>().socialmediaidis.toString() == "false"
                                                                                ? false
                                                                                : authProvider.getData!.socialMedia![index].socialMediaDirectMode ?? false,
                                                                        thumbColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                                                                        onChanged: (value) {
                                                                          context.read<ToggleDirectModeVmC>().toggleDirect(
                                                                              context,
                                                                              value,
                                                                              authProvider.getData!.socialMedia![index].id.toString() ?? "xyz",
                                                                              isFromList: true);
                                                                        })
                                                                    : Switch(
                                                                        value: userSocialInfo.isAccountActive[index]
                                                                            as bool,
                                                                        onChanged:
                                                                            (value) {
                                                                          debugPrint(
                                                                              'swtched value:$value');
                                                                          userSocialInfo.isAccountActive[index] =
                                                                              value;
                                                                          setState(
                                                                              () {});

                                                                          context.read<UserSocialInfo>().socialMediaIsActive(
                                                                              authProvider.getData!.socialMedia![index].id
                                                                                  .toString(),
                                                                              userSocialInfo.isAccountActive[index],
                                                                              (status) {
                                                                            if (status) {
                                                                              if (userSocialInfo.isAccountActive[index]) {
                                                                                Helper.showSnack(context, '${authProvider.getData!.socialMedia![index].socialMediaName} account has been private');
                                                                              } else {
                                                                                Helper.showSnack(context, '${authProvider.getData!.socialMedia![index].socialMediaName} account has been public');
                                                                              }
                                                                            } else {}
                                                                          }, context);
                                                                        },
                                                                      )

                                                        // subtitle: Text(authProvider
                                                        //     .getData!
                                                        //     .socialMedia![index]
                                                        //     .socialMediaDirectMode
                                                        //     .toString()),
                                                        ));
                                              })
                                          : Center(
                                              child: CustomText(
                                                  title: 'No link is added'.tr,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: 14))))
                      ]),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          color: context.watch<StngsVmC>().isDarkMode
                              ? Colors.blueGrey.shade900
                              : Colors.blueGrey.shade50,
                          height: MediaQuery.of(context).size.height * 0.2)),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.14 / 1,
                    left: 20,
                    right: 20,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9 / 1,
                        child: AppButton(
                            icon: Icons.add_box_outlined,
                            title: "Add new Links".tr,
                            onpress: () {
                              homePageProvider.onAddnewLinkPressed(1);
                              setState(() {});
                            })),
                  ),
                ])
              : const Center(child: CircularProgressIndicator()));
    });
  }

  _bottomSheet(String iconImagePath, String socialMediaName, String socialId,
      type, link, vCatg) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController linkTitleController = TextEditingController();
    TextEditingController linkDetailsController = TextEditingController();
    String selectedCategory = 'Public';
    selectedCategory = vCatg;
    linkTitleController.text = socialMediaName;
    linkDetailsController.text = link;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27.0),
            topRight: Radius.circular(27.0),
          ),
        ),
        builder: (BuildContext context) {
          return Consumer<UserSocialInfo>(
              builder: (context, UserSocialInfoValue, child) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                            title: type,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'CarosMedium')
                                      ]),
                                  const SizedBox(height: 12),
                                  // Your input fields and validation can go here
                                  Builder(builder: (context) {
                                    return BorderField2Widget(
                                      // key: const ValueKey('linkTitleKey'),
                                      height: null,
                                      hintText: 'Link Title'.tr,
                                      labelText: 'Link Title'.tr,
                                      controller: linkTitleController,
                                      errorText: 'this field is required'.tr,
                                      validationRegex: r'.+',
                                    );
                                  }),
                                  const SizedBox(height: 7),
                                  Builder(builder: (context) {
                                    return LinkInputValidation(
                                        // key: const ValueKey('userNameTitleKey'),
                                        height: null,
                                        hintText: 'Details'.tr,
                                        labelText: 'Details'.tr,
                                        validationRegex: r'.+',
                                        errorText: 'this field is required'.tr,
                                        controller: linkDetailsController);
                                  }),
                                  const SizedBox(height: 7),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                            title: 'Choose Category'.tr,
                                            textAlign: TextAlign.center,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)
                                      ]),
                                  const SizedBox(height: 5),

                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                            title:
                                                "Please choose category for this application.\nnot choosing any category will make this handle as public\nautomatically",
                                            fontSize: 11,
                                            textAlign: TextAlign.center)
                                      ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        side: const BorderSide(
                                            color: Colors.blue, width: 1.5),
                                        value:
                                            selectedCategory == 'Business'.tr,
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
                                          value:
                                              selectedCategory == 'Public'.tr,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              if (value == true) {
                                                selectedCategory = 'Public'.tr;
                                              } else {
                                                selectedCategory = '';
                                              }
                                              debugPrint(selectedCategory);
                                            });
                                          }),
                                      CustomText(title: 'Public'.tr),
                                    ],
                                  ),

                                  // const SizedBox(height: 15),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: InkWell(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          UserSocialInfoValue.updateSocialMedia(
                                              linkTitleController.text,
                                              socialId,
                                              type,
                                              linkDetailsController.text,
                                              // linkTitleController.text,
                                              selectedCategory,
                                              true, (status) {
                                            if (status) {
                                              Navigator.pop(context);
                                              Helper.showSnack(
                                                  context,
                                                  'Social media link updated successfully'
                                                      .tr);
                                              context
                                                  .watch<AuthProviders>()
                                                  .getUserData(context);
                                            } else {
                                              Helper.showSnack(
                                                  context,
                                                  'Social media link could not be updated'
                                                      .tr);
                                            }
                                          }, context);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 48,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: CustomInkWell(
                                      onTap: () {
                                        UserSocialInfoValue.deleteSocialMedia(
                                            socialId, (status) {
                                          if (status) {
                                            context
                                                .read<AuthProviders>()
                                                .getUserData(context);
                                            Navigator.pop(context);
                                            Helper.showSnack(
                                                context,
                                                'Social media link deleted successfully'
                                                    .tr);
                                          } else {
                                            Helper.showSnack(
                                                context,
                                                'Social media link could not be deleted'
                                                    .tr);
                                          }
                                        }, context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 48,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: context
                                                  .watch<StngsVmC>()
                                                  .isDarkMode
                                              ? Colors.blueGrey.shade700
                                              : Colors.white,
                                          border: Border.all(color: Colors.red),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: CustomText(
                                          title: "Delete".tr,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 9),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: CustomInkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 48,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: context
                                                  .watch<StngsVmC>()
                                                  .isDarkMode
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
        });
  }

  ////////////////////////
  String getImagePathByTitle(String title) {
    String cleanedTitle = title.toLowerCase();

    if (cleanedTitle == "phone") {
      return AssetImages.phone;
    } else if (cleanedTitle == "whatsapp") {
      return AssetImages.whatsapp;
    } else if (cleanedTitle == "wechat") {
      return AssetImages.wechat;
    } else if (cleanedTitle == "contact card") {
      return AssetImages.contact;
    } else if (cleanedTitle == "address") {
      return AssetImages.location;
    } else if (cleanedTitle == "face time") {
      return AssetImages.facetime;
    } else if (cleanedTitle == "email") {
      return AssetImages.gmail;
    } else if (cleanedTitle == "viber") {
      return AssetImages.viber;
    } else if (cleanedTitle == "messages") {
      return AssetImages.messages;
    } else if (cleanedTitle == "instagram") {
      return AssetImages.instagram;
    } else if (cleanedTitle == "linkedin") {
      return AssetImages.linkedin;
    } else if (cleanedTitle == "line") {
      return AssetImages.line;
    } else if (cleanedTitle == "reddit") {
      return AssetImages.reddit;
    } else if (cleanedTitle == "facebook") {
      return AssetImages.facebook;
    } else if (cleanedTitle == "snapchat") {
      return AssetImages.snapchat;
    } else if (cleanedTitle == "whatsapp") {
      return AssetImages.whatsapp;
    } else if (cleanedTitle == "meetme") {
      return AssetImages.meetme;
    } else if (cleanedTitle == "youtube") {
      return AssetImages.youtube;
    } else if (cleanedTitle == "x") {
      return AssetImages.twitter;
    } else if (cleanedTitle == "tiktok") {
      return AssetImages.tiktok;
    } else if (cleanedTitle == "tumblr") {
      return AssetImages.tumblr;
    } else if (cleanedTitle == "website") {
      return AssetImages.website;
    } else if (cleanedTitle == "play store") {
      return AssetImages.androidAppLink;
    } else if (cleanedTitle == "food menu") {
      return AssetImages.foodmenu;
    } else if (cleanedTitle == "google review") {
      return AssetImages.googleReview;
    } else if (cleanedTitle == "huawei app") {
      return AssetImages.huaweiAppLink;
    } else if (cleanedTitle == "ios app") {
      return AssetImages.iosAppLink;
    } else if (cleanedTitle == "tripadvisor") {
      return AssetImages.tripadvisor;
    } else if (cleanedTitle == "benefitpay") {
      return AssetImages.benefitPay;
    } else if (cleanedTitle == "paypal") {
      return AssetImages.paypal;
    } else if (cleanedTitle == "apple music") {
      return AssetImages.applemusic;
    } else if (cleanedTitle == "spotify") {
      return AssetImages.spotify;
    } else if (cleanedTitle == "soundcloud") {
      return AssetImages.soundcloud;
    } else if (cleanedTitle == "microsoft teams") {
      return AssetImages.microsoftTeams;
    } else if (cleanedTitle == "podcast") {
      return AssetImages.podcast;
    } else if (cleanedTitle == "zoom meeting") {
      return AssetImages.zoomMeeting;
    } else {
      // Default case if none of the titles match
      return "defaultImagePath";
    }
  }
}
