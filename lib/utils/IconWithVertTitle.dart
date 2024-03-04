import 'package:flutter/material.dart';
import 'custom_text.dart';

class IconWithVertTitle extends StatelessWidget {
  final String imgSrc;
  final String title;
  final VoidCallback? onPressed;
  double? width;
  double? height;
  // final Color containerbgColor;

  IconWithVertTitle(
      {super.key,
      required this.imgSrc,
      required this.title,
      // this.containerbgColor = const Color(0xffe3e8ec),
      this.onPressed,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              height: 47,
              width: 47,
              decoration: BoxDecoration(
                // color: containerbgColor,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            Positioned(
              left: -13,
              right: -13,
              child: Image.asset(
                imgSrc,
                width: width,
                height: height,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        CustomText(
          title: title,
          fontSize: 12,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          fontWeight: FontWeight.bold,
        )
      ],
    );
  }
}
