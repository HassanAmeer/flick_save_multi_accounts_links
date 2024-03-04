import 'package:flutter/material.dart';

class testing extends StatefulWidget {
  const testing({super.key});

  @override
  State<testing> createState() => _testingState();
}

class _testingState extends State<testing> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height == 149.9 ? 140 : null, // Adjust the height based on your condition
        width: 10,
        color: Colors.green,
      )
    );
  }
}
