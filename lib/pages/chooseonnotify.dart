import 'package:flick/provider/stngsVm.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flick/utils/notificationpublicbutton.dart';

import '../provider/categoryOptionsVm.dart';

class ChooseCategoryOnNotifyPage extends StatefulWidget {
  const ChooseCategoryOnNotifyPage({super.key});

  @override
  State<ChooseCategoryOnNotifyPage> createState() =>
      _ChooseCategoryOnNotifyPageState();
}

class _ChooseCategoryOnNotifyPageState
    extends State<ChooseCategoryOnNotifyPage> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!isSelected) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Please Choose Any One'),
              action: SnackBarAction(label: 'Undo', onPressed: () {})));
        }
        Future.value(false);
      },
      child: Consumer<StngsVmC>(builder: (context, stngVmValue, child) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 50, right: 50, left: 50, bottom: 20),
                  child: Lottie.asset(
                    'lib/assets/animations/animation.json',
                  ),
                ),
              ),
              const FractionallySizedBox(
                widthFactor: 0.9, // Adjust this value as needed
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Flick device has been tapped",
                      style: TextStyle(fontSize: 22, fontFamily: 'CarosMedium'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const FractionallySizedBox(
                widthFactor: 0.85, // Adjust this value as needed
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Kindly choose a category you want to share. \n Click cancel to ignore",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'CarosLight',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 122, 121, 121),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: NotificationPublicButton(
                          title: 'Public'.tr,
                          onpress: () async {
                            await Provider.of<CategoryChooseModeVmC>(context,
                                    listen: false)
                                .chooseOptionCatgVmF("public", context);
                            setState(() {
                              isSelected = true;
                            });
                            Navigator.pop(context);
                          }),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: NotificationPublicButton(
                          title: 'Business'.tr,
                          onpress: () async {
                            await Provider.of<CategoryChooseModeVmC>(context,
                                    listen: false)
                                .chooseOptionCatgVmF("business", context);
                            setState(() {
                              isSelected = true;
                            });
                            Navigator.pop(context);
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: NotificationPublicButton(
                    title: 'All'.tr,
                    onpress: () async {
                      await Provider.of<CategoryChooseModeVmC>(context,
                              listen: false)
                          .chooseOptionCatgVmF("all", context);
                      setState(() {
                        isSelected = true;
                      });
                      Navigator.pop(context);
                    }),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppDeActivateButton(
                    title: 'Cancel'.tr,
                    onpress: () async {
                      await Provider.of<CategoryChooseModeVmC>(context,
                              listen: false)
                          .chooseOptionCatgVmF("canceled", context);
                      setState(() {
                        isSelected = true;
                      });
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
