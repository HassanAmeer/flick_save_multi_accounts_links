import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/customAppBar.dart';
import 'package:flick/utils/faqlistwidget.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../provider/stngsVm.dart';
import '../services/exit.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<StngsVmC>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'FAQ'.tr),
      ),
      body: FaqListWidget(),
    );
  }
}
