import 'package:flick/provider/stngsVm.dart';
import 'package:flick/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BorderFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final FormFieldValidator<String>? validator; // Add validator parameter

  const BorderFieldWidget({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.validator, // Initialize validator parameter
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      //padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        cursorColor: const Color.fromRGBO(4, 157, 204, 1),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 5, left: 15, right: 10),
          enabledBorder: InputBorders.enabled,
          errorBorder: InputBorders.error,
          focusedErrorBorder: InputBorders.error,
          focusedBorder: InputBorders.focused,
          border: const OutlineInputBorder(),

          // focusedBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(
          //     color: Color.fromRGBO(4, 157, 204, 1),
          //   ), // Border color when focused
          //   borderRadius: BorderRadius.circular(10),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //       color: context.watch<StngsVmC>().isDarkMode
          //           ? Colors.blueGrey
          //           : Colors.black),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          floatingLabelStyle: MaterialStateTextStyle.resolveWith(
            (Set<MaterialState> states) {
              final Color color = states.contains(MaterialState.error)
                  ? Theme.of(context).colorScheme.error
                  : const Color.fromRGBO(4, 157, 204, 1);
              return TextStyle(color: color, letterSpacing: 1.3);
            },
          ),
          labelText: labelText!,
          hintText: hintText!,
          // suffixIcon: IconButton(
          //   icon: Icon(Icons.question_mark),
          //   onPressed: () {},
          // ),
          hintStyle: TextStyle(
              color: context.watch<StngsVmC>().isDarkMode
                  ? Color.fromARGB(131, 246, 246, 246)
                  : Colors.blueGrey.shade400),
        ),
        validator: validator, // Set the validator function
      ),
    );
  }
}
