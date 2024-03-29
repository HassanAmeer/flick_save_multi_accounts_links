import 'dart:developer';

import 'package:flutter/material.dart';

import '../animation/slideleft_toright.dart';
import '../animation/slideright_toleft.dart';


class Helper {
  static setHeight(BuildContext context, {height = 1}) {
    return MediaQuery.of(context).size.height * height;
  }

  static setWidth(BuildContext context, {width = 1}) {
    return MediaQuery.of(context).size.width * width;
  }

  static toScreen(context, screen) {
    log('page name: $screen');
    Navigator.push(context, SlideRightToLeft(page: screen));
  }

  static toScreenLeftToRight(context, screen) {
    log('page name: $screen');
    Navigator.push(context, SlideLeftToRight(page: screen));
  }

  static toReplacementScreenSlideRightToLeft(context, screen) {
    log('page name: $screen');
    Navigator.pushReplacement(context, SlideRightToLeft(page: screen));
  }

  static toReplacementScreenSlideLeftToRight(context, screen) {
    log('page name: $screen');
    Navigator.pushReplacement(context, SlideLeftToRight(page: screen));
  }

  static toRemoveUntiScreen(context, screen) {
    log('page name and remove all: $screen');
    Navigator.pushAndRemoveUntil(
        context, SlideRightToLeft(page: screen), (route) => false);
  }

  static onWillPop(context, screen) {
    log('page name and remove all: $screen');
    Navigator.pushAndRemoveUntil(
        context, SlideRightToLeft(page: screen), (route) => false);
  }

  static showSnack(context, message, {color = Colors.black, duration = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message, style: TextStyle(fontSize: 14)),
        backgroundColor: color,
        duration: Duration(seconds: duration)));
  }

  static circulProggress(context) {
    const Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black)));
  }

  static showLog(message) {
    log("APP SAYS: $message");
  }

  static boxDecoration(Color color, double radius) {
    BoxDecoration(
        color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
