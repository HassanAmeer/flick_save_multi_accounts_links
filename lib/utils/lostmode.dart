import 'package:flick/Model/Auth/get_user_data.dart';
import 'package:flick/utils/appButtons.dart';
import 'package:flick/utils/whiteButtons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/directtoggleVm.dart';
import 'package:flick/provider/auth.dart';

import '../widgets/listtilemode.dart';
import 'constants.dart';
import 'package:get/get.dart';

class LostModeModal extends StatefulWidget {
  const LostModeModal({super.key});

  @override
  State<LostModeModal> createState() => _LostModeModalState();
}

class _LostModeModalState extends State<LostModeModal> {
  TextEditingController lostmodeDetailsContr = TextEditingController();

  // Provider.of<AuthProviders>(context, listen: false).
  // authProvider.getData!

  bool isPrivateModeSwitched = false;
  @override
  void initState() {
    super.initState();
    getLostModeF();
  }

  getLostModeF() async {
    GetUserData? authProvider =
        await Provider.of<AuthProviders>(context, listen: false).getData;
    isPrivateModeSwitched = authProvider!.isEnabledLostMode!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Color containerColor = const Color.fromARGB(255, 232, 233, 233);

    return Container(
      height: height * 0.5,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Lost Mode".tr,
                style: TextStyle(fontSize: 20, fontFamily: 'CarosMedium'),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTileMode(
                leading: Image(
                  image: AssetImage('lib/photos/images/block.png'),
                  height: 30,
                  width: 30,
                ),
                title: "Deactivate Flick".tr,
                subtitle:
                    "this will make your profile hidden and your flick will not be accessible by anyone"
                        .tr,
                trailing: Switch(
                  value: isPrivateModeSwitched,
                  onChanged: (value) {
                    setState(() {
                      isPrivateModeSwitched = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    isPrivateModeSwitched = !isPrivateModeSwitched;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: null,
                controller: lostmodeDetailsContr,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  errorBorder: InputBorders.error,
                  focusedErrorBorder: InputBorders.error,
                  focusedBorder: InputBorders.focused,
                  border: const OutlineInputBorder(),
                  labelText: 'Custom Message'.tr,
                  hintText: "Add your Customer Message here".tr,
                  floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                    (Set<MaterialState> states) {
                      final Color color = states.contains(MaterialState.error)
                          ? Theme.of(context).colorScheme.error
                          : const Color.fromRGBO(4, 157, 204, 1);
                      return TextStyle(color: color, letterSpacing: 1.3);
                    },
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppButton(
                  title: "Update".tr,
                  onpress: () async {
                    context.read<ToggleDirectModeVmC>().toggleLostMode(context,
                        isPrivateModeSwitched, lostmodeDetailsContr.text);
                  }),
              const SizedBox(
                height: 10,
              ),
              AppDeActivateButton(
                  title: "Cancel".tr,
                  onpress: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
