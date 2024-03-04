import 'package:flick/provider/stngsVm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPublicButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  final IconData? icon;
  const NotificationPublicButton(
      {Key? key, required this.title, required this.onpress, this.icon});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: height * .065,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: context.watch<StngsVmC>().isDarkMode
                ? Colors.white30
                : Colors.black26,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: context.watch<StngsVmC>().isDarkMode
                  ? Colors.blueGrey.shade900
                  : Color.fromARGB(255, 139, 138, 138),
              offset: const Offset(0, 2),
              blurRadius: 2,
            ),
          ],
          gradient: context.watch<StngsVmC>().isDarkMode
              ? const LinearGradient(
                  colors: [
                    Color.fromRGBO(26, 164, 206, 1),
                    Color.fromRGBO(0, 116, 151, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [
                    Color.fromRGBO(56, 199, 243, 1),
                    Color.fromRGBO(4, 157, 204, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Icon(
                        icon!,
                        // color: Colors.blueGrey.shade100,
                        color: Colors.white,
                      ),
                    )
                  : const Text(''),
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'CarosLight'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
