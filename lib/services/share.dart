import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiShare {
  final channel = const MethodChannel('shareChannel');
  shareOnInstagaram({required String shareText}) async {
    try {
      await channel.invokeMethod("shareOnInstagaram", {"shareText": shareText});
    } on PlatformException catch (e) {
      debugPrint(
          "💥 Failed to invoke native Android method for Share On Instagaram: ${e.message}");
    }
  }

  Future<void> shareOnGmail(
      {required String subject, required String body}) async {
    try {
      await channel
          .invokeMethod('shareOnGmail', {'subject': subject, 'body': body});
    } on PlatformException catch (e) {
      debugPrint(
          "💥 Failed to invoke native Android method for Share On Gmail: ${e.message}");
    }
  }

  Future<void> shareOnMessagingApp({required String message}) async {
    try {
      await channel.invokeMethod('shareOnMessagingApp', {'message': message});
    } on PlatformException catch (e) {
      debugPrint("💥 Failed to invoke native method: ${e.message}");
    }
  }

  Future<void> shareOnWhatsApp({required String message}) async {
    try {
      await channel.invokeMethod('shareOnWhatsApp', {'message': message});
    } on PlatformException catch (e) {
      debugPrint("💥 Failed to invoke native method: ${e.message}");
    }
  }

  Future<void> shareByChooseApp({required String shareText}) async {
    try {
      await channel.invokeMethod('shareByChooseApp', {'message': shareText});
    } on PlatformException catch (e) {
      debugPrint("💥 Failed to invoke native method: ${e.message}");
    }
  }

  Future<void> copyText({required String textForCopy}) async {
    try {
      await channel.invokeMethod('copText', {'message': textForCopy});
    } on PlatformException catch (e) {
      debugPrint("💥 Failed to invoke native method: ${e.message}");
    }
  }
}
