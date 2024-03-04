import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import '../pages/addlinks.dart';
import '../pages/profile.dart';
import '../pages/settings.dart';
import '../pages/share.dart';

class HomePageProvider extends ChangeNotifier {
  TabController? controller;
  tabFuncation(TickerProvider vsync) {
    controller = TabController(length: 3, vsync: vsync);
    controller!.addListener(tabIndexChange);
  }

  tabIndexChange() {
    notifyListeners();
  }

  tabNavigate(int index) {
    controller!.animateTo(index);
    notifyListeners();
  }

  bool isSearchBar = false;
  searchBarToggle({bool? val}) {
    isSearchBar = val!;
    notifyListeners();
  }

  int maxCount = 4;
  int initialPageIndex = 0;
  final List<Widget> bottomBarPages = [
    ProfileScreen(),
    AddLinkScreen(),
    ShareScreen(),
    SettingsScreen(),
  ];

  PageController pageController = PageController(initialPage: 0);
  final bController = NotchBottomBarController(index: 0);
  onAddnewLinkPressed(index) {
    bController.index = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  onTapChanged(index) {
    pageController.jumpToPage(index);
    notifyListeners();
  }
}
