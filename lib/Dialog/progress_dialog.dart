import 'package:flutter/material.dart';

class ProgressDialog {
  // Paramiteres
  final BuildContext context;
  bool isDismissible = true;

  // Local variables
  late BuildContext _dismissingContext;
  late bool _isDismissible;

  // Constructor
  ProgressDialog(this.context, {this.isDismissible = false});

  // Show progress dialog
  Future<bool> show() async {
    try {
      showDialog<dynamic>(
        context: context,
        barrierDismissible: isDismissible,
        builder: (BuildContext context) {
          _dismissingContext = context;
          return WillPopScope(
            onWillPop: () async => isDismissible,
            child: Dialog(
                backgroundColor: Colors.white,
                insetAnimationCurve: Curves.easeInOut,
                insetAnimationDuration: const Duration(milliseconds: 100),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.8))),
                child: _dialog('Processing')),
          );
        },
      );
      // Delaying the function for 200 milliseconds
      // [Default transitionDuration of DialogRoute]
      await Future.delayed(const Duration(milliseconds: 200));
      debugPrint('show progress dialog() -> sucess');
      return true;
    } catch (err) {
      debugPrint('Exception while showing the progress dialog');
      debugPrint(err.toString());
      return false;
    }
  }

  // Build progress dialog
  Widget _dialog(String message) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Row body
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(width: 8.0),
              // Show progress indicator
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.left,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  // Hide progress dialog
  Future<bool> hide() async {
    try {
      Navigator.of(_dismissingContext).pop();
      debugPrint('ProgressDialog dismissed');
      return Future.value(true);
    } catch (err, stackTrace) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(stackTrace.toString());
      return Future.value(false);
    }
  }
}
