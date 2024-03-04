import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/stngsVm.dart';

class AppWhiteButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  const AppWhiteButton({Key? key, required this.title, required this.onpress});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onpress,
      child: Container(
        height: height * .065,
        width: width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 61, 61, 61),
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
            color: Colors.white),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'CarosLight'),
        )),
      ),
    );
  }
}

class AppDeActivateButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  const AppDeActivateButton(
      {Key? key, required this.title, required this.onpress});

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
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 61, 61, 61),
                offset: Offset(0, 2),
                blurRadius: 6,
              ),
            ],
            color: context.watch<StngsVmC>().isDarkMode
                ? Colors.blueGrey.shade200
                : Colors.white),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
              color: Color.fromARGB(255, 194, 8, 8),
              fontSize: 15,
              fontFamily: 'CarosMedium'),
        )),
      ),
    );
  }
}
