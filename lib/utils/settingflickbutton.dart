import 'package:flutter/material.dart';

class SettingsFlickButton extends StatefulWidget {
  final String imagePath;
  final String mainText;
  final String fellowText;
  final IconData icon;
  final VoidCallback onpress;

  const SettingsFlickButton({
    Key? key,
    required this.imagePath,
    required this.mainText,
    required this.fellowText,
    required this.icon,
    required this.onpress,
  }) : super(key: key);

  @override
  State<SettingsFlickButton> createState() => _SettingsFlickButtonState();
}

class _SettingsFlickButtonState extends State<SettingsFlickButton> {
  Color containerColor = const Color.fromARGB(255, 3, 112, 145);
  Color previousColor = const Color.fromARGB(255, 3, 112, 145);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: widget.onpress,
      onTapDown: (details) {
        setState(() {
          containerColor = const Color.fromARGB(178, 255, 255, 255);
        });
      },
      onTapUp: (details) {
        setState(() {
          containerColor = previousColor;
        });
      },
      child: Container(
        height: height * 0.08,
        width: width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 114, 113, 113),
              offset: Offset(0, 3),
              blurRadius: 5,
            ),
          ],
          color: containerColor,
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
                      color: Colors.white,
                      fontFamily: 'CarosMedium',
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.fellowText,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'CarosMedium',
                        color: Color.fromARGB(179, 229, 228, 228),
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
    );
  }
}
