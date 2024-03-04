import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/stngsVm.dart';

class ProfileThreeText extends StatelessWidget {
  ProfileThreeText(
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
          fontSize: context.watch<StngsVmC>().isLanIsEngMode ? fontSize : 12,
          color: context.watch<StngsVmC>().isDarkMode
              ? Colors.blueGrey.shade200
              : Colors.blueGrey.shade900,
          fontWeight: fontWeight,
          decoration: decoration,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          fontFamily: context.watch<StngsVmC>().isLanIsEngMode
              ? 'CarosMedium'
              : "NotoKufi",
          height: height),
    );
  }
}
