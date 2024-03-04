import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/stngsVm.dart';
import '../services/exit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentIndex = 0;

  final List<String> imageUrls = [
    'https://www.motorbiscuit.com/wp-content/uploads/2023/04/HItman-Mustang-Rear.jpg',
    'https://wallpapercave.com/wp/wp7473710.jpg',
    'https://e0.pxfuel.com/wallpapers/696/229/desktop-wallpaper-john-wick-mustang-john-wick-car.jpg',
  ];
  String checkImageUrl(String imageUrl) {
    return imageUrl;
  }

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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.wb_sunny,
                      color: context.watch<StngsVmC>().isDarkMode
                          ? Colors.grey
                          : Colors.yellow),
                  Switch(
                      value: context.watch<StngsVmC>().isDarkMode,
                      onChanged: (value) {
                        context.read<StngsVmC>().toggleTheme();
                      },
                      activeColor: Colors.grey),
                  Icon(Icons.nightlight_round,
                      color: context.watch<StngsVmC>().isDarkMode
                          ? Colors.blue
                          : Colors.grey),
                ],
              ),
            ),
            SizedBox(height: 10),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return LottieBuilder.asset(
                  context.watch<StngsVmC>().isDarkMode
                      ? 'lib/assets/animations/sslogowhite.json'
                      : 'lib/assets/animations/sslogocolor.json',
                  repeat: false,
                );
              },
            ),
            // CarouselSlider.builder(
            //   itemCount: imageUrls.length,
            //   options: CarouselOptions(
            //     height: height * 0.47,
            //     enlargeCenterPage: true,
            //     autoPlay: false,
            //     // aspectRatio: 10 / 5,
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     enableInfiniteScroll: true,
            //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
            //     viewportFraction: 1,
            //     onPageChanged: (index, reason) {
            //       setState(() {
            //         _currentIndex = index;
            //       });
            //     },
            //   ),
            //   itemBuilder: (BuildContext context, int index, int realIndex) {
            //     return Container(
            //       width: width * 0.6,
            //       margin: const EdgeInsets.symmetric(horizontal: 5.0),
            //       decoration: BoxDecoration(
            //         color: Colors.grey,
            //         borderRadius: BorderRadius.circular(15),
            //       ),
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(10),
            //         child: Image.network(
            //           checkImageUrl(
            //             imageUrls[index],
            //           ),
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //     );
            //   },
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: imageUrls.map((url) {
            //     int index = imageUrls.indexOf(url);
            //     return Container(
            //       width: 8.0,
            //       height: 8.0,
            //       margin: const EdgeInsets.symmetric(
            //           vertical: 10.0, horizontal: 2.0),
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: _currentIndex == index
            //             ? Colors.black
            //             : Colors.grey.withOpacity(0.6),
            //       ),
            //     );
            //   }).toList(),
            // ),

            // SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            // Container(
            //   child: Center(
            //     child: Text(
            //       'Get Rid of Paper cards'.tr,
            //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            //     ),
            //   ),
            // ),
            // Container(
            //   child: Center(
            //     child: Text("Custom Messages will be shown here".tr),
            //   ),
            // ),

            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Get.updateLocale(const Locale('en', 'US'));
                              Provider.of<StngsVmC>(context, listen: false)
                                  .toggleLangVmF(true);
                            },
                            child: Text('English'.tr),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              await Get.updateLocale(const Locale('ar', 'SA'));
                              Provider.of<StngsVmC>(context, listen: false)
                                  .toggleLangVmF(true);
                            },
                            child: Text('Arabic'.tr),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AppButton(
                        title: "Create an Account".tr,
                        onpress: () {
                          Navigator.pushNamed(context, "/EmailSignUpScreen");
                        },
                      ),
                      const SizedBox(height: 10),
                      AppWhiteButton(
                        title: "Already have an Account? Sign in".tr,
                        onpress: () {
                          Navigator.pushNamed(context, "/LoginScreen");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
