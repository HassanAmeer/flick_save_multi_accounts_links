import 'dart:developer' as dev;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flick/navbar.dart';
import 'package:flick/pages/contactscreen.dart';
import 'package:flick/pages/editprofile.dart';
import 'package:flick/pages/faq.dart';
import 'package:flick/pages/login/login.dart';
import 'package:flick/pages/login/loginwithphone.dart';
import 'package:flick/pages/recoverPassword/recoverbyemail.dart';
import 'package:flick/pages/recoverPassword/recoverybynumber.dart';
import 'package:flick/pages/recoverPassword/resetpasswordscreen.dart';
import 'package:flick/pages/recoverPassword/resetverificationcodescreen.dart';
import 'package:flick/pages/login/verificationCodeScreen.dart';
import 'package:flick/pages/signup/adduserdetails.dart';
import 'package:flick/pages/signup/emailsignup.dart';
import 'package:flick/pages/signup/mobilesignupverification.dart';
import 'package:flick/pages/signup/signupwithmobile.dart';
import 'package:flick/pages/splashscreen.dart';
import 'package:flick/pages/welcomescreen.dart';
import 'package:flick/provider/auth.dart';
import 'package:flick/provider/homePageProvider.dart';
import 'package:flick/provider/stngsVm.dart';
import 'package:flick/provider/user_social_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'di_container.dart' as di;
import 'package:get/get.dart';

import 'languages.dart';
import 'provider/categoryOptionsVm.dart';
import 'provider/directtoggleVm.dart';
import 'utils/colors.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("👉 BG Notify: $message ");
}

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//////////// local notification initilized start
  bool? initialized = await notificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/bell"),
          iOS: DarwinInitializationSettings(
              requestAlertPermission: true,
              requestBadgePermission: true,
              requestCriticalPermission: true,
              requestSoundPermission: true)),
      onDidReceiveNotificationResponse: (response) {
    // on tap open setting page
    // dev.log("👉 local did recieve: ${response.payload}");
  });
//////////// local notification initilized end

  await di.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => di.sl<AuthProviders>()),
    ChangeNotifierProvider(create: (context) => di.sl<UserSocialInfo>()),
    ChangeNotifierProvider(create: (context) => HomePageProvider()),
    ChangeNotifierProvider(create: (context) => CategoryChooseModeVmC()),
    ChangeNotifierProvider<StngsVmC>(create: (_) => StngsVmC()),
    ChangeNotifierProvider<ToggleDirectModeVmC>(
        create: (_) => ToggleDirectModeVmC())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final providerval = Provider.of<StngsVmC>(context, listen: false);
    providerval.getLangModeVmF();
    providerval.checkThemeF();
    Get.updateLocale(providerval.isLanIsEngMode == true
        ? const Locale('en', 'US')
        : const Locale('ar', 'SA'));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StngsVmC>(builder: (context, stngsVmC, child) {
      return GetMaterialApp(
        title: 'Flicks',
        translations: Languages(),
        locale: stngsVmC.isLanIsEngMode == true
            ? const Locale('en', 'US')
            : const Locale('ar', 'SA'),
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        // theme: stngsVmC.themeData,
        themeMode: stngsVmC.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
            primarySwatch: MaterialColors.blue,
            scaffoldBackgroundColor: MaterialColors.blue.shade50,
            iconTheme: const IconThemeData(color: MaterialColors.blue),
            progressIndicatorTheme: const ProgressIndicatorThemeData(
                color: MaterialColors.blue, linearTrackColor: Colors.black),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(color: Colors.blueGrey.shade800),
                iconTheme: const IconThemeData(color: Colors.black)),
            textTheme: const TextTheme(
                // bodySmall: const TextStyle(color: Colors.white),
                // bodyMedium: const TextStyle(color: Colors.white),
                // bodyLarge: const TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.black),
                bodyText2: TextStyle(color: Colors.black)),
            inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.blueGrey.shade100,
                hintStyle: const TextStyle(color: Colors.white)),
            listTileTheme: ListTileThemeData(
                tileColor: Colors.blueGrey.shade50,
                iconColor: Colors.blueGrey.shade800)),
        darkTheme: ThemeData(
            // fontFamily: 'CarosMedium',
            // colorScheme: ColorScheme.fromSeed(
            //     seedColor: const Color.fromRGBO(4, 157, 204, 1)),
            progressIndicatorTheme: ProgressIndicatorThemeData(
                color: Colors.blueGrey.shade700,
                linearTrackColor: Colors.black),
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(
                        TextStyle(color: Colors.blueGrey.shade200)))),
            iconTheme:
                const IconThemeData(color: MaterialColors.lightBlueAccent),
            bottomSheetTheme:
                BottomSheetThemeData(backgroundColor: Colors.blueGrey.shade800),
            primarySwatch: MaterialColors.blue,
            scaffoldBackgroundColor: Colors.blueGrey.shade900,
            dialogTheme: DialogTheme(backgroundColor: Colors.blueGrey.shade800),
            textTheme: const TextTheme(
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white)),
            inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.blueGrey.shade800,
                labelStyle: const TextStyle(color: Colors.blueGrey),
                prefixIconColor: Colors.blueGrey.shade400,
                hintStyle: const TextStyle(color: Colors.blueGrey)),
            dividerColor: Colors.black,
            listTileTheme: ListTileThemeData(
                // titleTextStyle: TextStyle(color: Colors.white),
                // subtitleTextStyle: TextStyle(color: Colors.blueGrey.shade200),
                tileColor: Colors.blueGrey.shade700,
                iconColor: Colors.blueGrey.shade300),
            appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.blueGrey.shade800,
                titleTextStyle: const TextStyle(color: Colors.white))),
        // home: const WelcomeScreen(),
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/WelcomeScreen": (context) => const WelcomeScreen(),
          "/LoginScreen": (context) => const LoginScreen(),
          "/LoginwithPhoneScreen": (context) => const LoginwithPhoneScreen(),
          "/VerificationCodeScreen": (context) =>
              const VerificationCodeScreen(),
          "/NavBar": (context) => const NavBar(),
          "/RecoveryByEmail": (context) => const RecoveryByEmail(),
          "/RecoveryByMobileNumber": (context) => const RecoverbyMobileNumber(),
          "/ResetVerificationCodeScreen": (context) =>
              const ResetVerificationCodeScreen(),
          "/ResetPasswordScreen": (context) => const ResetPasswordScreen(),
          "/EmailSignUpScreen": (context) => const EmailSignUpScreen(),
          "/SignupwithMobileScreen": (context) =>
              const SignupwithMobileScreen(),
          "/MobileSignUpVerificationScreen": (context) =>
              const MobileSignUpVerificationScreen(),
          "/AddUserFirstDetails": (context) => const AddUserFirstDetails(),
          "/EditProfileScreen": (context) => const EditProfileScreen(),
          "/FAQ": (context) => const FaqScreen(),
          "/ContactScreen": (contextt) => ContactScreen(),
        },
      );
    });
  }
}


////////////////////////////////////
// <a href="https://www.instagram.com/?url=https://www.drdrop.co/" target="_blank" rel="noopener">
//     Share on instagram
// </a>
