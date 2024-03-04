import 'package:flick/utils/appButtons.dart';
import 'package:flutter/material.dart';
import 'package:flick/utils/constants.dart';

class AddFlickCode extends StatelessWidget {
  const AddFlickCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  child: const Text(
                    "Add your Flick Customer Code",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorBorder: InputBorders.error,
                  focusedErrorBorder: InputBorders.error,
                  focusedBorder: InputBorders.focused,
                  border: const OutlineInputBorder(),
                  labelText: 'Flick Code',
                  hintText: "FLXXXXX1234",
                  prefixIcon: Icon(Icons.email_outlined),
                  floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                    (Set<MaterialState> states) {
                      final Color color = states.contains(MaterialState.error)
                          ? Theme.of(context).colorScheme.error
                          : Color.fromRGBO(4, 157, 204, 1);
                      return TextStyle(color: color, letterSpacing: 1.3);
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AppButton(
                title: "Verify",
                onpress: () {
                  showProgressDialogAndNavigate(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showProgressDialogAndNavigate(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading...'),
            ],
          ),
        ),
      );
    },
  );

  // Simulate a delay of 1 second
  Future.delayed(Duration(seconds: 1), () {
    Navigator.pop(context); // Dismiss the progress dialog
    // Navigator.pushNamed(context, "/NavBar");
  });
}
