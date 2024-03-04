import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "../provider/categoryOptionsVm.dart";
import "package:provider/provider.dart";
import "package:flutter/material.dart";
import "../pages/chooseonnotify.dart";
import "../main.dart";
import "dart:math";

class Notify {
  FirebaseMessaging msg = FirebaseMessaging.instance;
  void requestNotifyPermissionF() async {
    NotificationSettings stngs = await msg.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (stngs.authorizationStatus == AuthorizationStatus.authorized) {
      // have permission
    } else if (stngs.authorizationStatus == AuthorizationStatus.provisional) {
      // request permission => provisional means provide
    } else {
      // have no notify permmssion
    }
  }

  /////////////////////////
  Future getTokenF(context) async {
    String? token = await msg.getToken();
    debugPrint("👉 token: $token");
    await Provider.of<CategoryChooseModeVmC>(context, listen: false)
        .addTokenVmF(token);
    return token;
  }

  void isTokenRefreshF() {
    msg.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  /////////////////////////
  initListenMsgsF(context) {
    FirebaseMessaging.onMessage.listen((event) {
      debugPrint("👉 IN APP Notify: $event ");
      showNotification(event.notification!.title.toString(),
          event.notification!.body.toString(), context);

      // Helper.showSnack(context, "$event");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ChooseCategoryOnNotifyPage()));
    });
  }

  onClickFcmNotifi(context) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      debugPrint("👉 On Click Notifiaction : $event ");
      // Helper.showSnack(context, "$event");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ChooseCategoryOnNotifyPage()));
    });
  }

  //////////////////////////
  void showNotification(title, msg, context) async {
    String rdmn = Random.secure().nextInt(10).toString();
    NotificationDetails notiDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          rdmn.toString(),
          "name",
          priority: Priority.max,
          importance: Importance.max,
          playSound: true,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ));

    await notificationsPlugin.show(
        int.parse(rdmn), "$title", "msg", notiDetails);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ChooseCategoryOnNotifyPage()));
  }
}
