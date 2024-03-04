import 'package:flutter/material.dart';

class SettingswithRadioButton extends StatefulWidget {
  final String imagePath;
  final String mainText;
  final String fellowText;
  final bool selected;
  final ValueChanged<bool> onChanged;

  const SettingswithRadioButton(
      {Key? key,
      required this.imagePath,
      required this.mainText,
      required this.fellowText,
      required this.selected,
      required this.onChanged})
      : super(key: key);

  @override
  _SettingswithRadioButtonState createState() =>
      _SettingswithRadioButtonState();
}

class _SettingswithRadioButtonState extends State<SettingswithRadioButton> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.09,
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
        color: _selected
            ? const Color.fromARGB(178, 255, 255, 255)
            : Color.fromARGB(255, 232, 233, 233),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Image(
              image: AssetImage(widget.imagePath),
              height: 30,
              width: 30,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mainText,
                    style: TextStyle(
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
                        fontSize: 12,
                        fontFamily: 'CarosLight',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _selected,
              onChanged: (value) {
                setState(() {
                  _selected = value;
                });
                widget.onChanged(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
