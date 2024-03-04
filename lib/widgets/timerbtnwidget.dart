import 'dart:async';
import 'package:flutter/material.dart';

typedef TimerButtonBuilder = Widget Function(
    BuildContext context, int seconds, bool isRunning);

enum ButtonType { custom }

const int aSec = 1;

const String _secPostFix = 's';
const String labelSplitter = " | ";

class CustomTimerButton extends StatefulWidget {
  final TimerButtonBuilder builder;
  final VoidCallback onPressed;
  final int timeOutInSeconds;
  final bool resetTimerOnPressed;

  const CustomTimerButton(
      {Key? key,
      required this.builder,
      required this.onPressed,
      required this.timeOutInSeconds,
      this.resetTimerOnPressed = true})
      : super(key: key);

  @override
  State<CustomTimerButton> createState() => _CustomTimerButtonState();
}

class _CustomTimerButtonState extends State<CustomTimerButton> {
  bool _timeUpFlag = false;
  int _timeCounter = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  void _updateTime() {
    if (_timeUpFlag) {
      return;
    }
    _timer = Timer(const Duration(seconds: aSec), () async {
      if (!mounted) return;
      _timeCounter--;
      _updateState();
      if (_timeCounter > 0) {
        _updateTime();
      } else {
        _timeUpFlag = true;
      }
    });
  }

  void _onPressed() {
    _timeUpFlag = false;
    _timeCounter = widget.timeOutInSeconds;
    _updateState();
    widget.onPressed();
    if (widget.resetTimerOnPressed) {
      _updateTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _timeUpFlag ? _onPressed : null,
      child: widget.builder(context, _timeCounter, !_timeUpFlag),
    );
  }
}
