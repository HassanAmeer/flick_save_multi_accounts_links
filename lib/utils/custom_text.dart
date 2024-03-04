import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/stngsVm.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {this.title,
      this.color = Colors.black,
      this.fontSize = 14,
      this.fontWeight,
      this.fontStyle,
      this.textAlign,
      this.decoration,
      this.maxLines,
      this.fontFamily,
      this.height,
      this.overflow,
      this.letterSpacing,
      Key? key})
      : super(key: key);
  String? title;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  TextAlign? textAlign;
  TextDecoration? decoration;
  int? maxLines;
  String? fontFamily;
  double? height;
  double? letterSpacing;
  TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
          fontSize: fontSize,
          color: context.watch<StngsVmC>().isDarkMode
              ? Colors.blueGrey.shade200
              : Colors.blueGrey.shade900,
          fontWeight: fontWeight,
          decoration: decoration,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          fontFamily: fontFamily ?? "CarosLight",
          height: height),
    );
  }
}
