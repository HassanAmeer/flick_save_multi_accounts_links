import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../provider/auth.dart';
import 'package:provider/provider.dart';

import '../provider/stngsVm.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _checkCurrentUser() async {
    AuthProviders _authProvider =
        Provider.of<AuthProviders>(context, listen: false);
    User? user = await _authProvider.getCurrentUser();

    // Delay the navigation for a few seconds to show the splash screen
    await Future.delayed(const Duration(seconds: 5));
    debugPrint('checking user:$user');

    if (user != null) {
      // User is signed in, navigate to the home screen
      Navigator.pushReplacementNamed(context, "/NavBar");
    } else {
      // No user is signed in, navigate to the welcome screen
      Navigator.pushReplacementNamed(context, "/WelcomeScreen");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SizedBox(
    //     height: double.infinity,
    //     width: double.infinity,
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 30.0),
    //       child: Center(
    //         child: Image.asset(
    //           context.watch<StngsVmC>().isDarkMode
    //               ? 'lib/photos/images/appinsidelogowhite.png'
    //               : 'lib/photos/images/appinsidelogoblue.png',
    //           width: double.infinity,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return LottieBuilder.asset(
              context.watch<StngsVmC>().isDarkMode
                  ? 'lib/assets/animations/sslogowhite.json'
                  : 'lib/assets/animations/sslogocolor.json',
              width: constraints.maxWidth * 0.8,
              height: constraints.maxHeight * 0.3,
              repeat: false,
            );
          },
        ),
      ),
    );
  }
}
