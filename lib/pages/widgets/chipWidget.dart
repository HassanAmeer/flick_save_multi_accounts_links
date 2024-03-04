import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/custom_inkwell_btn.dart';
import '../../utils/custom_text.dart';

class ChipWidget extends StatelessWidget {
  final bool? visibility;
  final String? imgPath;
  final String? label;
  final VoidCallback? onTap;
  const ChipWidget(
      {super.key, this.visibility, this.label, this.onTap, this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Visibility(
        visible: visibility!,
        child: CustomInkWell(
          onTap: onTap!,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.52,
            // padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Colors.grey.withOpacity(0.4))),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Image.asset(
                  imgPath!,
                  scale: 20,
                ),
                const SizedBox(width: 10),
                CustomText(
                    title: label!,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    fontFamily: 'CarosLight'),
                const Spacer(),
                Container(
                    padding: Get.locale?.languageCode == 'ar'
                        ? const EdgeInsets.only(left: 7)
                        : const EdgeInsets.only(right: 7),
                    child: const Icon(
                      Icons.add_circle,
                      color: Colors.grey,
                      size: 20,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
