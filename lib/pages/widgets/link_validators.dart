import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/stngsVm.dart';

class LinkInputValidation extends StatelessWidget {
  final String hintText;
  final String labelText;
  final String validationRegex;
  final TextEditingController controller;
  final String errorText;
  final double? height;

  const LinkInputValidation({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.validationRegex,
    required this.controller,
    required this.errorText,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        controller: controller,
        cursorColor: const Color.fromRGBO(4, 157, 204, 1),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 15),
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
                      : Colors.black),
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
            hintText: hintText,
            hintStyle: TextStyle(
                color: context.watch<StngsVmC>().isDarkMode
                    ? Colors.blueGrey.shade400
                    : Colors.blueGrey.shade800),
            labelText: labelText),
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
