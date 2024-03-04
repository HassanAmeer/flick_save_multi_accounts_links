import 'package:flutter/material.dart';

class NFCActivationModal extends StatefulWidget {
  @override
  _NFCActivationModalState createState() => _NFCActivationModalState();
}

class _NFCActivationModalState extends State<NFCActivationModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Define the animation curve
    final curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Define the animation values
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0.0, _animation.value * MediaQuery.of(context).size.height),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        color: Colors.white,
        child: Center(
          child: Text(
            'NFC Activation',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Builder(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('NFC Activation Demo'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return NFCActivationModal();
                  },
                );
              },
              child: Text('Activate NFC'),
            ),
          ),
        );
      },
    ),
  ));
}