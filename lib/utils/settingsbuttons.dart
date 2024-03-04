import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SettingButtons extends StatefulWidget {
  final String imagePath;
  final String mainText;
  final String fellowText;
  final IconData icon;
  final VoidCallback onpress;

   const SettingButtons({
    Key? key,
    required this.imagePath,
    required this.mainText,
    required this.fellowText,
    required this.icon,
    required this.onpress,
  }) : super(key: key);

  @override
  State<SettingButtons> createState() => _SettingButtonsState();
}

class _SettingButtonsState extends State<SettingButtons> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
  onTap: widget.onpress,
  child: Stack(
    children: [
      Container(
        height: height * 0.08,
        width: width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow:  [
            BoxShadow(
              color: Color.fromARGB(255, 114, 113, 113),
              offset: Offset(0, 3),
              blurRadius: 5,
            ),
          ],
          color:  Color.fromARGB(255, 232, 233, 233),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image(
                image: AssetImage(widget.imagePath),
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mainText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'CarosMedium',
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.fellowText,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: Get.locale?.languageCode == 'ar' ? 8.5 : 10,
                       // fontSize: 8.5,
                        fontFamily: 'CarosMedium',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(widget.icon),
            ],
          ),
        ),
      ),
      Positioned.fill(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onpress,
              splashColor: const Color.fromRGBO(4, 157, 204, 0.322),
            ),
          ),
        ),
      ),
    ],
  ),
);
  }
}