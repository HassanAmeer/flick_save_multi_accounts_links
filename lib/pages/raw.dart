import 'dart:convert';
import 'dart:io';

import 'package:flick/provider/stngsVm.dart';
import 'package:flick/utils/helper.dart';
import 'package:flick/utils/theme_prefrences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../provider/auth.dart';
import '../utils/app_constant.dart';
import '../utils/customAppBar.dart';
import '../utils/custom_inkwell_btn.dart';
import '../utils/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  final String? profileImageLink;
  const EditProfile({super.key, this.profileImageLink = ""});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _professionController = TextEditingController();
  final _organizationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Provider.of<StngsVmC>(context, listen: false).getProfilePathVmF();
    getProfileDataF();
  }

  getProfileDataF() async {
    final vmProvider = Provider.of<AuthProviders>(context, listen: false);
    await vmProvider.getUserData(context);
    _nameController.text = vmProvider.getData!.name.toString();
    _emailController.text = vmProvider.getData!.email.toString();
    _phoneController.text = vmProvider.getData!.phone.toString();
    _professionController.text = vmProvider.getData!.profession.toString();
    _organizationController.text = vmProvider.getData!.organization.toString();
    setState(() {});
  }

  String _image = '';

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // context.read<StngsVmC>().setProfilePathVmF(pickedFile.path);
      setState(() {
        _image = pickedFile.path;
      });
      updateProfileImageF();
    }
  }

  // userInfoUpdate(BuildContext context, AuthProviders authProviders) {
  //   authProviders.userInfoUpdate(
  //       _nameController.text.trim(),
  //       _emailController.text.trim(),
  //       _phoneController.text.trim(),
  //       _professionController.text.trim(),
  //       _organizationController.text.trim(), (status) {
  //     if (status) {
  //       authProviders.getUserData(context);
  //       Navigator.pop(context);
  //       Helper.showSnack(context, 'Account updated successfully');
  //     } else {
  //       Helper.showSnack(context, 'Account update was unsuccessfull');
  //     }
  //   }, context);
  // }
  getUserID() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(AppConstant.userID) ?? '';
  }

  updateProfileImageF() async {
    try {
      final userid = await getUserID();
      String apiUrl =
          '${AppConstant.baseUrl}${AppConstant.updateProfileImage}$userid';
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('file', _image));
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var bodydata = jsonDecode(responseString);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(bodydata.toString())));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${response.statusCode}")));
        print('Error uploading image: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
      debugPrint("👉 when update profile image");
    }
  }

  updateAuthF() async {
    try {
      final userid = await getUserID();
      String apiUrl =
          '${AppConstant.baseUrl}${AppConstant.userActive}${userid}';
      final response = await http.put(Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "name": _nameController.text.trim(),
            "phone": _phoneController.text.trim(),
            "email": _emailController.text.trim(),
            "profession": _professionController.text.trim(),
            "organization": _organizationController.text.trim()
          }));

      if (response.statusCode == 200) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2 / 1,
                      height: MediaQuery.of(context).size.width * 0.3 / 1,
                      child: Center(
                          child: CircularProgressIndicator.adaptive(
                        backgroundColor: context.watch<StngsVmC>().isDarkMode
                            ? Colors.white
                            : Colors.blueGrey.shade200,
                      ))));
            });
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pop(context);
        Helper.showSnack(context, 'Account update was successfull');
        print('User updated successfully');
      } else {
        Helper.showSnack(context, "${response.body}");
        // print('Failed to update user. Status code: ${response.statusCode}');
        // print('Response body: ${response.body}');
      }
    } catch (e) {
      Helper.showSnack(context, 'Account update was unsuccessfull');
      // debugPrint("error in profile update function : $e");
    }
  }
  // updateAuthF() async {
  //   try {
  //     String apiUrl =
  //         '${AppConstant.baseUrl}${AppConstant.userActive}${getUserID()}';
  //     var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
  //     request.files.add(await http.MultipartFile.fromPath('userImage', _image));
  //     request.fields['name'] = _nameController.text.trim();
  //     request.fields['email'] = _emailController.text.trim();
  //     request.fields['phone'] = _phoneController.text.trim();
  //     request.fields['profession'] = _professionController.text.trim();
  //     request.fields['organization'] = _organizationController.text.trim();
  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       Helper.showSnack(context, 'Account updated successfully');
  //     } else {
  //       var responseData = await response.stream.toBytes();
  //       var responseString = String.fromCharCodes(responseData);
  //       var bodydata = jsonDecode(responseString);
  //       // debugPrint("💥: ${bodydata.toString()} ");
  //       Helper.showSnack(context, 'Account update was unsuccessfull');
  //     }
  //   } catch (e) {
  //     Helper.showSnack(context, 'Account update was unsuccessfull');
  //     debugPrint("error in profile update function : $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProviders>(builder: (context, authProviders, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              title: 'Edit Profile'.tr), // Pass the desired title here
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ClipOval(
                        child: _image.isNotEmpty
                            ? Image.file(
                                File(_image),
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              )
                            : Image.network(widget.profileImageLink!,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset('lib/photos/images/user1.png',
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.cover))),
                    Container(
                      margin: const EdgeInsets.all(0.0),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  height: 40,
                  // Set the desired height
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _nameController,
                    cursorColor: const Color.fromRGBO(4, 157, 204, 1),
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(fontSize: 10),
                      contentPadding:
                          const EdgeInsets.only(top: 5, left: 15, right: 15),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(4, 157, 204, 1),
                          ), // Border color when focused
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: context.watch<StngsVmC>().isDarkMode
                                ? Colors.blueGrey.shade200
                                : Colors
                                    .black), // Border color when not focused
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                        (Set<MaterialState> states) {
                          final Color color =
                              states.contains(MaterialState.error)
                                  ? Theme.of(context).colorScheme.error
                                  : const Color.fromRGBO(4, 157, 204, 1);
                          return TextStyle(color: color, letterSpacing: 1.3);
                        },
                      ),
                      hintText: "Demo Name".tr,
                      labelText: "Name".tr,
                      labelStyle: TextStyle(
                          color: context.watch<StngsVmC>().isDarkMode
                              ? Colors.blueGrey.shade200
                              : Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 40, // Set the desired height
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _emailController,
                    cursorColor: const Color.fromRGBO(4, 157, 204, 1),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 5, left: 15, right: 15),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(4, 157, 204, 1),
                            ), // Border color when focused
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: context.watch<StngsVmC>().isDarkMode
                                    ? Colors.blueGrey.shade200
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                            final Color color =
                                states.contains(MaterialState.error)
                                    ? Theme.of(context).colorScheme.error
                                    : const Color.fromRGBO(4, 157, 204, 1);
                            return TextStyle(color: color, letterSpacing: 1.3);
                          },
                        ),
                        hintText: "Exanple@gmail.com",
                        labelText: "Email".tr,
                        hintStyle: TextStyle(color: Colors.blueGrey.shade200),
                        labelStyle: TextStyle(
                            color: context.watch<StngsVmC>().isDarkMode
                                ? Colors.blueGrey.shade200
                                : Colors.black)),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 40, // Set the desired height
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _phoneController,
                    cursorColor: const Color.fromRGBO(4, 157, 204, 1),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 5, left: 15, right: 15),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(4, 157, 204,
                                    1)), // Border color when focused
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: context.watch<StngsVmC>().isDarkMode
                                    ? Colors.blueGrey.shade200
                                    : Colors
                                        .black), // Border color when not focused
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                            final Color color =
                                states.contains(MaterialState.error)
                                    ? Theme.of(context).colorScheme.error
                                    : const Color.fromRGBO(4, 157, 204, 1);
                            return TextStyle(color: color, letterSpacing: 1.3);
                          },
                        ),
                        hintText: "123455789",
                        labelText: "Phone".tr,
                        hintStyle: TextStyle(color: Colors.blueGrey.shade200),
                        labelStyle: TextStyle(
                            color: context.watch<StngsVmC>().isDarkMode
                                ? Colors.blueGrey.shade200
                                : Colors.black)),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 40, // Set the desired height
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _professionController,
                    cursorColor: const Color.fromRGBO(4, 157, 204, 1),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 5, left: 15, right: 15),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(4, 157, 204, 1),
                            ), // Border color when focused
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: context.watch<StngsVmC>().isDarkMode
                                    ? Colors.blueGrey.shade200
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                            final Color color =
                                states.contains(MaterialState.error)
                                    ? Theme.of(context).colorScheme.error
                                    : const Color.fromRGBO(4, 157, 204, 1);
                            return TextStyle(color: color, letterSpacing: 1.3);
                          },
                        ),
                        hintText: "Demo Profession".tr,
                        labelText: "Profession".tr,
                        hintStyle: TextStyle(color: Colors.blueGrey.shade200),
                        labelStyle: TextStyle(
                            color: context.watch<StngsVmC>().isDarkMode
                                ? Colors.blueGrey.shade200
                                : Colors.black)),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 40, // Set the desired height
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: _organizationController,
                    cursorColor: const Color.fromRGBO(4, 157, 204, 1),
                    decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 5, left: 15, right: 15),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(4, 157, 204,
                                    1)), // Border color when focused
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: context.watch<StngsVmC>().isDarkMode
                                    ? Colors.blueGrey.shade200
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                            final Color color =
                                states.contains(MaterialState.error)
                                    ? Theme.of(context).colorScheme.error
                                    : const Color.fromRGBO(4, 157, 204, 1);
                            return TextStyle(color: color, letterSpacing: 1.3);
                          },
                        ),
                        hintText: "Organization".tr,
                        labelText: "Organization".tr,
                        hintStyle: TextStyle(color: Colors.blueGrey.shade200),
                        labelStyle: TextStyle(
                            color: context.watch<StngsVmC>().isDarkMode
                                ? Colors.blueGrey.shade200
                                : Colors.black)),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await updateAuthF();
                        // userInfoUpdate(context, authProviders);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(56, 199, 243, 1),
                            Color.fromRGBO(4, 157, 204, 1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: CustomText(
                        title: "Update".tr,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomInkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: context.watch<StngsVmC>().isDarkMode
                            ? Colors.blueGrey.shade700
                            : Colors.white,
                        border: Border.all(color: Colors.red),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        // gradient: LinearGradient(
                        //   begin: Alignment.topLeft,  // You can adjust the gradient's direction
                        //   end: Alignment.bottomRight,
                        //   colors: [newBlueColor.withOpacity(0.6), newBlueColor],  // Replace with your desired colors
                        // ),
                      ),
                      child: CustomText(
                        title: "Cancel".tr,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    });
  }
}
