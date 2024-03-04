import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/customAppBar.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import 'package:flick/utils/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(title: 'Edit Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'lib/photos/images/user.jpg',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            // Handle edit button pressed
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorBorder: InputBorders.error,
                      focusedErrorBorder: InputBorders.error,
                      focusedBorder: InputBorders.focused,
                      border: const OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: "Enter Name",
                      prefixIcon: Icon(Icons.email_outlined),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Color.fromRGBO(4, 157, 204, 1);
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorBorder: InputBorders.error,
                      focusedErrorBorder: InputBorders.error,
                      focusedBorder: InputBorders.focused,
                      border: const OutlineInputBorder(),
                      labelText: 'Profession',
                      hintText: "Enter your Profession",
                      prefixIcon: Icon(Icons.email_outlined),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Color.fromRGBO(4, 157, 204, 1);
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorBorder: InputBorders.error,
                      focusedErrorBorder: InputBorders.error,
                      focusedBorder: InputBorders.focused,
                      border: const OutlineInputBorder(),
                      labelText: 'Organization',
                      hintText: "Enter Organzation Name",
                      prefixIcon: Icon(Icons.email_outlined),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : Color.fromRGBO(4, 157, 204, 1);
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppButton(title: "Update", onpress: () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  AppDeActivateButton(
                      title: "Cancel",
                      onpress: () {
                        Navigator.pushReplacementNamed(context, "/NavBar");
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
