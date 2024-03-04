import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/stngsVm.dart';
import 'package:get/get.dart';

class Logout {
  exit(context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('Are you sure you want to Exit?'.tr,
              style: TextStyle(
                  fontSize: 18,
                  color: context.watch<StngsVmC>().isDarkMode
                      ? Colors.white
                      : Colors.black)),
          actions: <Widget>[
            TextButton(
              child: Text('No'.tr,
                  style: TextStyle(
                      color: context.watch<StngsVmC>().isDarkMode
                          ? Colors.grey.shade200
                          : Colors.grey.withOpacity(0.8))),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(
                'Exit'.tr,
                style: TextStyle(
                    color: context.watch<StngsVmC>().isDarkMode
                        ? Colors.yellowAccent
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
