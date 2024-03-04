import 'package:flick/provider/stngsVm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BorderField2Widget extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final VoidCallback? onSuffixIconTap;
  final bool showSuffixIcon;
  final String validationRegex;
  final String errorText;
  final double? height;

  const BorderField2Widget({
    Key? key,
    this.controller,
    required this.labelText,
    required this.hintText,
    required this.validationRegex,
    required this.errorText,
    this.height = 50,
    this.onSuffixIconTap,
    this.showSuffixIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        cursorColor: const Color.fromRGBO(4, 157, 204, 1),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            top: 5,
            left: 15,
            right: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(4, 157, 204, 1),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: context.watch<StngsVmC>().isDarkMode
                    ? Colors.blueGrey
                    : Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.watch<StngsVmC>().isDarkMode
                  ? Colors.blueGrey
                  : Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: context.watch<StngsVmC>().isDarkMode
                    ? Colors.red.shade400
                    : Colors.red.shade700),
            borderRadius: BorderRadius.circular(10),
          ),
          floatingLabelStyle: MaterialStateTextStyle.resolveWith(
            (Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : const Color.fromRGBO(4, 157, 204, 1);
              return TextStyle(color: color, letterSpacing: 1.3);
            },
          ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            color: context.watch<StngsVmC>().isDarkMode
                ? Color.fromARGB(131, 246, 246, 246)
                : Colors.blueGrey.shade400,
          ),
          suffixIcon: showSuffixIcon
              ? IconButton(
                  icon: Icon(
                    CupertinoIcons.question,
                    color: context.watch<StngsVmC>().isDarkMode
                        ? Colors.white
                        : Colors.blueGrey,
                  ),
                  onPressed: onSuffixIconTap,
                )
              : null,
        ),
        validator: (value) {
          final regex = RegExp(validationRegex);
          if (!regex.hasMatch(value!)) {
            return errorText;
          }
          return null;
        },
      ),
    );
  }
}
