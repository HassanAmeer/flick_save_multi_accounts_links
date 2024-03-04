import 'package:flutter/material.dart';

class BottomCustomMessage extends StatelessWidget {
  final String title;
  const BottomCustomMessage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 12,
          fontFamily: 'CarosLight',
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 95, 93, 93)),
    );
  }
}
