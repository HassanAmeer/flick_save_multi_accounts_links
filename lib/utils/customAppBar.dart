import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/stngsVm.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0.0,
      flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
          child: Container(
              decoration: BoxDecoration(
                  gradient: context.watch<StngsVmC>().isDarkMode
                      ? const LinearGradient(
                          colors: [
                            Color.fromRGBO(16, 145, 185, 1),
                            Color.fromRGBO(0, 89, 117, 1),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        )
                      : const LinearGradient(
                          colors: [
                              Color.fromRGBO(56, 199, 243, 1),
                              Color.fromRGBO(4, 157, 204, 1)
                            ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)))),
      title: Center(
          child: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontFamily: context.watch<StngsVmC>().isLanIsEngMode
                ? 'CarosLight'
                : "NotoKufi",
            fontSize: 18,
            // fontFamily: 'CarosLight',
            fontWeight: FontWeight.bold,
            letterSpacing: context.watch<StngsVmC>().isLanIsEngMode ? 3 : 0),
      )),
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
