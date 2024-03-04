import 'dart:ui';
import 'package:flick/provider/homePageProvider.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:flick/pages/profile.dart';
import 'package:flick/pages/addlinks.dart';
import 'package:flick/pages/share.dart';
import 'package:flick/pages/settings.dart';
import 'package:get/get.dart';

import 'services/exit.dart';
import 'services/notify.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // late _pageController = PageController();
  PageController? _pageController;
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 4;
  int initialPageIndex = 0;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const ProfileScreen(),
    const AddLinkScreen(),
    ShareScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();

    if (Provider.of<HomePageProvider>(context, listen: false)
            .initialPageIndex >=
        Provider.of<HomePageProvider>(context, listen: false)
            .bottomBarPages
            .length) {
      Provider.of<HomePageProvider>(context, listen: false).initialPageIndex =
          0; // Set the initial page index to 0 if it's out of range
    }
    Provider.of<HomePageProvider>(context, listen: false).pageController =
        PageController(initialPage: 0);

    Notify().requestNotifyPermissionF();
    Notify().getTokenF(context);
    Notify().initListenMsgsF(context);
    Notify().onClickFcmNotifi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
        builder: (context, homePageProvider, child) {
      return WillPopScope(
        onWillPop: () async {
          await Logout().exit(context);
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              PageView(
                controller: homePageProvider.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  homePageProvider.bottomBarPages.length,
                  (index) => homePageProvider.bottomBarPages[index],
                ),
              ),
              if (homePageProvider.bottomBarPages.length <=
                  homePageProvider.maxCount)
                Positioned(
                  bottom: 2,
                  child: AnimatedNotchBottomBar(
                    /// Provide NotchBottomBarController
                    ///
                    notchBottomBarController: homePageProvider.bController,
                    color: const Color.fromARGB(255, 226, 224, 224),
                    showLabel: true,
                    notchColor: const Color.fromRGBO(22, 132, 212, 1),

                    /// restart app if you change removeMargins
                    removeMargins: false,
                    bottomBarWidth: 500,
                    durationInMilliSeconds: 300,
                    itemLabelStyle:
                        TextStyle(fontSize: 9, color: Colors.blueGrey.shade800),

                    bottomBarItems: [
                      BottomBarItem(
                        inActiveItem: const Icon(
                          Icons.person_2_outlined,
                          size: 30,
                          color: Color.fromRGBO(25, 95, 150, 1),
                        ),
                        activeItem: const Icon(
                          Icons.person_2_outlined,
                          color: Colors.white,
                        ),
                        itemLabel: 'Profile'.tr,
                      ),
                      BottomBarItem(
                        inActiveItem: const Icon(
                          Icons.apps_outlined,
                          size: 30,
                          color: Color.fromRGBO(25, 95, 150, 1),
                        ),
                        activeItem: const Icon(
                          Icons.apps_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                        itemLabel: 'Add Links'.tr,
                      ),
                      BottomBarItem(
                        inActiveItem: const Icon(
                          Icons.qr_code,
                          color: Color.fromRGBO(25, 95, 150, 1),
                        ),
                        activeItem: const Icon(
                          Icons.qr_code,
                          color: Colors.white,
                        ),
                        itemLabel: 'Share'.tr,
                      ),
                      BottomBarItem(
                        inActiveItem: const Icon(
                          Icons.settings,
                          color: Color.fromRGBO(25, 95, 150, 1),
                        ),
                        activeItem: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        itemLabel: 'Settings'.tr,
                      ),
                    ],
                    onTap: (index) {
                      homePageProvider.pageController.jumpToPage(index);
                    },
                    kBottomRadius: 20,
                    kIconSize: 20,
                  ),
                ),
            ],
          ),
          extendBody: true,
        ),
      );
    });
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreenAccent,
        child: const Center(child: Text('Page 1')));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreenAccent,
        child: const Center(child: Text('Page 2')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreenAccent,
        child: const Center(child: Text('Page 3')));
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightGreenAccent,
        child: const Center(child: Text('Page 4')));
  }
}
